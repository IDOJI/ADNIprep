RS.fMRI_1.3_Diagnosis___Extract.Demographics___Combining.Data = function(Selected.list){
  Full.df = do.call(dplyr::bind_rows, Selected.list[[1]]) %>% relocate(starts_with("EPI___"), .after=last_col()) %>% relocate(starts_with("MT1___"), .after=last_col())
  Demo.df = do.call(dplyr::bind_rows, Selected.list[[2]]) %>% relocate(starts_with("EPI___"), .after=last_col()) %>% relocate(starts_with("MT1___"), .after=last_col())


  # Only demo
  Demo.df$BLCHANGE___VISCODE = Demo.df$VISCODE
  Demo.df = Demo.df %>% relocate(starts_with("SUBJECT.ID")) %>% relocate(starts_with("RID"))

  # Full data
  Full.df$BLCHANGE___VISCODE =  Full.df$VISCODE
  Full.df = Full.df %>% relocate(BLCHANGE___VISCODE, .after = PTDEMO___VISCODE)
  Full.df = Full.df %>% relocate(starts_with("SUBJECT.ID")) %>% relocate(starts_with("RID"))

  cat("\n", crayon::red("Combining each subjects"), crayon::green("is done!"),"\n")
  return(list(Demo.df, Full.df))
}
