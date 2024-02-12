


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
# > ubuntu_packages.log 2>&1
# BLA
RUN if [ -n "${ubuntu_packages}" ]; then \
    apt-get update -y; \
    echo "Attempting to install ubuntu_packages:"; \
    printf "\t - %s\n" ${ubuntu_packages}; \
    ubuntu_pkg_log="$(apt-get install -y ${ubuntu_packages})" && \
    echo "... successful!" || \
    (sed 's/^/\t/' <<< "${ubuntu_pkg_log}" && cat ${ubuntu_pkg_log}); \
    fi



# ────────────────────────────────── <end> ─────────────────────────────────── #


# ============================== > R packages < ============================== #


RUN if [ -n "${r_packages}" ]; then \ 
    echo "Attempting to install r_packages:"; \
    printf "\t - %s\n" ${r_packages}; \
    Rscript /install_missing_packages.R ${r_packages} > r_packages.log 2>&1 && \
    echo "... successful!" || \
    (sed -i 's/^/\t/' r_packages.log && cat r_packages.log); \
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

