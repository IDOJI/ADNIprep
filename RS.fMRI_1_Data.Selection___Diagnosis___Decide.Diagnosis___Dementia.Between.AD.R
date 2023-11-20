RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___Dementia.Between.AD = function(Data.list){
  # Data.list = Change_Diagnosis_by_Comments.list


  Diagnosis_AD.list = lapply(seq_along(Data.list), function(i){
    # ith_RID.df = Data.list[[193]]
    # print(i)
    # i=47
    ith_RID.df = Data.list[[i]]
    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW
    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM
    ith_DXAPP = ith_RID.df$DXSUM___DXAPP

    for(k in seq_along(ith_Diagnosis)[-1]){
      kth = ith_Diagnosis[k]
      if(is.na(kth)){
        ith_Diagnosis[k] = ith_Diagnosis[k-1]
      }else{
        if(kth=="Dementia" && k<length(ith_Diagnosis) && !is.na(ith_Diagnosis[k-1]) && !is.na(ith_Diagnosis[k+1])){


          if(ith_Diagnosis[k-1]=="AD(Probable)" && ith_Diagnosis[k+1] == "AD(Probable)"){
            ith_Diagnosis[k] = "AD(Probable)"
          }else if(ith_Diagnosis[k-1] == "AD(Possible)" && ith_Diagnosis[k+1] == "AD(Possible)"){
            ith_Diagnosis[k] = "AD(Possible)"
          }else if(ith_Diagnosis[k-1] == "AD" && ith_Diagnosis[k+1] == "AD"){
            ith_Diagnosis[k] = "AD"
          }

        }
      }
    }# for

    ith_RID.df$DIAGNOSIS_NEW = ith_Diagnosis
    return(ith_RID.df)
  })
  return(Diagnosis_AD.list)
}
