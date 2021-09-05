#!/bin/bash

DIR='.'

print_usage () {
  printf "Usage: $0 -d <DIRECTORY>"
}

run() {
  # nothing
}

while getopts 'd:o:v' flag; do
  case "${flag}" in
    d) DIR="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

run
