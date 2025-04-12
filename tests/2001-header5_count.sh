#!/bin/sh

utils/generate-test-input.sh 5 100 0 | ./summary --header 5 --count --count-skipped --count-matched
