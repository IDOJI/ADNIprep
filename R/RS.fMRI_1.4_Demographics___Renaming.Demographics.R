RS.fMRI_1.4_Demographics___Renaming.Demographics = function(Data.list){
  Demo_Variables = c("WEIGHT",
                     "ADNIMERGE___AGE", "ADNIMERGE___PTGENDER", "ADNIMERGE___PTEDUCAT",
                     "ADNIMERGE___PTETHCAT", "ADNIMERGE___PTRACCAT",
                     "ADNIMERGE___PTMARRY", "ADNIMERGE___APOE4",
                     "ADNIMERGE___ADAS11", "ADNIMERGE___ADAS13", "ADNIMERGE___ADASQ4", "ADNIMERGE___MMSE",
                     "PTDEMO___PTWORKHS", "PTDEMO___PTWORK", "PTDEMO___PTWRECNT", "PTDEMO___PTNOTRT",
                     "PTDEMO___PTRTYR", "PTDEMO___PTHOME", "PTDEMO___PTOTHOME",
                     "PTDEMO___PTTLANG", "PTDEMO___PTPLANG")


  # RS.fMRI_0_Data.Dictionary(colname = "PTNOTRT")
  Demo_Variables_Added = paste0("DEMO___", Demo_Variables)
  Demo_Added.list = lapply(Data.list , function(ith_RID.df, ...){
    for(k in seq_along(Demo_Variables_Added)){
      ith_RID.df = change_colnames(ith_RID.df, from = Demo_Variables[k], to = Demo_Variables_Added[k])
    }


    for(k in seq_along(ith_RID.df)){
      ith_RID.df[,k] = ith_RID.df[,k] %>% as.character()

    }
    return(ith_RID.df)
  })

  cat("\n",crayon::green("Renaming"), crayon::red("Demographics"), crayon::green("is done!"),"\n")
  return(Demo_Added.list)
}
