#!/bin/sh
bin/trivia_for_testing 7777 > spec/runs/test-run-7777.txt
diff spec/runs/test-run-7777.txt spec/runs/golden-master.txt