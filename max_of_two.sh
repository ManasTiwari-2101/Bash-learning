#!/bin/bash
# Function to return the maximum of two numbers

max_of_two() {
    if [ "$1" -gt "$2" ]; then
        echo "$1"
    elif [ "$1" -lt "$2" ]; then
        echo "$2"
    else
        echo "they are equal"
    fi
}

result=$(max_of_two 10 4)
echo "Maximum is: $result"
