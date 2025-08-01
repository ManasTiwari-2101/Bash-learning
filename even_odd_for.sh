#!/bin/bash

for i in $(seq 1 10)
do
  if [ $((i % 2)) -eq 0 ]; then
    echo "$i is even"
  else
    echo "$i is odd"
  fi
done

# this one is to learn new method
