#!/usr/bin/env bash

shopt -s globstar

GREEN='\033[32;1m'
RED='\033[31;1m'
NC='\033[0m'

UNITTEST_TEST_SUCCEDED=0
UNITTEST_TEST_INVALID=1
UNITTEST_TEST_EXECUTION_FAILED=2
UNITTEST_TEST_OUTPUT_MISSMATCHED=3

unittest_runner() {
  local test_path="${1}"

  if [ -z "${test_path}" -o ! -x "${test_path}" ]; then
    return ${UNITTEST_TEST_INVALID}
  fi

  "$test_path" >"$test_path".out 2>"$test_path".err
  if [ $? -ne 0 ]; then
    return ${UNITTEST_TEST_EXECUTION_FAILED}
  fi

  local succeded
  if ! cmp -s "$test_path".out "$test_path".out.expected; then
    succeded=${UNITTEST_TEST_OUTPUT_MISSMATCHED}
  elif [ -e "$test_path".err.expected ]; then
    if ! cmp -s "$test_path".err "$test_path".err.expected; then
      succeded=${UNITTEST_TEST_OUTPUT_MISSMATCHED}
    fi
  else
    if [ -s "$test_path".err ]; then
      succeded=${UNITTEST_TEST_OUTPUT_MISSMATCHED}
    fi
  fi

  if [ "$unittest_update_expected" = y ]; then
    rm -f "$test_path".out.expected "$test_path".err.expected
    cp "$test_path".out "$test_path".out.expected
    if [ -s "$test_path".err ]; then
      cp "$test_path".err "$test_path".err.expected
    fi
  fi

  return ${succeded:-$UNITTEST_TEST_SUCCEDED}
}

unittest_runner_verbose() {
  local test_path="${1}"

  diff -Nau "$test_path".out "$test_path".out.expected
  diff -Nau "$test_path".err "$test_path".err.expected
}

unittest_run_one() {
  unittest_count=$(expr ${unittest_count} + 1)

  local message="${1}"
  shift
  echo -ne "[ ] ${message}\r"

  local test_runner="$1"
  local test_path="$2"
  "$@"
  local succeded=$?

  if [ ${succeded} -eq ${UNITTEST_TEST_SUCCEDED} ]; then
    unittest_succeded=$(expr $unittest_succeded + 1)
    echo -e "[${GREEN}✓${NC}"
  else
    unittest_failed=$(expr $unittest_failed + 1)
    echo -e "[${RED}✗${NC}"
  fi

  case ${succeded} in
    ${UNITTEST_TEST_SUCCEDED})
      ;;
    ${UNITTEST_TEST_INVALID})
      echo -e "${RED}Invalid unittest${NC}: ${test_path}"
      ;;
    ${UNITTEST_TEST_EXECUTION_FAILED})
      echo -e "${RED}Unittest execution failed${NC}: ${test_path}"
      ;;
    ${UNITTEST_TEST_OUTPUT_MISSMATCHED})
      echo -e "${RED}Unittest output missmached${NC}: ${test_path}"
      ;;
    *)
      echo -e "${RED}Invalid test succeded value${NC}: ${succeded}" >&2
  esac

  if [ "$unittest_verbose" = y ]; then
    "$1"_verbose "${@:2}"
  fi

  return $succeded
}

unittest_run() {
  local unittest_count=0
  local unittest_failed=0
  local unittest_succeded=0

  local unittest_update_expected=n
  local unittest_verbose=n

  while [ $# -gt 0 ]; do
    case "$1" in
      --update)
          unittest_update_expected=y
          ;;
      -v|--verbose)
          unittest_verbose=y
          ;;
      --|*)
          # End of options
          break
          ;;
    esac
    shift
  done

  if [ $# -eq 0 ]; then
    set -- tests/**/*.sh
    if [ $# -eq 0 ]; then
      return 1
    fi
  fi
  for test in "$@"; do
    unittest_run_one "Checking $test" unittest_runner "$test"
  done

  echo
  echo -e "${GREEN}${unittest_succeded}${NC}/${unittest_count} unittests succeded"
  if [ $unittest_failed -gt 0 ]; then
    echo -e "${RED}${unittest_failed}${NC} unittests failed"
    return 1
  fi
  return 0
}

unittest_run "$@"
exit $?

