#!/bin/sh
bin/trivia_for_testing > spec/runs/test-run-2024.txt
diff spec/runs/test-run-2024.txt spec/runs/golden-master.txt