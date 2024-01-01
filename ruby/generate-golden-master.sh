#!/bin/sh

seeds=(7777 1111 9876 12345 654321)

for seed in "${seeds[@]}"
do
  bin/trivia_for_testing $seed > spec/runs/golden-master-$seed.txt
done