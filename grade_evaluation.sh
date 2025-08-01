#!/bin/bash

read -p "Enter marks (0–100): " marks

if ! [[ "$marks" =~ ^[0-9]+$ ]] || [ "$marks" -gt 100 ]; then
    echo "Invalid input!"
    exit 1
fi

if [ "$marks" -ge 90 ]; then
    echo "Grade: A+"
elif [ "$marks" -ge 75 ]; then
    echo "Grade: A"
elif [ "$marks" -ge 60 ]; then
    echo "Grade: B"
elif [ "$marks" -ge 40 ]; then
    echo "Grade: C"
else
    echo "Grade: F"
fi
