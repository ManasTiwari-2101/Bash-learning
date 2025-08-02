#!/bin/bash
# Function to greet user based on current time

greet_user() {
    local name=$1
    hour=$(date +%H)

    if (( hour < 12 )); then
        echo "Good morning, $name"
    elif (( hour < 18 )); then
        echo "Good afternoon, $name"
    else
        echo "Good evening, $name"
    fi
}
read -p "Enter your name" name
greet_user "$name"
