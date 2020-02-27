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