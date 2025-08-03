#!/bin/bash
read -p "Enter the filename: " file
if [ ! -e "$file" ]; then
	echo "The file does not exist"
	exit 1
fi
if [ ! -f "$file" ]; then
	echo "the file exist but it is not regular"
	exit 2
fi
if [ ! -s "$file" ]; then
	echo "The file is a regular file but it's empty"
	exit 3
fi
echo "The file "$file" exists, is a regular file , and is not empty"
