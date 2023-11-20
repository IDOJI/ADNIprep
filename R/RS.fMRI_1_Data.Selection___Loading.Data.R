RS.fMRI_1_Data.Selection___Loading.Data = function(path_Downloaded){
  #=============================================================================
  # Load Data
  #=============================================================================
  input = lapply(path_Downloaded, RS.fMRI_1_Data.Selection___Loading.Data___SUB) %>%
    setNames(paste0("List_", basename_sans_ext(path_Downloaded)))




  #=============================================================================
  # Return
  #=============================================================================
  cat("\n", crayon::bgMagenta("Loading Data"), crayon::green("is done!"), "\n")
  input %>% return

}
