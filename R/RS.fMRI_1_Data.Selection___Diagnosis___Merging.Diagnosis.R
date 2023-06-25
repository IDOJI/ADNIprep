#===========================================================================
# merging diagnosis vector
#===========================================================================
# Diagnosis
# CLIELG : AD, CN, EMCI, LMCI, SMC
# ADNIMERGE DX.bl :AD, CN, EMCI, LMCI, SMC
# ADNIMERGE DX :  CN, MCI, Dementia
# DXSUM Diagnosis : CN, Dementia, MCI
# DXSUM Current : AD, CN, MCIs
RS.fMRI_1_Data.Selection___Diagnosis___Merging.Diagnosis = function(Merged_Full.list){
  Merged_Diagnosis.list = lapply(seq_along(Merged_Full.list), function(i, ...){
    # i=626
    ith_RID.df = Merged_Full.list[[i]]
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

    return(cbind(DIAGNOSIS_NEW = ith_New_Diagnosis, ith_RID.df))
  })


  return(Merged_Diagnosis.list)
}
