RS.fMRI_1_Data.Selection___Loading.Lists___Search___Change.Exclude.Phase = function(data.df){
  #=============================================================================
  # Remove blank
  #=============================================================================
  data.df$PHASE = gsub(pattern = " ",  replacement = "", data.df$PHASE)


  #=============================================================================
  # Exclude blanks & ADNI1
  #=============================================================================
  data.df = data.df %>% filter(PHASE != "" & PHASE != "ADNI1")

  return(data.df)
}
