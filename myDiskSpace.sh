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

