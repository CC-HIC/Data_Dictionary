# Could probably abstract away more of this when it becomes clear that some
# labels are extremely common.
add_measurement <- function(
  base_table,
  measurement_concept_id = 4239408L,
  measurement_type_concept_id = 45754907L,
  operator_concept_id = 4172703L,
  value_as_number,
  value_as_concept_id = as.integer(NA),
  unit_concept_id = 8541L,
  range_low = 0L,
  range_high = 300L,
  measurement_source_value = "HRATE",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA)) {
  
  base_table <- base_table %>%
    mutate(measurement_concept_id = measurement_concept_id,
           measurement_type_concept_id = measurement_type_concept_id,
           operator_concept_id = operator_concept_id,
           value_as_number = value_as_number,
           value_as_concept_id = value_as_concept_id,
           unit_concept_id = unit_concept_id,
           range_low = range_low,
           range_high = range_high,
           measurement_source_value = "measurement_source_value",
           measurement_source_concept_id = measurement_source_concept_id,
           unit_source_value = unit_source_value,
           value_source_value = value_source_value)
  
  return(base_table)
  
}



# Need a function for add_events e.g device_exposure This example is for a tracheostomy, 
# No idea if this is correct and dont kow how to represent the dates
add_device_exposure <- function(
  base_table,
  device_concept_id = 129121000L,
  device_exposure_start_date =  ## ,
  operator_concept_id = 4172703L,
  device_exposure_end_date = ##,
  value_as_date = ##,
  device_type_concept_id =4044008L,
  # This is a physical object
  value_as_concept_id = as.integer(NA),
  measurement_source_value = "tracheostomy",
  measurement_source_concept_id = as.integer(NA),
  unit_source_value = as.character(NA),
  value_source_value = as.character(NA)) {
  
  base_table <- base_table %>%
    mutate(device_concept_id = device_concept_id,
           device_exposure_start_date =  device_exposure_start_date,
           device_exposure_end_date = device_exposure_end_date,
           operator_concept_id = operator_concept_id,
           value_as_date = value_as_date,
           value_as_concept_id = value_as_concept_id,
           measurement_source_value = "measurement_source_value",
           measurement_source_concept_id = measurement_source_concept_id,
           unit_source_value = unit_source_value,
           value_source_value = value_source_value)
  
  return(base_table)
  
}