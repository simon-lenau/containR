# =============================== > Summary < ================================ #
# ┌┌────────────────────────────────────────────────────────────────────────┐┐ #
# ││ This script is used to install missing packages in the container image ││ #
# └└────────────────────────────────────────────────────────────────────────┘┘ #
# ────────────────────────────────── <end> ─────────────────────────────────── #



packages <-
    commandArgs(
        trailingOnly =
            TRUE
    )

packages_fmt <-
    paste0(
        "%",
        max(nchar(packages)),
        "s"
    )


for (
    package
    in
    packages
) {
    if (!library(package,
        logical.return =
            TRUE,
        character.only =
            TRUE
    )) {
        cat(
            "Package",
            sprintf(
                packages_fmt,
                package
            ),
            "installation:\n"
        )
        install.packages(
            package,
            repos =
                "https://cloud.r-project.org",
            dependencies =
                c(
                    "Depends",
                    "Imports",
                    "LinkingTo"
                )
        )
        cat("done\n")
        if (!library(package,
            logical.return =
                TRUE,
            character.only =
                TRUE
        )) {
            quit(
                status =
                    10
            )
        }
    } else {
        cat(
            "Package",
            sprintf(
                packages_fmt,
                package
            ),
            "already installed\n"
        )
    }
}
