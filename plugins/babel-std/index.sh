#!/usr/bin/env bash


WHICH_SUMAN_TOOLS=$(which suman-tools);
if [[ -z ${WHICH_SUMAN_TOOLS} ]]; then
  npm install -g suman-tools
fi

export PATH=${SUMAN_PROJECT_ROOT}/node_modules/.bin:${PATH}:~/.suman/global/node_modules/.bin

echo "PATH in babel-std => $PATH"

WHICH_BABEL=$(which babel);

if [[ -z ${WHICH_BABEL} ]]; then
   echo "babel could not be found on your PATH";
   exit 1;
fi


for x in $(suman-tools --extract-json-array=${SUMAN_TEST_PATHS}); do

    SUMAN_TARGET="${x//@src/@target}"
    SUMAN_TARGET=${SUMAN_TARGET%.*}.js

    if [[ ${SUMAN_TARGET} -nt ${x} ]]; then
        echo "no need to transpile since the transpiled file is correct."
    else
        echo "we must transpile file."
        OUT_DIR="$(dirname $(dirname ${x}))/@target"
        tsc ${x} --outDir ${OUT_DIR}
        chmod -R 777 ${OUT_DIR}
    fi

done