#!/bin/bash

# https://google.github.io/styleguide/shellguide.html

DIR='.'
DEBUG='false'
OUT='out'

print_usage () {
  printf "Usage: $0 -d <DIRECTORY> -o <DIRECTORY> [-v]"
}

run () {
	for file in $(find ${DIR} -maxdepth 1 -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do
		f=$(basename $file)
		if [ $DEBUG == "true" ]; then
			echo "$file -> ${OUT}/$f"
		else
			ln -sfn $file ${OUT}/$f
		fi
	done
}

while getopts 'd:o:v' flag; do
  case "${flag}" in
    d) DIR="${OPTARG}" ;;
    o) OUT="${OPTARG}" ;;
    v) DEBUG='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done

run
