# containR

This is a docker image for [R](https://www.r-project.org/) based on [rocker/r-ver](https://rocker-project.org/images/versioned/r-ver.html).
It adds functionalities to

1. install dependencies while building the container
2. automatically use all available cores for 
    [`install.packages`](https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages)
    and
    [`data.table`](https://cran.r-project.org/web/packages/data.table/data.table.pdf)
3. dynamically define and enter a working environment

Docker ontainers are available on dockerhub: [simonlenau/containr](https://hub.docker.com/r/simonlenau/containr)

## Installation of dependendies

The dependencies are defined in 

- [dependencies/Ubuntu](dependencies/Ubuntu) for Ubuntu packages, and
- [dependencies/R](dependencies/R) for R packages.

Dependency installation is run via

- [scripts/install_ubuntu_pkgs](scripts/install_ubuntu_pkgs) (via [`apt`](https://en.wikipedia.org/wiki/APT_(software))) and
- [scripts/install_R_pkgs](scripts/install_R_pkgs) (via [`install.packages`](https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages))


## Usage of available cores


To automatically use all available cores for
[`install.packages`](https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages)
and
[`data.table`](https://cran.r-project.org/web/packages/data.table/data.table.pdf),
a
[`.R/Makevars`](https://cran.r-project.org/doc/manuals/r-devel/R-exts.html#Using-Makevars) 
and 
[`/.Rprofile`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup) 
file for [R](https://www.r-project.org/)
are defined.
These files are located in [`R/`](R/).
The number of available cores is determined by
[`nproc`](https://www.gnu.org/software/coreutils/manual/html_node/nproc-invocation.html).


## Dynamic working environment definition & entrypoint

The working environment is defined by two folders defined in environment variables
`${WORKDIR}` and `${OUTDIR}`.


The entrypoint script for the container is 
[scripts/entrypoint](scripts/entrypoint). 
Its steps are

1. If an environment file `~/.env` or `/.env` exists, sources it.
2. create (if not existing) `${WORKDIR}` and `${OUTDIR}` and
    create symbolic links to these folders in `~/`
3. create symbolic links to `/.Rprofile` in `~/` and `${WORKDIR}` 
4. `cd` into `${WORKDIR}` 