library(dplyr)
library(tidyr)
library(purrr)

## Write CSV bundle

## Create heart rates and mean arterial blood pressures for all patients.
## 1 per hour. Don't care about any correlations

## Note that if we are recording something that demands meta-data, we will
## have to reference other tables (like relationship_fact)

# Visit Detail contains the ICU admission (note, visit occurrance is the hospital visit)
cvs_base <- cdm[["visit_detail"]] %>%
  # Select the visit_id, and the start and end times
  select(visit_detail_id,
         person_id,
         provider_id,
         visit_occurrence_id,
         visit_detail_start_datetime,
         visit_detail_end_datetime) %>%
  # nest the start and end times
  nest(ddata = c("visit_detail_start_datetime", "visit_detail_end_datetime")) %>%
  # create an hourly sequence between the start and the end
  mutate(ddata = map(
    ddata, ~ seq.POSIXt(
      .x$visit_detail_start_datetime,
      .x$visit_detail_end_datetime,
      by = "hour"))) %>%
  unnest(ddata) %>%
  rename(measurement_datetime = ddata) %>%
  mutate(measurement_date = as.Date(measurement_datetime),
         measurement_time = as.character(hms::as_hms(measurement_datetime)))

cvs_hr <- add_measurement(
  cvs_base,
  measurement_concept_id = 4239408L,
  measurement_type_concept_id = 45754907L,
  # Almost certainly a derrived value (either from art line or ecg)
  operator_concept_id = 4172703L,
  value_as_number = as.integer(rnorm(n = n(), mean = 100, sd = 10)),
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 8541L,
  range_low = 0L,
  range_high = 300L,
  measurement_source_value = "HRATE",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA))

cvs_map <- add_measurement(
  cvs_base,
  measurement_concept_id = 4108289L,
  measurement_type_concept_id = 45754907L,
  operator_concept_id = 4172703L,
  value_as_number = as.integer(rnorm(n = n(), mean = 75, sd = 10)),
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 4118323L,
  range_low = 0L,
  range_high = 300L,
  measurement_source_value = "INVMAP",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA))

## Add any other data elements here

## Now bind everything into long form
cvs_all <- bind_rows(cvs_hr, cvs_map)

check_names <- names(cdm[["measurement"]])
check_names <- check_names[check_names != "measurement_id"]
cvs_all <- select(cvs_all, !!!check_names)

cdm[["measurement"]] <- bind_rows(
  cdm[["measurement"]],
  cvs_all
) %>%
  ## Finish by resequencing the measurement id and write out
  mutate(measurement_id = 1:n())

# Write out the tables
purrr::iwalk(
  cdm,
  ~ readr::write_csv(.x, paste0("synthetic_omop/", .y, ".csv"))
)

# Boom. And we're out.
