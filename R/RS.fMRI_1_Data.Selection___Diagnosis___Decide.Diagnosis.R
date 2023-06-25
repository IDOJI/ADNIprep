RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis = function(Merged_Diagnosis.list){
  # Data.list = Merged_Diagnosis.list
  #=======================================================================
  # Diagnosis conversion
  #=======================================================================
  Diagnosis_New.list = RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___Conversion(Merged_Diagnosis.list)




  #=======================================================================
  # AD Likelihood
  #=======================================================================
  AD_Likelihood.list = RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___AD.Likelihood(Diagnosis_New.list)



  #=======================================================================
  # Dementia -> AD, MCI -> LMCI, EMCI by comments
  #=======================================================================
  Change_Diagnosis_by_Comments.list = RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___Comments(AD_Likelihood.list)





  #=======================================================================
  # Dementia between AD?
  #=======================================================================
  Dementia_AD.list = RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___Dementia.Between.AD(Change_Diagnosis_by_Comments.list)




  #=============================================================================
  # Same Date?
  #=============================================================================
  # Same_Date.list = RS.fMRI_1_Data.Selection___Diagnosis___Decide.Diagnosis___Same.Date(Dementia_AD.list)





  #=============================================================================
  # Change NA by pre-diagnosis
  #=============================================================================
  Diagnosis_New.list = lapply(seq_along(Dementia_AD.list), function(i){
    ith_RID.df = Dementia_AD.list[[i]]
    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW
    for(k in seq_along(ith_Diagnosis)[-1]){
      kth = ith_Diagnosis[k]
      if(is.na(kth)){
        ith_Diagnosis[k] = ith_Diagnosis[k-1]
      }
    }
    ith_RID.df$DIAGNOSIS_NEW = ith_Diagnosis
    return(ith_RID.df)
  })




  cat("\n", crayon::green("Deciding diagnosis conversion is done!"),"\n")
  return(Diagnosis_New.list )
}


#=======================================================================
# 1) Selecting columns for diagnosis
#=======================================================================
# Diagnosis_Data.list = lapply(seq_along(Merged_Data.list), function(i){
#   # Merged_Data.list[[i]] %>% names
#   # ith_Data.df = Merged_Data.list[[i]] %>% select(DXSUM___DXCHANGE, RESEARCH.GROUP,ADNIMERGE___DX.bl, RID, DIAGNOSIS,
#   #                                                DXSUM___VISCODE, VISCODE2, NEW_EXAMDATE,
#   #                                                DXSUM___DXNORM, DXSUM___DXMCI, DXSUM___DXAD,
#   #                                                DXSUM___DXCONV, DXSUM___DXCONTYP, DXSUM___DXREV,
#   #                                                DXSUM___DXAPP,
#   #                                                DXSUM___DXOTHDEM,
#   #                                                BLCHANGE___BCEXTSP, BLCHANGE___BCSUMM,
#   #                                                CLIELG___CCOMM, CLIELG___CENROLL, CLIELG___INCLUSION, CLIELG___EXCLUSION)
#
#   # return(ith_Data.df)
#   return(Merged_Data.list[[i]])
# })






#=======================================================================
# Does everyone has "sc"
#=======================================================================
# Everyon_Has_sc = sapply(Diagnosis_Data.list, function(ith_RID.df){
#   ith_RID.df$VISCODE2[1] == "sc"
# }) %>% sum == length(Diagnosis_Data.list)
# if(!Everyon_Has_sc){
#   stop("There is a subject with no 'sc' in VISCODE2!")
# }






#=======================================================================
# Does everyone has "bl"
#=======================================================================
# Everyon_Has_bl = sapply(Diagnosis_Data.list, function(ith_RID.df){
#   ith_VISCODE2 = ith_RID.df$VISCODE2 %>% as.character %>% na.omit %>% unique
#   if(length(ith_VISCODE2)==1 &&  ith_VISCODE2[1] == "sc"){
#     return(TRUE)
#   }else{
#     return(ith_RID.df$VISCODE2[2]=="bl")
#   }
# }) %>% sum == length(Diagnosis_Data.list)
# if(!Everyon_Has_bl){
#   stop("There is a subject with no 'bl' in VISCODE2!")
# }

# RID_2 = sapply(Diagnosis_Data.list, function(y){
#   y$RID %>% na.omit %>% unique
# })
# which(RID_2==4199)

# diagnosis = sapply(Diagnosis_Data.list, function(y){
#   "LMCI" %in% y$DIAGNOSIS %>% na.omit %>% unique
# })
# which(diagnosis)
# Diagnosis_Data.list[[114]]$DIAGNOSIS






#=======================================================================
# Check DX.bl & "DIAGNOSIS" of bl
#=======================================================================
# Diagnosis_New.list[[2]]
# Check_DX.bl = sapply(seq_along(Diagnosis_New.list), function(i){
#   # i=37
#   ith_data.df = Diagnosis_New.list[[i]]
#   if(sum("bl" %in% ith_data.df$VISCODE2)!=0){
#     ith_bl_Diagnosis = ith_data.df[ith_data.df$VISCODE2=="bl","DIAGNOSIS_NEW"] %>% na.omit %>% as.character()
#     sith_DX.bl  = ith_data.df$ADNIMERGE___DX.bl %>% na.omit %>% unique %>% as.character
#    return(ith_DX.bl==ith_bl_Diagnosis)
#   }else{
#     return(TRUE)
#   }
# }) %>% unlist



#=======================================================================
# Check Research Group
#=======================================================================
# Is_same_with_Research.Group = sapply(Diagnosis_New.list, function(y){
#   y[which(!is.na(y$RESEARCH.GROUP)), "DIAGNOSIS_NEW"] == y$RESEARCH.GROUP[!is.na(y$RESEARCH.GROUP)]
# })
# Diagnosis_New.list[[20]] %>% View


# which(RID==4199)
# 4199




  # Diagnosis_New.list[[2]]
  # Check_DX.bl = sapply(seq_along(Diagnosis_New.list), function(i){
