#Reading File Line-by-Line with Line Numbers
#!/bin/bash
read -p "Enter a filename" file
if [ -f "$file" ] && [ -s "$file" ]; then
	echo "File is valid, reading..."
else
	echo "File doesn't exist, is not regular file , or is empty"
	exit 1
fi

count=1
while IFS= read -r line
do
	echo "$count : $line"
	((count++))
done < "$file"
