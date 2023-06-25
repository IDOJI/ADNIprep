#===========================================================================
# merging diagnosis vector
#===========================================================================
# Diagnosis
# CLIELG : AD, CN, EMCI, LMCI, SMC
# ADNIMERGE DX.bl :AD, CN, EMCI, LMCI, SMC
# ADNIMERGE DX :  CN, MCI, Dementia
# DXSUM Diagnosis : CN, Dementia, MCI
# DXSUM Current : AD, CN, MCIs
RS.fMRI_1_Data.Selection___Diagnosis___Merging.Diagnosis = function(Data.list){
  # Data.list = Dates_Added.list
  Merged_Diagnosis.list = lapply(seq_along(Data.list), function(i, ...){
    # i=210
    ith_RID.df = Data.list[[i]]
    ith_Diagnosis.df = data.frame(a = ith_RID.df$DXSUM___DIAGNOSIS, b = ith_RID.df$ADNIMERGE___DX, c = ith_RID.df$DXSUM___DXCURREN)

    ith_RID.df$DXSUM___DIAGNOSIS = ith_RID.df$ADNIMERGE___DX = ith_RID.df$DXSUM___DXCURREN = NULL

    ith_New_Diagnosis = apply(ith_Diagnosis.df, 1, function(kth_row){
      kth_row = kth_row %>% unlist %>% unname %>% na.omit %>% as.character %>% unique


      # AD
      have_Dementia = grep("Dementia", kth_row) %>% length > 0
      have_AD = grep("AD", kth_row) %>% length > 0


      # MCI
      have_LMCI = grep("LMCI", kth_row) %>% length > 0
      have_EMCI = grep("EMCI", kth_row) %>% length > 0
      have_MCI = grep("MCI", kth_row) %>% length > 0


      # SMC
      have_SMC = grep("SMC", kth_row) %>% length > 0


      # CN
      have_CN = grep("CN", kth_row) %>% length > 0



      if(kth_row %>% length == 0){
        return(NA)
        # MCI
      }else if(have_MCI){
        if(have_LMCI){
          return("LMCI")
        }else if(have_EMCI){
          return("EMCI")
        }else{
          return("MCI")
        }

        # AD
      }else if(have_Dementia){
        if(have_AD){
          return("AD")
        }else{
          return("Dementia")
        }

        # CN
      }else if(have_CN){
        return("CN")

        # SMC
      }else if(have_SMC){
        return("SMC")
      }
    })# apply

    if(is.list(ith_New_Diagnosis)){
      stop("it is a list")
    }

    ith_binded.df = cbind(DIAGNOSIS_OLD = ith_New_Diagnosis, ith_RID.df)
    # ith_binded.df$PHASE = factor(ith_binded.df$PHASE, levels = c("ADNI1", "ADNIGO", "ADNI2", "ADNI3"))
    # ith_binded.df$VISCODE2 = factor(ith_binded.df$VISCODE2, levels = c("sc", "scmri", "bl", "m0", "m03", "m06", "m12", "m18", "m24", "m30", "m36", "m42", "m48", "m54", "m60", "m66", "m72", "m78", "m84", "m90", "m96",
    #                                                                    "m102", "m114", "m120", "m126", "m132","m138", "m144",
    #                                                                    "m150", "m162", "m174", "m180", "m186", "m192", "m198", "m204"))
    #

    return(ith_binded.df)
  })


  return(Merged_Diagnosis.list)
}
