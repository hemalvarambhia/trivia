#!/bin/sh
seed=7777
bin/trivia_for_testing $seed > spec/runs/test-run-$seed.txt
diff spec/runs/test-run-$seed.txt spec/runs/golden-master.txt