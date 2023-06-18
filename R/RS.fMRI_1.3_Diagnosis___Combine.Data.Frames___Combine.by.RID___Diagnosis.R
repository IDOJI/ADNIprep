RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Diagnosis = function(Merged_Data.list){
  #=======================================================================
  # 1) Selecting columns for diagnosis
  #=======================================================================
  Diagnosis_Data.list = lapply(seq_along(Merged_Data.list), function(i){
    # Merged_Data.list[[i]] %>% names
    # ith_Data.df = Merged_Data.list[[i]] %>% select(DXSUM___DXCHANGE, RESEARCH.GROUP,ADNIMERGE___DX.bl, RID, DIAGNOSIS,
    #                                                DXSUM___VISCODE, VISCODE2, NEW_EXAMDATE,
    #                                                DXSUM___DXNORM, DXSUM___DXMCI, DXSUM___DXAD,
    #                                                DXSUM___DXCONV, DXSUM___DXCONTYP, DXSUM___DXREV,
    #                                                DXSUM___DXAPP,
    #                                                DXSUM___DXOTHDEM,
    #                                                BLCHANGE___BCEXTSP, BLCHANGE___BCSUMM,
    #                                                CLIELG___CCOMM, CLIELG___CENROLL, CLIELG___INCLUSION, CLIELG___EXCLUSION)

    # return(ith_Data.df)
    return(Merged_Data.list[[i]])
  })






  #=======================================================================
  # Does everyone has "sc"
  #=======================================================================
  Everyon_Has_sc = sapply(Diagnosis_Data.list, function(ith_RID.df){
    ith_RID.df$VISCODE2[1] == "sc"
  }) %>% sum == length(Diagnosis_Data.list)
  if(!Everyon_Has_sc){
    stop("There is a subject with no 'sc' in VISCODE2!")
  }






  #=======================================================================
  # Does everyone has "bl"
  #=======================================================================
  Everyon_Has_bl = sapply(Diagnosis_Data.list, function(ith_RID.df){
    ith_VISCODE2 = ith_RID.df$VISCODE2 %>% as.character %>% na.omit %>% unique
    if(length(ith_VISCODE2)==1 &&  ith_VISCODE2[1] == "sc"){
      return(TRUE)
    }else{
      return(ith_RID.df$VISCODE2[2]=="bl")
    }
  }) %>% sum == length(Diagnosis_Data.list)
  if(!Everyon_Has_bl){
    stop("There is a subject with no 'bl' in VISCODE2!")
  }

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
  # Dementia -> AD, MCI -> LMCI, EMCI by comments
  #=======================================================================
  Change_Diagnosis_by_Comments.list = lapply(Diagnosis_Data.list, function(ith_RID.df){
    # ith_RID.df = Diagnosis_Data.list[[112]]
    ith_RID.df = ith_RID.df %>% relocate(BLCHANGE___BCSUMM)
    ith_RID.df = cbind(DIAGNOSIS_NEW = ith_RID.df$DIAGNOSIS, ith_RID.df)

    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM


    #===========================================================================
    # MCI
    #===========================================================================
    ith_Which_Rows_MCI = which(ith_RID.df$DIAGNOSIS_NEW == "MCI")
    ith_Have_MCI = ith_Which_Rows_MCI %>% length > 0
    if(ith_Have_MCI){
      # have EMCI?
      DX = "EMCI"
      which_comments_EMCI_1 = c(paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "Early MCI")

      DX = "eMCI"
      which_comments_EMCI_2 = c(paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "early MCI")
      which_comments_EMCI = union(which_comments_EMCI_1, which_comments_EMCI_2)

      which_Rows_EMCI = sapply(which_comments_EMCI, function(x,...){grep(x, ith_Comments )}) %>% unlist %>% unique

      ith_RID.df$DIAGNOSIS_NEW[which_Rows_EMCI] = "EMCI"



      # have LMCI?
      DX = "LMCI"
      which_comments_LMCI = c(paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), "Late MCI", paste0("remains ", DX))
      which_Rows_LMCI = sapply(which_comments_LMCI, function(x,...){grep(x, ith_Comments)}) %>% unlist %>% unique
      ith_RID.df$DIAGNOSIS_NEW[which_Rows_LMCI] = "LMCI"
    }


    #===========================================================================
    # AD
    #===========================================================================
    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM

    ith_Which_Rows_Dementia = which(ith_RID.df$DIAGNOSIS_NEW == "Dementia")
    ith_Have_Dementia = ith_Which_Rows_Dementia %>% length > 0

    if(ith_Have_Dementia){
      DX = "AD"
      which_comments_AD_1 = c(paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))

      DX = "Alzheimer's"
      which_comments_AD_2 = c(paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))
      which_comments_AD = c(which_comments_AD_1, which_comments_AD_2, "Mild Alzheimer's")


      which_Rows_AD = sapply(which_comments_AD, function(x, ...){grep(x, ith_Comments)}) %>% unlist %>% unique
      ith_RID.df$DIAGNOSIS_NEW[which_Rows_AD] = "AD"
    }



    #===========================================================================
    # CN
    #===========================================================================
    DX = "CN"
    which_Comments_CN_1 = c(paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("fits the category of ", DX))
    which_Rows_CN_1 = sapply(which_Comments_CN_1 , function(y,...){
      grep(pattern = y, x = ith_Comments)
    }) %>% unlist %>% unique

    DX = "cognitively normal"
    which_Comments_CN_2 = c(paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("fits the category of ", DX))
    which_Rows_CN_2 = sapply(which_Comments_CN_2 , function(y,...){
      grep(pattern = y, x = ith_Comments)
    }) %>% unlist %>% unique

    which_Rows_CN = c(which_Rows_CN_1, which_Rows_CN_2) %>% unique %>% sort

    if(length(which_Rows_CN)>0){
      ith_RID.df$DIAGNOSIS_NEW[which_Rows_CN] = "CN"
    }

    return(ith_RID.df)
  })











  #=======================================================================
  # Diagnosis conversion
  #=======================================================================
  Diagnosis_New.list = lapply(seq_along(Change_Diagnosis_by_Comments.list), function(i,...){
    # i=112
    ith_RID.df = Change_Diagnosis_by_Comments.list[[i]]
    ith_VISCODE2 = ith_RID.df$VISCODE2

    ith_DX.bl = ith_RID.df$ADNIMERGE___DX.bl %>% na.omit() %>% unique()
    ith_DXCHANGE = ith_RID.df$DXSUM___DXCHANGE

    ith_DIAGNOSIS_NEW = ith_RID.df$DIAGNOSIS_NEW



    # sc : the first element
    # if(is.na(ith_DIAGNOSIS_NEW[1]) && ith_VISCODE2[1] == "sc"){
    #   ith_DIAGNOSIS_NEW[1] = ith_DIAGNOSIS[1]
    # }


    # # bl : the second element
    # ith_Has_bl = which(ith_VISCODE2[2]=="bl") %>% length > 0
    # if(ith_Has_bl & length(ith_DX.bl)>0){
    #   ith_DIAGNOSIS_NEW[2] = ith_DIAGNOSIS[2]
    #   # if(ith_DX.bl=="MCI"){
    #   #   if(ith_Diagnosis[2]=="EMCI"){
    #   #     ith_DIAGNOSIS_NEW[2] = "EMCI"
    #   #   }else if(ith_Diagnosis[2]=="LMCI"){
    #   #     ith_DIAGNOSIS_NEW[2] = "LMCI"
    #   #   }else{
    #   #     ith_DIAGNOSIS_NEW[2] = "MCI"
    #   #   }
    #   # }else{
    #   #   ith_DIAGNOSIS_NEW[2] = ith_DX.bl
    #   # }
    # }


    # DX Change
    for(k in seq_along(ith_DXCHANGE)[-(1:2)]){

      kth_DX = ith_DXCHANGE[k]

      if(is.na(kth_DX)){

        if(is.na(ith_DIAGNOSIS_NEW[k])){
          ith_DIAGNOSIS_NEW[k] = ith_DIAGNOSIS_NEW[k-1]
        }

      }else{
        # 1=Stable: NL to NL
        if(kth_DX==1){
          ith_DIAGNOSIS_NEW[k] = "CN"
          # 2=Stable: MCI to MCI;
        }else if(kth_DX==2){
          if(ith_DIAGNOSIS_NEW[k-1]=="EMCI"){
            ith_DIAGNOSIS_NEW[k] = "EMCI"
          }else if(ith_DIAGNOSIS_NEW[k-1]=="LMCI"){
            ith_DIAGNOSIS_NEW[k] = "LMCI"
          }else{
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }
          # 3=Stable: Dementia to Dementia;
        }else if(kth_DX==3){
          if(ith_DIAGNOSIS_NEW[k-1]=="AD"){
            ith_DIAGNOSIS_NEW[k] = "AD"
          }else{
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }
          # 4=Conversion: NL to MCI;
        }else if(kth_DX==4){
          if(ith_DIAGNOSIS_NEW[k]=="EMCI"){
            ith_DIAGNOSIS_NEW[k] = "EMCI"
          }else if(ith_DIAGNOSIS_NEW[k]=="LMCI"){
            ith_DIAGNOSIS_NEW[k] = "LMCI"
          }else{
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }
          # 5=Conversion: MCI to Dementia;
        }else if(kth_DX==5){
          if(ith_DIAGNOSIS_NEW[k]=="AD"){
            ith_DIAGNOSIS_NEW[k] = "AD"
          }else{
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }
          # 6=Conversion: NL to Dementia;
        }else if(kth_DX==6){
          if(ith_DIAGNOSIS_NEW[k]=="AD"){
            ith_DIAGNOSIS_NEW[k] = "AD"
          }else{
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }
          # 7=Reversion: MCI to NL;
        }else if(kth_DX==7){
          if(ith_DIAGNOSIS_NEW[k]=="SMC"){
            ith_DIAGNOSIS_NEW[k] = "SMC"
          }else{
            ith_DIAGNOSIS_NEW[k] = "CN"
          }
          # 8=Reversion: Dementia to MCI;
        }else if(kth_DX==8){
          if(ith_DIAGNOSIS_NEW[k]=="EMCI"){
            ith_DIAGNOSIS_NEW[k] = "EMCI"
          }else if(ith_DIAGNOSIS_NEW[k]=="LMCI"){
            ith_DIAGNOSIS_NEW[k] = "LMCI"
          }else{
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }
          # 9=Reversion: Dementia to NL
        }else if(kth_DX==9){
          if(ith_DIAGNOSIS_NEW[k]=="SMC"){
            ith_DIAGNOSIS_NEW[k] = "SMC"
          }else{
            ith_DIAGNOSIS_NEW[k] = "CN"
          }
        }
      }
    }# for

    ith_RID.df$DIAGNOSIS_NEW = ith_DIAGNOSIS_NEW
    return(ith_RID.df)
  })




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






  #=======================================================================
  # Exclude Subjects
  #=======================================================================
  Excluded.list = lapply(Diagnosis_New.list, function(ith_RID.df){
    # which(names(Merged_Data.list)=="6576")
    # ith_RID.df = Diagnosis_New.list[[400]]
    ith_CENROLL = ith_RID.df$CLIELG___CENROLL %>% as.character
    ith_RID.df$CLIELG___CENROLL %>% as.character

    ith_which_Exclude_1 = grep("should be excluded", ith_CENROLL)
    ith_which_Exclude_2 = grep("not eligible", ith_CENROLL)
    ith_which_Exclude_3 = grep("ineligible", ith_CENROLL)
    ith_which_Exclude = c(ith_which_Exclude_1, ith_which_Exclude_2, ith_which_Exclude_3) %>% unique %>% sort

    if(ith_which_Exclude %>% length > 0){
      ith_study.date = which(!is.na(ith_RID.df$RESEARCH.GROUP))
      if(ith_study.date %in% ith_which_Exclude){
        return(NULL)
      }else{
        return(ith_RID.df)
      }
    }else{
      return(ith_RID.df)
    }
  }) %>% rm_list_null()






  #=======================================================================
  # if all Dementia, check RESEARCH.GROUP &
  #=======================================================================
  Diagnosis_New_AD.list = lapply(Excluded.list, function(ith_RID.df){
    # which(names(Merged_Data.list)=="7109")
    # ith_RID.df = Excluded.list[[653]]
    # print(ith_RID.df$RID %>% unique)
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTADDX")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTHOME")
    # RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Data.Dictionary("PTDOBYY")

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




  cat("\n", crayon::green("Deciding diagnosis conversion is done!"),"\n")
  return(Diagnosis_New_AD_2.list)
}






  # Diagnosis_New.list[[2]]
  # Check_DX.bl = sapply(seq_along(Diagnosis_New.list), function(i){
