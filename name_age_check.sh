#!/bin/bash

read -p "What is your name? " name

if [[ -z "$name" || "$name" =~ ^[[:space:]]+$ ]]; then
    echo "Invalid name!"
    exit 1
fi

read -p "How old are you? " age

if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "Age must be a number!"
    exit 2
fi

echo "Welcome, $name. You are $age years old."
