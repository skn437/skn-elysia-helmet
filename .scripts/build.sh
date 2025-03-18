#!/usr/bin/bash

set -e

DIST="dist"

if test -d "${DIST}"; then
  rm -rf "${DIST}"
  printf "Old '%s' directory removed! \n" "${DIST}"
fi

npm run build
