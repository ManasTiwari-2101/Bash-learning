#!/bin/bash

password="secret"
input=""

until [ "$input" = "$password" ]; do
    read -sp "Enter password: " input
    echo ""
done

echo "Access granted."

# until is like till you input correct thing it will not stop 
