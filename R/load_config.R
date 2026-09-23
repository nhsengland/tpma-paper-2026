get_config <- function(
    path = "https://raw.githubusercontent.com/The-Strategy-Unit/nhp_inputs/main/inst/golem-config.yml"
) {
  config <- yaml::read_yaml(
    path,
    eval.expr=TRUE
  )
  
  # Abbreviate the path to the mitigators_config list
  mitigator_config <- config$default$mitigators_config
  
  # Use purrr to map over the list of categories and create the data frame
  mitigator_config_df <- purrr::map_df(names(mitigator_config), function(category_name) {
    
    # Extract the relevant components for each category
    activity_type <- mitigator_config[[category_name]]$activity_type
    mitigator_type <- mitigator_config[[category_name]]$mitigators_type
    strategy_variable <- names(mitigator_config[[category_name]]$strategy_subset)
    measure <- mitigator_config[[category_name]]$y_axis_title
    
    # Return a data frame with category, element, and y_axis_title
    tidyr::tibble(
      activity_type = activity_type,
      mitigator_type = mitigator_type,
      category = category_name,
      strategy_variable = strategy_variable,
      measure = measure
    )
  })
  
  return(mitigator_config_df)
}
