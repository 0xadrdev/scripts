
#! /bin/bash


if [ $# -lt 2 -o $# -gt 3 ]; then
	echo "Modo de uso: $0 ficheroConexiones user [ mes ]"
	exit 0
fi

if ! [ -f "$1" ]; then
	echo "Ruta $1 no existe o bien no corresponde a un fichero"
	exit 0
fi

if [ "$2" = "reboot" ]; then
	echo "Usuario no válido: $2"
	exit 0
fi

file="$1"
total_time_min=0
host_max=0
max=0

while read USER TERMINAL DAY_WEEK MONTH DAY_MONTH INIT GUION FINAL TIME IP
do

	MIN=${TIME#*:}
	MIN=${MIN%)*}

	HOURS=${TIME%:*}
	HOURS=${HOURS#*(}

#	echo $HOURS
#	echo $MIN

	if [ $MIN -le 09 ]; then
		MIN=${MIN#0}
	fi < /dev/null > /dev/null 2>&1

	if [ $HOURS -le "09" ]; then
		HOURS=${HOURS#0}
	fi < /dev/null > /dev/null 2>&1

	let TIME=MIN
	let TIME+=HOURS*60

	if [ "$2" = $USER ]; then
#		echo "$USER $MONTH $TIME $IP"

		if [ "$3" = "$MONTH" ]; then

			let total_time_min=TIME+total_time_min

			if [ $max -lt $TIME ]; then
				max=$TIME
				host_max=$IP
				max_hour=$HOURS
				max_min=$MIN
			fi
		elif [ "$3" = "" ]; then
			let total_time_min=TIME+total_time_min
			if [ $max -lt $TIME ]; then
				max=$TIME
				host_max=$IP
				max_hour=$HOURS
				max_min=$MIN
			fi
		fi

#		echo $total_time_min
	fi
done < $file

if [ $total_time_min -eq 0 ];then

	echo "El usuario $2 no se ha conectado en el periodo indicado"
	exit

fi

echo  "El usuario $2 ha estado conectado un total de:"

let HOURS=total_time_min/60
let MIN=total_time_min-HOURS*60

echo -e "\t* $HOURS horas y $MIN minutos\n"
echo -e "Tiempo máximo de conexión: $max_hour horas y $max_min minutos desde $host_max"

