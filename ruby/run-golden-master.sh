#!/bin/sh
bin/trivia_for_testing > spec/test-run-2024.txt
diff spec/test-run-2024.txt spec/golden-master.txt
rm spec/test-run-2024.txt