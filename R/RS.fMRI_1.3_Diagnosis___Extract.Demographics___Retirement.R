RS.fMRI_1.3_Diagnosis___Extract.Demographics___Retirement = function(Data.list){
  Retire.list = lapply(Data.list, function(ith_RID.df){
    ith_Retirement = ith_RID.df$PTDEMO___PTNOTRT
    ith_Retirement_New = rep(NA, length(ith_Retirement))

    for(k in seq_along(ith_Retirement)){
      if(k==1){
        ith_Retirement_New[k] = ith_Retirement[k]
      }else if(is.na(ith_Retirement[k])){
        if(!is.na(ith_Retirement_New[k-1])){
          ith_Retirement_New[k] = ith_Retirement_New[k-1]
        }
      }else if(!is.na(ith_Retirement[k])){
        ith_Retirement_New[k] = ith_Retirement[k]
      }
    }
    ith_RID.df$PTDEMO___PTNOTRT = ith_Retirement_New
    return(ith_RID.df)
  })

  cat("\n",crayon::green("Checking"), crayon::red("Retirement"), crayon::green("is done!"),"\n")
  return(Retire.list)
}
