#!/usr/bin/bash

set -e

NPM_SHRINKWRAP="npm-shrinkwrap.json"

if test -f "${NPM_SHRINKWRAP}"; then
  rm "${NPM_SHRINKWRAP}"
  printf "Old '%s' file removed! \n" "${NPM_SHRINKWRAP}"
fi

npm i

npm shrinkwrap
