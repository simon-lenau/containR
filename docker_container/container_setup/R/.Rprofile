# =========================== > Basic R settings < =========================== #
# Width of console messages
options(
    width =
        160
)
# ────────────────────────────────── <end> ─────────────────────────────────── #


# ========================= > data.table settings < ========================== #

# Use all available cores for data.table
try(
    data.table::setDTthreads(
                as.numeric(
                    system(
                        "nproc",
                        intern =
                            TRUE
                    )
                )
    )
)


options(
    # Print row names
    "datatable.print.rownames" =
        TRUE,
    # Number of rows to be printed
    "datatable.print.nrows" =
        10
)
# ────────────────────────────────── <end> ─────────────────────────────────── #

# ================ > Log message to print this file's path < ================= #

cat("Loading /.Rprofile\n")

# ────────────────────────────────── <end> ─────────────────────────────────── #


