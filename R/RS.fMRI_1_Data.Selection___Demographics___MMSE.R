RS.fMRI_1_Data.Selection___Demographics___MMSE = function(Demo.df){
  MMSE_1 = Demo.df$DEMO___ADNIMERGE___MMSE;Demo.df$DEMO___ADNIMERGE___MMSE = NULL
  MMSE_2 = Demo.df$DEMO___MMSE___MMSCORE

  Demo.df$DEMO___MMSE___MMSCORE = sapply(seq_along(MMSE_3), function(k, ...){
    if(!is.na(MMSE_2[k])){
      return(MMSE_2[k])
    }else if(!is.na(MMSE_1[k])){
      return(MMSE_1[k])
    }else{
      NA
    }
  })
  return(Demo.df)
}
