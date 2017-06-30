#!/usr/bin/env bash

echo "running transform process";
echo "using plugin with name ${SUMAN_PLUGIN_NAME}";

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

    if [[ ${SUMAN_TARGET} -nt ${x} ]]; then
        echo "no need to transpile since the transpiled file is ready."
    else
        echo "we must transpile file."
        OUT_DIR="$(dirname $(dirname ${x}))/@target"
        tsc ${x} --outDir ${OUT_DIR}
        chmod -R 777 ${OUT_DIR}
    fi

done