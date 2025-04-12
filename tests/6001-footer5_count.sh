#!/bin/sh

utils/generate-test-input.sh 0 100 5 | ./summary --footer 5 --count --count-skipped --count-matched
