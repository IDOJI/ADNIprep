RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Diagnosis___AD.Probability = function(Data.list){
  # Data.list = Diagnosis_New.list
  #=======================================================================
  # if all Dementia, check RESEARCH.GROUP &
  #=======================================================================
  Diagnosis_AD.list = lapply(seq_along(Data.list), function(i){
    # which(names(Merged_Data.list)=="7109")
    # ith_RID.df = Excluded.list[[653]]
    # print(ith_RID.df$RID %>% unique)
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTADDX")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTHOME")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTDOBYY")
    i=8
    ith_RID.df = Data.list[[i]]


    if("Dementia" %in% ith_RID.df$DIAGNOSIS_NEW %>% unique){
      ith_Research.Group = ith_RID.df$RESEARCH.GROUP %>% na.omit %>% as.character
      ith_DXAPP = ith_RID.df$DXSUM___DXAPP %>% unique %>% na.omit %>% as.numeric
      ith_DX.bl = ith_RID.df$ADNIMERGE___DX.bl %>% unique %>% na.omit %>% as.character()

      if(ith_Research.Group=="AD"){
        ith_RID.df$DIAGNOSIS_NEW[which(ith_RID.df$DIAGNOSIS_NEW == "Dementia")] = "AD"
      }else{
        if(which(ith_RID.df$DXSUM___DXAPP == 1) %>% length > 0){
          ith_RID.df$DIAGNOSIS_NEW[which(ith_RID.df$DXSUM___DXAPP == 1)] = "AD(Probable)"
        }else if(which(ith_RID.df$DXSUM___DXAPP == 2) %>% length > 0){
          ith_RID.df$DIAGNOSIS_NEW[which(ith_RID.df$DXSUM___DXAPP == 2)] = "AD(Possible)"
        }
      }
    }
    return(ith_RID.df)
  })







  #=======================================================================
  # AD, Dementia
  #=======================================================================
  ### finding dementia
  # test = sapply(Diagnosis_New_AD_2.list, function(y){
  #   "Dementia" %in% y$DIAGNOSIS_NEW
  # })
  # which(test)


  Diagnosis_New_AD_2.list = lapply(seq_along(Diagnosis_New_AD.list), function(i){
    # ith_RID.df = Diagnosis_New_AD.list[[193]]
    # print(i)
    ith_RID.df = Diagnosis_New_AD.list[[i]]
    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW
    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM

    for(k in seq_along(ith_Diagnosis)){
      # print(k)
      # k=1
      if(!is.na(ith_Diagnosis[k])){
        if(k==1 && ith_Diagnosis[k]=="AD"){
          ith_Diagnosis[k] = ith_Diagnosis[k]
        }else{
          # Dementia
          if(ith_Diagnosis[k] == "Dementia"){
            if(ith_Diagnosis[k-1] == "AD(Probable)"){
              ith_Diagnosis[k] = "AD(Probable)"
            }else if(ith_Diagnosis[k-1] == "AD(Possible)"){
              ith_Diagnosis[k] = "AD(Possible)"
            }else if(ith_Diagnosis[k-1] == "AD"){
              if(ith_Comments[k] == "" || is.na(ith_Comments[k])){
                ith_Diagnosis[k] = "AD"
              }
            }
          }else if(ith_Diagnosis[k] == "AD" && ith_Diagnosis[k-1] == "AD(Probable)" && k < length(ith_Diagnosis)){
            if(ith_Diagnosis[k+1] == "AD(Probable)"){
              ith_Diagnosis[k] = "AD(Probable)"
            }else if(is.na(ith_Comments[k]) || ith_Comments[k]==""){
              ith_Diagnosis[k] = "AD(Probable)"
            }
          }else if(ith_Diagnosis[k] == "AD" && ith_Diagnosis[k-1] == "AD(Possible)" && k < length(ith_Diagnosis)){
            if(ith_Diagnosis[k+1] == "AD(Possible)"){
              ith_Diagnosis[k] = "AD(Possible)"
            }else if(is.na(ith_Comments[k]) || ith_Comments[k]==""){
              ith_Diagnosis[k] = "AD(Possible)"
            }
          }else if(ith_Diagnosis[k] == "AD" && ith_Diagnosis[k-1] == "AD(Probable)" && is.na(ith_Comments[k])){
            ith_Diagnosis[k] = "AD(Probable)"
          }else if(ith_Diagnosis[k] == "AD" && ith_Diagnosis[k-1] == "AD(Possible)" && is.na(ith_Comments[k])){
            ith_Diagnosis[k] = "AD(Possible)"
          }
        }
      }
    }# for
    ith_RID.df$DIAGNOSIS_NEW = ith_Diagnosis
    return(ith_RID.df)
  })


}
