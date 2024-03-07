ARG r_version="r-base:latest"
ARG ubuntu_packages=""
ARG r_packages="data.table"

# =========================== > Base environment < =========================== #

FROM ${r_version}

SHELL ["/bin/bash", "-c"]

# Make arguments available as environment variables in container
ARG r_version
ARG ubuntu_packages
ARG r_packages

ENV \
    R_VERSION=${r_version} \
    CONTAINR_DIR=/containr_scripts

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
    ${CONTAINR_DIR}/install_pkgs "${ubuntu_packages}"; \
    fi; \
    if [ -n "${r_packages}" ]; then \
    ${CONTAINR_DIR}/install_Rpkgs "${r_packages}"; \
    fi

# ────────────────────────────────── <end> ─────────────────────────────────── #

# =============== > Set entrypoint script & default command < ================ #

RUN \
    ln -s "${CONTAINR_DIR}/entrypoint" "/.entrypoint" &&
    chmod a+rwx "/.entrypoint"

ENTRYPOINT ["/.entrypoint"]

CMD ["/bin/bash"]

# ────────────────────────────────── <end> ─────────────────────────────────── #
