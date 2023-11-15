#!/bin/sh

bin/trivia > spec/test-run.txt
diff spec/golden-master.txt spec/test-run.txt
rm spec/test-run.txt