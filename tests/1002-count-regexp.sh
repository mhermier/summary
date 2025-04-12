#!/bin/sh

utils/generate-test-input.sh 5 100 5 | ./summary -H 5 -F 5 --count --count-skipped --count-matched --regexp 1
