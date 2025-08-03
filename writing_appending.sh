# Combined Script for Writing and Appending with case
#!/bin/bash
read -p "Enter a file name:  " file
read -p "Enter the message: " message

echo "Do you want to: "
echo "1. overwrite the file"
echo "2.Append to the file"
read -p "Choose 1 or  2: " choice

show_file_contents(){
	echo "-------File Contents--------"
	cat "$file"
	echo "----------------------------"
}

case $choice in 
	1)
		echo "$message" > "$file"
		echo "File overwritten"
		show_file_contents
		;;
	2)
		echo "$message" >> "$file"
		echo "Message appended"
		show_file_contents
		;;
	*)
		echo "Invalid choice.Please enter 1 or 2 "
		exit 1
		;;
esac
