RS.fMRI_1.3_Diagnosis___Decide.Diagnosis___AD.Likelihood = function(Data.list){
  # Data.list = Diagnosis_New.list
  #=======================================================================
  # AD likelihood
  #=======================================================================
  Diagnosis_AD.list = lapply(seq_along(Data.list), function(i){
    # which(names(Merged_Data.list)=="7109")
    # ith_RID.df = Excluded.list[[653]]
    # print(ith_RID.df$RID %>% unique)
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTADDX")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTHOME")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTDOBYY")
    ith_RID.df = Data.list[[i]]
    ith_DIAGNOSIS = ith_RID.df$DIAGNOSIS_NEW
    ith_DXAPP = ith_RID.df$DXSUM___DXAPP

    ith_which_Dementia_AD = which(ith_DIAGNOSIS %in% c("Dementia", "AD"))
    if(length(ith_which_Dementia_AD) > 0){
      for(k in seq_along(ith_which_Dementia_AD)){
        kth_row = ith_which_Dementia_AD[k]
        kth_DXAPP = ith_DXAPP[kth_row]
        if(!is.na(kth_DXAPP)){
          if(kth_DXAPP == 1){
            ith_DIAGNOSIS[kth_row] = "AD(Probable)"
          }else if(kth_DXAPP == 2){
            ith_DIAGNOSIS[kth_row] = "AD(Possible)"
          }
        }
      }
    }
    ith_RID.df$DIAGNOSIS_NEW = ith_DIAGNOSIS
    return(ith_RID.df)
  })



}
