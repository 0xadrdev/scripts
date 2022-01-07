#/bin/bash.sh


if [ $# -lt 2 ]; then

	echo "Modo de uso: ./creaFiches.sh folder number [ ext_1 ] [ ext_2 ] ... [ ext_n ]"
	exit 1

fi


case $2 in
	*[!0-9]*) echo "Se requiere un número entero, pero se ha proporcionado: $2"; exit 1;;
esac

if ! [ -f "$1" ]; then

	if [ -d "$1" ]; then
		FOLDER="$1"
	else
		mkdir "$1"
		FOLDER="$1"
	fi

else

	echo "Ya existe un fichero con ese nombre: $1"

fi

v=("$@")
num_ext=$[${#v[*]}-1]

if [ $num_ext -eq 1 -o $2 -eq 0 ]; then

	echo "No se crearon ficheros"
	exit 0

fi

for i in $(seq -w 1 $2); do
	for x in $(seq 2 $num_ext); do
		FILENAME="fiche$i.${v[$x]}"
		echo "$FILENAME"
		touch "$FOLDER/$FILENAME"
	done
done

num_ext=$[num_ext-1]
count=$[num_ext*$2]

echo "Se han creado $count ficheros"
