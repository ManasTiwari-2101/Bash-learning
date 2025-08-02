#!/bin/bash
function fact() {
local f=1
for ((i=1;i<=$1;i++)); do
  f=$((f*i))
done

echo "$f"
}

read -p "Enter a number " num
fact "$num"
