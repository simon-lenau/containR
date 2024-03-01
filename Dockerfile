

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
COPY R/.Rprofile /
COPY R/install_missing_packages.R /
RUN mkdir -p /.R/
COPY R/Makevars /.R/
# ────────────────────────────────── <end> ─────────────────────────────────── #

# # =========================== > Ubuntu Packages < ============================ #

# RUN if [ -n "${ubuntu_packages}" ]; then \
#     echo "Attempting to install ubuntu_packages:"; \
#     printf "\t - %s\n" ${ubuntu_packages}; \
#     (apt-get update -y && apt-get install -y ${ubuntu_packages}) > ubuntu_packages.log 2>&1 && \
#     (echo "... successful!" && rm -rf ubuntu_packages.log) || \
#     (sed -i 's/^/\t/' ubuntu_packages.log && cat ubuntu_packages.log && exit 1); \
#     fi

# # ────────────────────────────────── <end> ─────────────────────────────────── #

# # ============================== > R packages < ============================== #

# RUN if [ -n "${r_packages}" ]; then \ 
#     echo "Attempting to install r_packages:"; \
#     printf "\t - %s\n" ${r_packages}; \
#     Rscript /install_missing_packages.R ${r_packages} > r_packages.log 2>&1 && \
#     (echo "... successful!" && rm -rf r_packages.log) || \
#     (sed -i 's/^/\t/' r_packages.log && cat r_packages.log && exit 1); \
#     fi

# RUN rm -f /install_missing_packages.R 

# # ────────────────────────────────── <end> ─────────────────────────────────── #

# =============== > Set entrypoint script & default command < ================ #

COPY .entrypoint.sh /

ENTRYPOINT ["/.entrypoint.sh"]

CMD ["bash"]

# ────────────────────────────────── <end> ─────────────────────────────────── #

