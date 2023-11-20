RS.fMRI_1_Data.Selection___ImageID = function(input){
  #===========================================================================
  # Define the function to prepend "I" if it's not already there
  #===========================================================================
  prepend_I <- function(df, colname) {
    # Ensure the column is of type character to avoid type mismatch issues
    df[[colname]] <- as.character(df[[colname]])

    # Use dplyr::mutate combined with dplyr::if_else and stringr::str_detect to check if 'I' is at the start of the string
    df <- dplyr::mutate(df, !!rlang::sym(colname) := dplyr::if_else(
      stringr::str_detect(df[[colname]], "^I"),
      df[[colname]],
      paste0("I", df[[colname]])
    ))

    return(df)
  }







  #===========================================================================
  # Adding "I" on QC data Image ID
  #===========================================================================
  input$List_QC = lapply(input$List_QC, prepend_I, colname = "LONI_IMAGE")
  input$List_Search = lapply(input$List_Search, prepend_I, colname = "IMAGE.ID")






  #===========================================================================
  # Intersection Image ID
  #===========================================================================
  ImageID_Search = lapply(input$List_Search, function(x){x[["IMAGE.ID"]]}) %>% unlist %>% unique
  input$List_QC = lapply(input$List_QC, function(x){
    x %>% dplyr::filter(LONI_IMAGE %in% ImageID_Search)
  })






  #===========================================================================
  # Return
  #===========================================================================
  cat("\n", crayon::bgMagenta("Intersecting Image ID"), crayon::green("is done!"), "\n")
  return(input)

}
