

ARG r_version="r-base:latest"

# =========================== > Base environment < =========================== #

FROM ${r_version}

SHELL ["/bin/bash", "-c"]

# Make arguments available as environment variables in container
ARG r_version \
    ubuntu_packages="" \
    r_packages="data.table" \
    workdir="/WORKDIR/" \
    outdir="/OUTDIR/"

ENV \
    R_VERSION=${r_version} \
    CONTAINR_DIR="/containr_scripts" \
    WORKDIR="$workdir" \
    OUTDIR="$outdir"

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========================== > Create directories < ========================== #
RUN mkdir -p ${CONTAINR_DIR}
RUN mkdir -p ${HOME}
RUN mkdir -p /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ======================== > Copy containr scripts < ========================= #
COPY containr_scripts/ ${CONTAINR_DIR}/
# ────────────────────────────────── <end> ─────────────────────────────────── #


# ==================== > Copy R settings into container < ==================== #
COPY R/.Rprofile /
COPY R/Makevars /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========================= > Install dependencies < ========================= #

RUN if [ -n "${ubuntu_packages}" ]; then \
    ${CONTAINR_DIR}/install_ubuntu_pkgs "${ubuntu_packages}"; \
    fi; \
    \
    if [ -n "${r_packages}" ]; then \ 
    ${CONTAINR_DIR}/install_R_pkgs "${r_packages}"; \
    fi


# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============================== > .env file < =============================== #

# ┌┌────────────────────────────────────────────────────────────────────────┐┐ #
# ││ This file is sourced by the entrypoint script                          ││ #
# └└────────────────────────────────────────────────────────────────────────┘┘ #
RUN \ 
    printf "%s\n" \
    "export WORKDIR=${workdir}" \
    "export OUTDIR=${outdir}" \
    > /.default_env
# ────────────────────────────────── <end> ─────────────────────────────────── #


# =============== > Set entrypoint script & default command < ================ #

RUN \
    ln -s "${CONTAINR_DIR}/entrypoint" "/.entrypoint" && \ 
    chmod a+rwx "/.entrypoint"

ENTRYPOINT ["/.entrypoint"]

CMD ["/bin/bash"]

# ────────────────────────────────── <end> ─────────────────────────────────── #

