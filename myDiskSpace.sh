
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

for extension in "${extensions[@]}"; do echo "$extension"; done

