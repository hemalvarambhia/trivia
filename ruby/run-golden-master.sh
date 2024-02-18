#!/bin/sh

seeds=()

# Generate 100 random seeds and store them in the array
for ((i=0; i<=500; i++)); do
    number=$((7777 + (i * 100)))
    seeds+=($number)
done

for ((i=0; i<=500; i++));
do
  seed=$((7777 + (i * 100)))
  bin/trivia_for_testing "$seed" > spec/runs/test-run-"$seed".txt
  diff spec/runs/test-run-"$seed".txt spec/runs/golden-master-"$seed".txt
done