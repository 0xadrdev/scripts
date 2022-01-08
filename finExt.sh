#/bin/bash
count=0
suma=1
if [ $# -lt 1 ]; then 
      
	echo "Modo de uso $0 extension [ directorio_1 ] [ directorio_2 ] ... [ directorio_n ] "
	exit 1
fi

if [ $# -eq 1 ]; then
   
	FOLDER="."
	if [ -d "$FOLDER" ]; then
		file=$(mktemp)
		ls -l "$FOLDER" | grep -v ^total > $file
		while read f1 f2 f3 f4 f5 f6 f7 f8 FILENAME
		do
		ext=${FILENAME#*.}
		if [ "$ext" = "$1" -a -f "$FOLDER/$FILENAME" ]; then
			echo "Encontrado fichero: $FILENAME en directorio activo"
			let count=count+suma
		fi

		done < $file
		rm "$file"
	fi
else

	v=("$@")

	num_dir=$[${#v[*]}-1]

		for i in $(seq 1 $num_dir); do

			FOLDER="${v[i]}"
			if [ -d "$FOLDER" ]; then

				file=$(mktemp)
				ls -l "$FOLDER" | grep -v ^total > $file

				while read f1 f2 f3 f4 f5 f6 f7 f8 FILENAME
				do
				ext=${FILENAME#*.}

				if [ "$ext" = "$1" -a -f "$FOLDER/$FILENAME" ]; then
					echo "Encontrado fichero: $FILENAME en directorio: $FOLDER"
					let count=count+suma
				fi

				done < $file
				rm "$file"
			fi

		done

fi
if [ $count -eq 0 ]; then
	echo -e "\nNo se ha encontra ningún fichero con la extensión: $1"
elif [ $count -eq 1 ]; then
	echo "Se ha encontrado un fichero"
else
	echo -e "\nSe han encontrado $count ficheros"
fi
