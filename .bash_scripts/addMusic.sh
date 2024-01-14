#!/usr/bin/env python3


#--header="string"
#--info="hidden/inlinde"
#-prompt="string"

# Сохраняем аргументы в переменные
key="$1"

true=1
false=0

default="$true"
help="$false"

# KEY: -h
if [ "$key" == "-h" ]; then
    	echo -e "    принимает МАСКУ и ПУТЬ\n    Перемещает файлы по маске из ~/Downloads в указанную папку\n    Лучше вводить маску в кавычках\n    Лучше вводить полный путь или от домашней папки\n"
    	echo -e "    -h\n            Вызвать справку\n\n"
    	echo -e "    -pool\n            принимает только МАСКУ\n            Перемещает файлы в годовой албом\n\n"
		echo -e "    -here\n            принимает только МАСКУ\n            Перемещает файлы в текущую директорию\n\n"
    	help="$true"
fi


# KEY: -pool
if [ "$key" == "-pool" ]; then
    	year=$(date +%Y)
    	newdir="$year pool"
	path="$HOME/Music/music/Music archive/$newdir"
   	mkdir -p "$path"
	default="$false"
fi


# KEY: -here
if [ "$key" == "-here" ]; then
	path=$(pwd)
	default="$false"
fi


# DEFAULT
if [ "$help" == "$false" ]; then
	if [ "$default" == "$true" ]; then
		path="$key"
	fi
	mask="$2"
	echo "$mask"
	echo "$path"
	if [ "$#" -ne 2 ]; then
 	 	 echo -e "    Ошибка ввода,\n    -h для помощи"
	fi

	currentpath=$(pwd)
	cd /home/heavenmaido/Downloads || exit 1
	find . -type f -name *"$mask"* | while IFS= read -r file; do
		echo "$file"
		mv "$file" "$path"
	done
	cd "$currentpath"
	echo "/Downloads/ -> $mask -> $path"
	exec puddletag "$path" &
fi

$SHELL



