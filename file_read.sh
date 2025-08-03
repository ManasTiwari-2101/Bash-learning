#!/bin/bash
read -p "Enter a file name: " file
if [ -f "$file" ] && [ -s "$file" ]; then
	echo "File is valid.Reading contents....."
else
	echo "Error: File doesn't exists, is not a regular file, or is empty"
	exit 1
fi

while IFS= read -r line
do
	echo "Line: $line"
done < "$file"
