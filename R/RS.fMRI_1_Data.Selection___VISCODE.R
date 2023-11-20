RS.fMRI_1_Data.Selection___Series.Description = function(input){
  #=============================================================================
  # Change Col names
  #=============================================================================
  QC = input$List_QC


  #=============================================================================
  # Define a function
  #=============================================================================
  # Function to create a regex pattern from a list of base terms allowing for variations
  create_pattern <- function(base_terms) {
    patterns <- sapply(base_terms, function(term) {
      # Allow for any non-alphanumeric character (or none) between the letters of the base term
      parts <- unlist(strsplit(term, ""))
      pattern <- paste0(parts, collapse = "[^A-Za-z0-9]*")
      return(pattern)
    })
    combined_pattern <- paste(patterns, collapse = "|")
    return(combined_pattern)
  }
  # Function to filter the dataframe for the specified patterns
  filter_series <- function(df, base_terms) {
    # Create a regex pattern from the base terms
    pattern <- create_pattern(base_terms)
    # Use grepl to match the pattern to the SERIESDESC column
    df_filtered <- df %>%
      dplyr::filter(grepl(pattern, SERIES_DESCRIPTION, ignore.case = TRUE))
    return(df_filtered)
  }









  #=============================================================================
  # Extract QC
  #=============================================================================
  # Example usage with the base terms "MPRAGE", "IR-FSPGR", and "fMRI"
  # This will match "MPRAGE", "MP-RAGE", "MP_RAGE", "MP.RAGE", "MPRAG", etc.
  # "IR-FSPGR", "IR_FSPGR", "IRFSPGR", "IR.FSPGR", etc.
  # And also "fMRI", "f_MRI", "FMRI", etc.
  base_terms <- c("MPRAGE", "IR-FSPGR", "fMRI")
  # To apply this to a list of dataframes
  QC <- lapply(QC, filter_series, base_terms)





  #=============================================================================
  # Return
  #=============================================================================
  cat("\n", crayon::bgMagenta("Selecting by Series_Description"), crayon::green("is done!"), "\n")
  input$List_QC = QC
  return(input)
}
