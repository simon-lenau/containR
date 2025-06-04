

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
    CONTAINR_DIR="/containr" \
    WORKDIR="$workdir" \
    OUTDIR="$outdir"

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========================== > Create directories < ========================== #
RUN \
    mkdir -p ${CONTAINR_DIR} \
    mkdir -p ${HOME} \
    mkdir -p /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ======================== > Copy containr scripts < ========================= #
COPY scripts/ ${CONTAINR_DIR}/
# ────────────────────────────────── <end> ─────────────────────────────────── #


# ==================== > Copy R settings into container < ==================== #
COPY R/.Rprofile /
COPY R/Makevars /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ========================= > Install dependencies < ========================= #

RUN \
    if [ -n "${ubuntu_packages}" ]; then \
        ${CONTAINR_DIR}/install_ubuntu_pkgs "${ubuntu_packages}"; \
        pkg-config --exists fontconfig && echo "fontconfig OK" || echo "fontconfig not OK"  ; \
        pkg-config --exists freetype2  && echo "freetype2 OK" || echo "freetype2 not OK" ; \
        dpkg -l pkgconf-bin || echo "dpkg -l pkgconf-bin NOT OK"; \
        ls -l /usr/bin/pkg-config || echo "ls -l /usr/bin/pkg-config NOT OK"; \
        echo "$PATH" | tr ':' '\n'; \
    fi; \
    (R CMD javareconf) > /dev/null; \
    if [ -n "${r_packages}" ]; then \ 
        ${CONTAINR_DIR}/entrypoint; \
        ${CONTAINR_DIR}/install_R_pkgs "${r_packages}"; \
    fi

# ────────────────────────────────── <end> ─────────────────────────────────── #



# =============== > Set entrypoint script & default command < ================ #

RUN \
    ln -s "${CONTAINR_DIR}/entrypoint" "/.entrypoint" && \ 
    chmod a+rwx "/.entrypoint"

ENTRYPOINT ["/.entrypoint"]

CMD ["/bin/bash"]

# ────────────────────────────────── <end> ─────────────────────────────────── #

