source("R/lakemart_function.R")
library(tidyverse)


# load files from lake mart -----------------------------------------------

rates_data <- get_su_lakemart_parquet_file("national_rates_data.parquet/part")
apc_counts <- get_su_lakemart_parquet_file("apc_counts.parquet/part")
opa_counts <- get_su_lakemart_parquet_file("opa_counts.parquet/part")
ed_counts <- get_su_lakemart_parquet_file("ed_counts.parquet/part")




# get a unified lookup for tpmas and rate definitions ---------------------

# load the lookup from The-Strategy-Unit/TPMAs
tpma_lookup <- get_tpma_lookup()

config <- get_config()

tpma_lookup_with_config <- tpma_lookup |> 
  dplyr::inner_join(dplyr::select(
    config,
    strategy_variable, 
    measure), by = c("tpma_variable" = "strategy_variable")) 



# outputs -----------------------------------------------------------------

# table 1
table_1 <- tpma_lookup |> 
  count(activity_type, tpma_mechanism, tpma_name)

# rates data
rates_data_final_year <- rates_data |> 
  filter(fyear == 202324) |> 
  select(!std_rate)

rates_final_table <- tpma_lookup_with_config |> 
  inner_join(rates_data_final_year, by = c("tpma_variable" = "strategy")) |> 
  select(
    activity_type,
    tpma_mechanism,
    tpma_name,
    measure,
    tpma_code,
    tpma_subtype,
    numerator,
    denominator,
    crude_rate) |> 
  arrange(
    activity_type,
    tpma_mechanism,
    tpma_name,
    tpma_code)
  


