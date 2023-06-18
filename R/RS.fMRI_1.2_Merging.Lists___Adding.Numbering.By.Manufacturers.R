RS.fMRI_1.2_Merging.Lists___Adding.Numbering.By.Manufacturers = function(Merged.df){
  #=============================================================================
  # Adding Numbering A Col by Manufacturers
  #=============================================================================
  Sub_Num = paste0("Sub_", fit_length(1:nrow(Merged.df), 3))
  File_Names = paste0(Sub_Num, "___", "RID_", Merged.df$RID, "____","EPI_", Merged_2.df$EPI___IMAGE_ID, "___MT1_", Merged_2.df$MT1___IMAGE_ID, "___", Merged.df$Manufacturer_New)
  Merged_2.df = cbind(File_Names, Merged.df) %>% as_tibble


  return(Merged_2.df)
}
