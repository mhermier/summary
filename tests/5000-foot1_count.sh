#!/bin/sh

utils/generate-test-input.sh 0 100 0 | ./summary --foot 1 --count --count-skipped --count-matched
