RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Diagnosis___Comments = function(Data.list){
  # Data.list = Merged_Data.list

  Returned.list = lapply(Data.list, function(ith_RID.df){
    # ith_RID.df = Merged_Data.list[[8]]
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
      which_comments_EMCI_1 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "Early MCI")

      DX = "eMCI"
      which_comments_EMCI_2 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "early MCI")

      DX = "early MCI"
      which_comments_EMCI_3 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "early MCI")


      DX = "Early MCI"
      which_comments_EMCI_4 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX), "early MCI")


      which_comments_EMCI = c(which_comments_EMCI_1, which_comments_EMCI_2, which_comments_EMCI_3, which_comments_EMCI_4)



      which_Rows_EMCI = sapply(which_comments_EMCI, function(x,...){grep(x, ith_Comments, ignore.case = T)}) %>% unlist %>% unique

      # ith_RID.df$BLCHANGE___BCSUMM[which_Rows_EMCI]
      if(length(which_Rows_EMCI)>0){
        ith_RID.df$DIAGNOSIS_NEW[which_Rows_EMCI] = "EMCI"
      }


      # have LMCI?
      DX = "LMCI"
      which_comments_LMCI_1 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), "Late MCI", paste0("remains ", DX))

      DX = "late MCI"
      which_comments_LMCI_2 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), "Late MCI", paste0("remains ", DX))

      which_comments_LMCI = c(which_comments_LMCI_1, which_comments_LMCI_2)

      which_Rows_LMCI = sapply(which_comments_LMCI, function(x,...){grep(x, ith_Comments, ignore.case = T)}) %>% unlist %>% unique
      if(length(which_Rows_LMCI)>0){
        ith_RID.df$DIAGNOSIS_NEW[which_Rows_LMCI] = "LMCI"
      }

    }


    #===========================================================================
    # AD
    #===========================================================================
    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM

    ith_Which_Rows_Dementia = which(ith_RID.df$DIAGNOSIS_NEW == "Dementia")
    ith_Have_Dementia = ith_Which_Rows_Dementia %>% length > 0

    if(ith_Have_Dementia){
      DX = "AD"
      which_comments_AD_1 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))

      DX = "Alzheimer's"
      which_comments_AD_2 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))


      DX = "early AD"
      which_comments_AD_3 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))


      DX = "early Alzheimer's"
      which_comments_AD_4 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))


      DX = "mild Alzheimer's"
      which_comments_AD_5 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))


      DX = "mild AD"
      which_comments_AD_6 = c(paste0("meets criteria for early ", DX), paste0("continues as ", DX), paste0("continue as ", DX), paste0("Conversion to ", DX), paste0("progressed to ", DX), paste0("focal ", DX, " variant"), paste0("focal variant of ", DX), paste0("progression of ", DX), paste0("due to ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("remains ", DX))


      which_comments_AD = c(which_comments_AD_1, which_comments_AD_2, which_comments_AD_3, which_comments_AD_4, which_comments_AD_5, which_comments_AD_6, "Mild Alzheimer's")


      which_Rows_AD = sapply(which_comments_AD, function(x, ...){grep(x, ith_Comments, ignore.case = T)}) %>% unlist %>% unique


      if(length(which_Rows_AD)>0){
        ith_RID.df$DIAGNOSIS_NEW[which_Rows_AD] = "AD"
      }


    }



    #===========================================================================
    # CN
    #===========================================================================
    DX = "CN"
    which_Comments_CN_1 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("fits the category of ", DX))

    DX = "cognitively normal"
    which_Comments_CN_2 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("fits the category of ", DX))


    DX = "normal"
    which_Comments_CN_3 = c(paste0("continues as ", DX), paste0("continue as ", DX), paste0("criteria for ", DX), paste0("converted to ", DX), paste0("continues as ", DX), paste0("remain ", DX), paste0("consistent with ", DX), paste0("best into category of ", DX), paste0("fits the category of ", DX))


    which_Comments_CN = c(which_Comments_CN_1, which_Comments_CN_2, which_Comments_CN_3)


    which_Rows_CN = sapply(which_Comments_CN, function(x, ...){grep(x, ith_Comments, ignore.case = T)}) %>% unlist %>% unique


    if(length(which_Rows_CN)>0){
      ith_RID.df$DIAGNOSIS_NEW[which_Rows_CN] = "CN"
    }



    return(ith_RID.df)
  })

  return(Returned.list)
}
