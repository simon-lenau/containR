#!/bin/bash

CONTAINER_ENV_FILE=/.env/container.env

if [ -f ${CONTAINER_ENV_FILE} ]; then
    source ${CONTAINER_ENV_FILE}
fi

# ======== > Define some default folders if they are not specified < ========= #

if [ -z ${INPUT_PATH_IN_CONTAINER} ]; then
    export INPUT_PATH_IN_CONTAINER=/DefaultProject/
fi
if [ -z ${OUTPUT_PATH_IN_CONTAINER} ]; then
    export OUTPUT_PATH_IN_CONTAINER=${INPUT_PATH_IN_CONTAINER}output/
fi
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============================ > Create folders < ============================ #
mkdir -p ${INPUT_PATH_IN_CONTAINER}
mkdir -p ${OUTPUT_PATH_IN_CONTAINER}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============= > Copy global .Rprofile and add path messages < ============== #

copy_rprofile() {
    # If .Rprofile does not exist in folder
    if [ ! -f ${1}/.Rprofile ]; then
        # Copy /.Rprofile to folder
        cp /.Rprofile ${1}/
        # Change log message in .Rprofile to contain folder
        sed -i 's|\(Loading\s*\).*\/\(.Rprofile\)|\1'"${1}"'\2|' ${1}/.Rprofile
    fi
}

copy_rprofile ${HOME}/
copy_rprofile ${INPUT_PATH_IN_CONTAINER}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ===================== > Enter projects input folder < ====================== #
cd ${INPUT_PATH_IN_CONTAINER}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========== > Execute the command(s) passed as arguments by user < ========== #
exec "$@"
# ────────────────────────────────── <end> ─────────────────────────────────── #
