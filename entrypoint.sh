#!/bin/sh
set -e

# Navigate to the working directory
cd "${INPUT_WORKINGDIR:-.}"

# Find the template file
if ([ $INPUT_TEMPLATEFILE != *.json ] && [ ! -f "$INPUT_TEMPLATEFILE" ] ) ; then
    echo "${INPUT_TEMPLATEFILE} does not exit in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

# Find the var file file and it should be a json file
if ([ -f "$INPUT_VARFILE" ] && [ $INPUT_VARFILE != *.json ]) ; then
    echo "${INPUT_VARFILE} must be a valid json file in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

set +e
# Run Packer fmt
PACKER_FMT_OUTPUT=$(sh -c "packer init ${INPUT_TEMPLATEFILE}" 2>&1)
BUILD_SUCCESS=$?
echo "$PACKER_FMT_OUTPUT"

# Run Packer validate
PACKER_VALIDATE_OUTPUT=$(sh -c "packer validate ${INPUT_TEMPLATEFILE}" 2>&1)
BUILD_SUCCESS=$?
echo "$PACKER_VALIDATE_OUTPUT"

# Run Packer build
BUILD_OUTPUT=$(sh -c "packer build -var-file=${INPUT_VARFILE} ${INPUT_TEMPLATEFILE}" 2>&1)
BUILD_SUCCESS=$?
echo "$BUILD_OUTPUT"
PACKER_VALIDATE_OUTPUT
set -e

exit $BUILD_SUCCESS
