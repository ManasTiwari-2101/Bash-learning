#!/bin/bash

# Step 1: Ask for filename
read -p "Enter the filename: " file

# Step 2: Check if file exists and is not empty
if [[ ! -e "$file" ]]; then
    echo "Error: File does not exist!"
    exit 1
elif [[ ! -s "$file" ]]; then
    echo "Error: File exists but is empty!"
    exit 2
fi

# Step 3: Show line, word, and character counts
lines=$(wc -l < "$file")
words=$(wc -w < "$file")
chars=$(wc -m < "$file")

echo "-----------------------------"
echo "File: $file"
echo "Lines      : $lines"
echo "Words      : $words"
echo "Characters : $chars"
echo "-----------------------------"
