#!/bin/sh

for ((i=0; i<=500; i++));
do
  seed=$((7777 + (i * 100)))
  bin/trivia_for_testing "$seed" > spec/runs/test-run-"$seed".txt
  diff spec/runs/test-run-"$seed".txt spec/runs/golden-master-"$seed".txt
done