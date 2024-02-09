

ARG r_version="r-base:latest"
ARG ubuntu_packages=""
ARG r_packages="data.table"

# =========================== > Base environment < =========================== #

FROM ${r_version}

# Make arguments available as environment variables in container
ARG r_version
ARG ubuntu_packages
ARG r_packages

ENV \
    R_VERSION=${r_version}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ==================== > Create default home directory < ===================== #
RUN mkdir -p ${HOME}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============================ > R setup files < ============================= #
COPY /container_setup/R/.Rprofile /
COPY /container_setup/R/install_missing_packages.R /
RUN mkdir -p /.R/
COPY /container_setup/R/Makevars /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > Ubuntu Packages < ============================ #


RUN if [ -n ${ubuntu_packages} ]; then \
    apt-get update -y && \
    apt-get install -y ${ubuntu_packages}; \
    fi


# ────────────────────────────────── <end> ─────────────────────────────────── #


# ============================== > R packages < ============================== #
RUN if [ -n ${r_packages} ]; then \ 
    printf "\n\t - %s" ${r_packages} \
    Rscript /install_missing_packages.R ${r_packages}; \
    fi
# "data.table"\
# "units"\
# "s2"\
# "sf"\
# "ggplot2"\
# "ggnewscale"\
# "spatstat"\
# "survey"\
# "parallel"\
# "viridis"


RUN rm -f /install_missing_packages.R 

# ────────────────────────────────── <end> ─────────────────────────────────── #

# =============== > Set entrypoint script & default command < ================ #

COPY /container_setup/.entrypoint.sh /

ENTRYPOINT ["/.entrypoint.sh"]

CMD ["bash"]

# ────────────────────────────────── <end> ─────────────────────────────────── #

