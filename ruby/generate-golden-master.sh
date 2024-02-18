#!/bin/sh

seeds=()

# Generate 100 random seeds and store them in the array
for ((i=0; i<=400; i++)); do
    number=$((7777 + (i * 100)))
    seeds+=($number)
done

for seed in "${seeds[@]}"
do
  bin/trivia_for_testing $seed > spec/runs/golden-master-$seed.txt
done