#!/bin/bash

main="error"
prime_default="false"
prime_all="false"
sel_file="error"
sel_dir="error"


opt1="Help"
opt2="Default"
opt3="Year pool"
opt4="All music"




show_help() {
  echo "This is a help messege"
}




# Выбор флага
selected_flags=$(echo -e "$opt1\n$opt2\n$opt3\n$opt4" | fzf --prompt="Choose mod: " --reverse --cycle)



# Обработка флагов
while read -r flag; do
	case "$flag" in
  	"$opt1")
    	show_help
	main="false"
    	;;
   	"$opt2")
      	prime_default="true"
		if [ "$prime_all" == "false" ]; then
			sel_file="true"
		fi
		sel_dir="true"
      	;;
    "$opt3")
		if [ "$prime_default" == "false" ]; then
			sel_dir="false"
			year=$(date +%Y)
    		newdir="$year pool"
			selected_directory="$HOME/Music/music/Music archive/$newdir"
   			mkdir -p "$selected_directory"
		fi
		if [ "$prime_all" == "false" ]; then
			sel_file="true"
		fi
	      ;;
    "$opt4")
		prime_all="true"
		sel_file="false"
		selected_files=$(find ~/Downloads -type f \( -iname "*.mp3" -o -iname "*.wav" -o -iname "*.flac" \))
      	;;
    *)
		echo "Некорректный флаг: $flag"
		main="false"
      	;;
  	esac
done <<< "$selected_flags"


if [ "$main" != "false" ]; then
# Обработка неправильных тегов | Приведение к дефолт стандарту
if [ "$sel_file" == "error" ]; then
	sel_file="true"
fi

if [ "$sel_dir" == "error" ]; then
	sel_dir="true"
fi

# Выбор файлов из папки Downloads
if [ "$sel_file" == "true" ]; then
	selected_files=$(find ~/Downloads -type f \( -iname "*.wav" -o -iname "*.mp3" -o -iname "*.flac" \) | fzf --multi --prompt="Choose files: ")
fi


# Проверка наличия выбранных файлов
if [ -z "$selected_files" ]; then
  echo "Expected files. Exit."
  exit 1
fi

# Выбор целевой директории
if [ "$sel_dir" == "true" ]; then
	selected_directory=$(find ~/Music/music -type d | fzf --no-multi --prompt="Choose directory:")
fi

# Проверка наличия выбранной директории
if [ -z "$selected_directory" ]; then
  echo "Expected directory. Exit."
  exit 1
fi

# Перемещение выбранных файлов в выбранную директорию
#mv "$selected_files" "$selected_directory"

echo "$selected_files" | while IFS= read -r file; do
  echo "$file"
  mv "$file" "$selected_directory"
  # Вставьте ваш код обработки файла здесь
done

echo "~/Downloads/ -> $selected_directory"
exec puddletag "$selected_directory" &
fi
