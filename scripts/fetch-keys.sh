#!/bin/bash

EMAIL=''

print_usage () {
  printf "Usage: $0 -e <EMAIL>" 
}

run () {
	eval $(op signin my $EMAIL)
	gpg --import <(op get document gpgpub.asc)
	gpg --import <(op get document gpgpriv.asc)
}

while getopts 'd' flag; do
  case "${flag}" in
    e) EMAIL="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

run
