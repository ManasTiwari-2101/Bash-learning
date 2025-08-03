# Copy, Move, or Append One File into Another (Safe Version)
#!/bin/bash

echo "Choose an operation:"
echo "1. Copy a file"
echo "2. Move a file"
echo "3. Append one file into another"

read -p "Enter your choice (1/2/3): " choice

case $choice in
    1)
        read -p "Enter the source file path: " src
        read -p "Enter the target file path: " tgt
        if [ -f "$src" ]; then
            cp -i "$src" "$tgt"
            echo "Copy operation complete."
        else
            echo "Source file does not exist!"
            exit 1
        fi
        ;;
    2)
        read -p "Enter the file to move: " src
        read -p "Enter the destination path: " tgt
        if [ -f "$src" ]; then
            mv -i "$src" "$tgt"
            echo "Move operation complete."
        else
            echo "Source file does not exist!"
            exit 1
        fi
        ;;
    3)
        read -p "Enter the source file to append from: " src
        read -p "Enter the target file to append into: " tgt
        if [ -f "$src" ]; then
            if [ -f "$tgt" ]; then
                read -p "Target file exists. Append anyway? (y/n): " confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    cat "$src" >> "$tgt"
                    echo "Content appended successfully."
                else
                    echo "Append canceled."
                fi
            else
                echo "Target file does not exist."
                exit 1
            fi
        else
            echo "Source file does not exist!"
            exit 1
        fi
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac
