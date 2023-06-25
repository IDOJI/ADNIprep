RS.fMRI_1_Data.Selection___Demographics___Combining.Data = function(Data.list){
  # Data.list = APOE.list
  Combined_Data.df = do.call(rbind, Data.list)

  # relocating cols
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("PTDEMO___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("ADNIMERGE___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("DXSUM___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("MMSE___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("ADAS___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("BLCHANGE___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("CLIELG___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("REGISTRY___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("EPI___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("MT1___"), .after = last_col())
  Combined_Data.df = Combined_Data.df %>% relocate(starts_with("NFQ___"), .after = last_col())
  Combined_Data.df  = Combined_Data.df  %>% relocate(starts_with("SUBJECT.ID")) %>% relocate(starts_with("RID"))

  cat("\n", crayon::red("Combining list"), crayon::green("is done!"),"\n")
  return(Combined_Data.df)
}
