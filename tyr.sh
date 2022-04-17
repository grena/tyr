#!/bin/bash

# Detect if running on CE, EE, onboarder...
TYR_SOFTWARE=$(
  cat composer.json \
  | grep name \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[", ]//g' \
  | sed 's/akeneo\///g');

# Detect version of the PIM
[[ -f CHANGELOG-5.0.md ]] && TYR_VERSION="5.0" && \
[[ -f CHANGELOG-6.0.md ]] && TYR_VERSION="6.0" && \
[[ -f CHANGELOG.md ]] && TYR_VERSION="master"

curl "https://tyr-test.herokuapp.com/find?file=$1&software=$TYR_SOFTWARE&version=$TYR_VERSION"
