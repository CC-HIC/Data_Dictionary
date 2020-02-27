## Prep file
## If you don't have icnarc2omop installed:
# remotes::install_github("cc-hic/icnarc2omop")

library(icnarc2omop)

# Make sure the working directory is set.
cdm <- omopify_xml(".",
                   nhs_trust = "Demo St. Elsewhere",
                   build_in_memory = TRUE,
                   dummy_data = TRUE)

# Write out the tables
purrr::iwalk(
  cdm,
  ~ readr::write_csv(.x, paste0("synthetic_omop/", .y, ".csv"))
)

# Boom. And we're out.