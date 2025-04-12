#!/bin/sh

utils/generate-test-input.sh 0 100 1 | ./summary --footer 1 --count --count-skipped --count-matched
