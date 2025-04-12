#!/bin/sh

utils/generate-test-input.sh 1 100 0 | ./summary --header 1 --count --count-skipped --count-matched
