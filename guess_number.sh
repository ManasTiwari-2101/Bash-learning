#!/bin/bash

target=$(( RANDOM % 10 + 1 ))
guess=0

while [ "$guess" -ne "$target" ]; do
    read -p "Guess the number (1–10): " guess

    if [ "$guess" -lt "$target" ]; then
        echo "Too low"
    elif [ "$guess" -gt "$target" ]; then
        echo "Too high"
    fi
done

echo "Correct! You guessed correctly."
