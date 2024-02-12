#!/bin/bash

# =========================== > Environment File < =========================== #
# ┌┌────────────────────────────────────────────────────────────────────────┐┐ #
# ││ This will check for an environment file and source it if it is there   ││ #
# └└────────────────────────────────────────────────────────────────────────┘┘ #

CONTAINER_ENV_FILE=/.env

if [ -f ${CONTAINER_ENV_FILE} ]; then
    source ${CONTAINER_ENV_FILE}
fi

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ======== > Define some default folders if they are not specified < ========= #

if [ -z ${WORKDIR} ]; then
    export WORKDIR=/DefaultProject/
fi
if [ -z ${OUTDIR} ]; then
    export OUTDIR=${WORKDIR}output/
fi
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============================ > Create folders < ============================ #
mkdir -p ${WORKDIR}
mkdir -p ${OUTDIR}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============= > Copy global .Rprofile and add path messages < ============== #

copy_rprofile() {
    # If .Rprofile does not exist in folder
    if [ ! -f ${1}/.Rprofile ]; then
        # # Copy /.Rprofile to folder
        # cp /.Rprofile ${1}/
        # # Change log message in .Rprofile to contain folder
        # sed -i 's|\(Loading\s*\).*\/\(.Rprofile\)|\1'"${1}"'\2|' ${1}/.Rprofile
        # Create symbolic link in folder
        ln -s /.Rprofile ${1}/.Rprofile
    fi
}

copy_rprofile ${HOME}/
copy_rprofile ${WORKDIR}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ===================== > Enter projects input folder < ====================== #
cd ${WORKDIR}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========== > Execute the command(s) passed as arguments by user < ========== #
exec "$@"
# ────────────────────────────────── <end> ─────────────────────────────────── #
