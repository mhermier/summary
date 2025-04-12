#!/bin/sh

generate_inoput_file() {
  local header="$1"
  local entries="$2"
  local footer="$3"

  local i
  for i in $(seq "$header"); do
    echo "header-$i"
  done
  for i in $(seq "$entries"); do
    echo "entry-$i"
  done
  for i in $(seq "$footer"); do
    echo "footer-$i"
  done
}

generate_inoput_file "$@"

