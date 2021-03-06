
#/bin/bash

if ! [ $# -eq 2 ]; then

	echo "Modo de uso: $0 directorio audio|imagen|office|video"
	exit
fi

if ! [ -d "$1" ]; then
	echo "Ruta $1 no existe o bien no corresponde a un directorio"
	exit
fi

dir="$1"
type="$2"

case $type in
	audio) extensions=(mp3 ogg wav);;
	imagen) extensions=(jpeg jpg png gif);;
	office) extensions=(doc odt xls ods);;
	video) extensions=(avi mkv mp4);;
	*) echo "Tipo de ficheros no permitido: $type"
	   exit
esac

#for extension in "${extensions[@]}"; do echo "$extension"; done

file=$(mktemp)
ls -l "$dir" | grep -v ^total > $file
totalStorage=0

while read f1 f2 f3 f4 tamfich f6 f7 f8 nomfich
do

	if [ -f "$dir/$nomfich" ]; then

		extNomFich=${nomfich#*.}

		for extension in "${extensions[@]}"; do
			if [ "$extension" = "$extNomFich" ]; then
				let totalStorage=tamfich+totalStorage
			fi
		done
	fi
done < $file

let mebi=1024*1024

totalStorageMib=$(echo "scale=2; $totalStorage/$mebi" | bc -l)

echo "Los ficheros del tipo $type ocupan $totalStorageMib Mebibytes en el directorio $dir"

rm $file
