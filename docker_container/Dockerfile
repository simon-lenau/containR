

ARG r_version="r-base:latest"
ARG ubuntu_packages=[]
ARG r_packages=["data.table"]

# =========================== > Base environment < =========================== #

FROM ${r_version}

# Make arguments available as environment variables in container
ARG r_version

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
RUN apt-get update -y

RUN if [ ${ubuntu_packages} ]; then \
    for item in ${ubuntu_packages}; do \
    apt-get install -y ${item}; \
    done \
    fi


# ────────────────────────────────── <end> ─────────────────────────────────── #


# ============================== > R packages < ============================== #

RUN if [ ${R_packages} ]; then \ 
    Rscript /install_missing_packages.R ${R_packages} \
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

