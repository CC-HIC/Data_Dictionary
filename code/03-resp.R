## Write CSV bundle

## Create heart rates and mean arterial blood pressures for all patients.
## 1 per hour. Don't care about any correlations

## Note that if we are recording something that demands meta-data, we will
## have to reference other tables (like relationship_fact)






# Visit Detail contains the ICU admission (note, visit occurrance is the hospital visit)
resp_base <- cdm[["visit_detail"]] %>%
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


# This is an example of ventilator measurement
resp_vt <- add_measurement(
  resp_base,
  measurement_concept_id = 3012410L,
  measurement_type_concept_id = 45754907L,
  # This is a derrived value (from ventilator or monitor)
  operator_concept_id = 4172703L,
  value_as_number = as.integer(rnorm(n = n(), mean = 100, sd = 10)),
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 8587L,
  # This is mL
  range_low = 0L,
  range_high = 2000L,
  measurement_source_value = "TIDAL_VOL",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA))


# This is an example of ventilator measurement
resp_vt <- add_measurement(
  resp_base,
  measurement_concept_id = 3012410L,
  measurement_type_concept_id = 45754907L,
  # This is a derrived value (from ventilator or monitor)
  operator_concept_id = 4172703L,
  value_as_number = as.integer(rnorm(n = n(), mean = 100, sd = 10)),
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 8587L,
  # This is mL
  range_low = 0L,
  range_high = 2000L,
  measurement_source_value = "TIDAL_VOL",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA))



# This is an example of FiO2 and needs range and units sorting
resp_fio2 <- add_measurement(
  resp_base,
  measurement_concept_id = 3020716L,
  measurement_type_concept_id = 45754907L,
  # This is a derived value (from ventilator or entered into EHR)
  operator_concept_id = 4172703L,
  value_as_number = as.integer(rnorm(n = n(), mean = 100, sd = 10)),
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 8587L,
  # This is mL
  range_low = 0L,
  range_high = 1L,
  measurement_source_value = "TIDAL_VOL",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA))




# The following are events that occur and will not have an hourly cadece

Intubation
Extubation
Tracheostomy
Decanulation











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