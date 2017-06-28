#!/usr/bin/env bash

WHICH_TSC=$(which tsc);
if [[ -z ${WHICH_TSC} ]]; then
  npm install -g typescript
fi

WHICH_SUMAN_TOOLS=$(which suman-tools);
if [[ -z ${WHICH_SUMAN_TOOLS} ]]; then
  npm install -g suman-tools
fi


for x in $(suman-tools --extract-json-array=${SUMAN_TEST_PATHS}); do

    SUMAN_TARGET="${x//@src/@target}"
    SUMAN_TARGET=${SUMAN_TARGET%.*}.js

    if [[ ${SUMAN_TARGET} -nt ${SUMAN_CHILD_TEST_PATH} ]]; then
        echo "no need to transpile since the transpiled file is correct."
    else
        echo "we must transpile file."
        tsc ${x} --outDir "$(dirname $(dirname ${x}))/@target" # transpile file with filepath ="x"
         # tsc $(pwd)/@src/*.ts --outDir $(pwd)/@target
        chmod -R 777 $(pwd)/@target
    fi

done