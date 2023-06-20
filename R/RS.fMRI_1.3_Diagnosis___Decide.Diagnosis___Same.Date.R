RS.fMRI_1.3_Diagnosis___Decide.Diagnosis___Same.Date = function(Data.list){
  Returned.list = lapply(seq_along(Data.list), function(i){
    ith_RID.df = Data.list[[i]]
    ith_Dates = ith_RID.df$NEW_EXAMDATE

    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW
    ith_which_NA = which(is.na(ith_Diagnosis))
    if(length(ith_which_NA)>0){
      ith_which_same_dates = sum(ith_Dates[ith_which_NA] %in% ith_Dates[-ith_which_NA ])
      if(ith_which_same_dates>0){
        ith_Selected_Dates = (ith_Dates[ith_which_NA])[ith_Dates[ith_which_NA] %in% ith_Dates[-ith_which_NA ]]
        for(k in seq_along(ith_Selected_Dates)){
          kth_date = ith_Selected_Dates[k]
          kth_Selected_Diagnosis = (ith_Diagnosis[-ith_which_NA])[which(kth_date == ith_Dates[-ith_which_NA])]
          ith_Diagnosis[ith_which_NA][k] = kth_Selected_Diagnosis
        }
        print(i)
      }
      ith_RID.df$DIAGNOSIS_NEW = ith_Diagnosis
    }
    return(ith_RID.df)
  })
  return(Returned.list)
}
