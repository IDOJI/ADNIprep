RS.fMRI_1_Data.Selection___Series.Description = function(input){
  #=============================================================================
  # Define a function
  #=============================================================================
  # Function to create a regex pattern from a list of base terms allowing for variations
  create_pattern <- function(base_terms) {
    patterns <- sapply(base_terms, function(term) {
      parts <- unlist(strsplit(term, ""))
      pattern <- paste0(parts, collapse = "[^A-Za-z0-9]*")
      return(pattern)
    })
    combined_pattern <- paste(patterns, collapse = "|")
    return(combined_pattern)
  }

  # Modified function to filter the dataframe for the specified patterns and column name
  filter_series <- function(df, base_terms, column_name) {
    # Create a regex pattern from the base terms
    pattern <- create_pattern(base_terms)
    # Use grepl to match the pattern to the specified column
    df_filtered <- df %>%
      dplyr::filter(grepl(pattern, df[[column_name]], ignore.case = TRUE))
    return(df_filtered)
  }











  #=============================================================================
  # Extract EPI & MT1 from QC, Search
  #=============================================================================
  # Example usage with the base terms "MPRAGE", "IR-FSPGR", and "fMRI"
  # This will match "MPRAGE", "MP-RAGE", "MP_RAGE", "MP.RAGE", "MPRAG", etc.
  # "IR-FSPGR", "IR_FSPGR", "IRFSPGR", "IR.FSPGR", etc.
  # And also "fMRI", "f_MRI", "FMRI", etc.
  base_terms <- c("MPRAGE", "IR-FSPGR", "fMRI", "fcMRI")
  # To apply this to a list of dataframes
  input$List_QC = lapply(input$List_QC, filter_series, base_terms, column_name = "SERIES_DESCRIPTION")
  input$List_Search = lapply(input$List_Search, filter_series, base_terms, column_name = "DESCRIPTION")





  #=============================================================================
  # Return
  #=============================================================================
  cat("\n", crayon::bgMagenta("Selecting by Series_Description"), crayon::green("is done!"), "\n")
  return(input)
}












