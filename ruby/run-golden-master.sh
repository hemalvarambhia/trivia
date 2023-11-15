#!/bin/sh

bin/trivia > spec/test-run.txt
diff spec/test-run-1.txt spec/test-run.txt
rm spec/test-run.txt