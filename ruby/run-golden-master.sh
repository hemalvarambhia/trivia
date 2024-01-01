#!/bin/sh
seed=7777
bin/trivia_for_testing $seed > spec/runs/test-run-$seed.txt
diff spec/runs/test-run-$seed.txt spec/runs/golden-master-$seed.txt

seeds=(7777 1111 9876)

for seed in "${seeds[@]}"
do
  bin/trivia_for_testing "$seed" > spec/runs/test-run-"$seed".txt
  diff spec/runs/test-run-"$seed".txt spec/runs/golden-master-"$seed".txt
done