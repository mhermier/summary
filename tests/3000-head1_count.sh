#!/bin/sh

utils/generate-test-input.sh 0 100 0 | ./summary --head 1 --count --count-skipped --count-matched
