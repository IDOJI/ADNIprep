RS.fMRI_1_Data.Selection___Demographics___Demographic.Variables = function(Binded.df){
  Demo_Variables = c("WEIGHT", "DIAGNOSIS_NEW", "SEX", "AGE",
                     "ADNIMERGE___AGE", "ADNIMERGE___PTGENDER", "ADNIMERGE___PTEDUCAT",
                     "ADNIMERGE___PTETHCAT", "ADNIMERGE___PTRACCAT",
                     "ADNIMERGE___PTMARRY", "ADNIMERGE___APOE4",
                     "MMSE___MMSCORE", "ADNIMERGE___MMSE",
                     "PTDEMO___PTWORKHS", "PTDEMO___PTWORK", "PTDEMO___PTWRECNT", "PTDEMO___PTNOTRT",
                     "PTDEMO___PTRTYR", "PTDEMO___PTHOME", "PTDEMO___PTOTHOME",
                     "PTDEMO___PTTLANG", "PTDEMO___PTPLANG")



  for(k in seq_along(Demo_Variables)){
    names(Binded.df)[which(names(Binded.df) == Demo_Variables[k])] = paste0("DEMO___", Demo_Variables[k])
  }

  Binded.df = Binded.df %>% relocate(PHASE)
  Binded.df = Binded.df %>% relocate(starts_with("VISCODE"), .after = SUBJECT.ID)
  Binded.df = Binded.df %>% relocate(EXAMDATE_NEW, .before = VISCODE2)
  Binded.df = Binded.df %>% relocate(starts_with("DEMO___"), .after = VISCODE)





  cat("\n",crayon::green("Renaming"), crayon::red("Demographics"), crayon::green("is done!"),"\n")
  return(Binded.df)
}
