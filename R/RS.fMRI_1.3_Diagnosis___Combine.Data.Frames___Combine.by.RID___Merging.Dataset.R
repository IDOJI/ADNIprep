RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Merging.Dataset = function(EPB_Selected.df, New_BLCHANGE.list, New_DXSUM.list, New_PTDEMO.list, New_ADNIMERGE.list, New_CLIELG.list){
  RID = EPB_Selected.df$RID %>% sort

  Combined_Data.list = lapply(seq_along(RID), function(i, ...){
    # i=626
    ith_RID = RID[i]
    ith_EPB_Selected.df = EPB_Selected.df %>% filter(RID == ith_RID)
    #===========================================================================
    # BLCHANGE
    #===========================================================================
    # VISECODE2 : BLCHANGE
    ith_BLCHANGE.df = New_BLCHANGE.list[[i]]

    # VISECODE2 : DXSUM
    ith_DXSUM.df = New_DXSUM.list[[i]]

    if((is.na(ith_EPB_Selected.df$VISCODE) || is.na(ith_EPB_Selected.df$VISCODE2)) && !is.na(ith_BLCHANGE.df$BLCHANGE___EXAMDATE[1])){
      which_date = difftime(ith_EPB_Selected.df$STUDY.DATE, ith_BLCHANGE.df$BLCHANGE___EXAMDATE, units = "days") %>% abs %>% which.min

      ith_EPB_Selected.df$VISCODE =  ith_BLCHANGE.df$BLCHANGE___VISCODE[which_date]
      ith_EPB_Selected.df$VISCODE2 =  ith_BLCHANGE.df$BLCHANGE___VISCODE2[which_date]

      ith_Merged.df = merge(ith_EPB_Selected.df, ith_BLCHANGE.df, by.x = "VISCODE2", by.y = "BLCHANGE___VISCODE2", all=T)
      ith_Merged.df = merge(ith_Merged.df, ith_DXSUM.df, by.x = "VISCODE2", by.y = "DXSUM___VISCODE2", all=T)

    }else if((is.na(ith_EPB_Selected.df$VISCODE) || is.na(ith_EPB_Selected.df$VISCODE2)) && !is.na(ith_DXSUM.df$DXSUM___VISCODE2[1])){
      #===========================================================================
      # DXSUM
      #===========================================================================
      which_date = difftime(ith_EPB_Selected.df$STUDY.DATE, ith_DXSUM.df$DXSUM___EXAMDATE, units = "days") %>% abs %>% which.min
      ith_EPB_Selected.df$VISCODE =  ith_DXSUM.df$DXSUM___VISCODE[which_date]
      ith_EPB_Selected.df$VISCODE2 =  ith_DXSUM.df$DXSUM___VISCODE2[which_date]
      ith_Merged.df = merge(ith_EPB_Selected.df, ith_DXSUM.df, by.x = "VISCODE2", by.y = "DXSUM___VISCODE2", all=T)
      ith_Merged.df = merge(ith_Merged.df, ith_BLCHANGE.df, by.x = "VISCODE2", by.y = "BLCHANGE___VISCODE2", all=T)
    }else{
      ith_Merged.df = merge(ith_EPB_Selected.df, ith_DXSUM.df, by.x = "VISCODE2", by.y = "DXSUM___VISCODE2", all=T)
      ith_Merged.df = merge(ith_Merged.df, ith_BLCHANGE.df, by.x = "VISCODE2", by.y = "BLCHANGE___VISCODE2", all=T)
    }




    #===========================================================================
    # ADNIMERGE
    #===========================================================================
    ith_Merged_ADNIMERGE.df = merge(ith_Merged.df , New_ADNIMERGE.list[[i]], by.x = "VISCODE2", by.y = "ADNIMERGE___VISCODE", all=T)




    #===========================================================================
    # CLIELG
    #===========================================================================
    ith_Merged_CLIELG.df = merge(ith_Merged_ADNIMERGE.df, New_CLIELG.list[[i]], by.x = "VISCODE2", by.y = "CLIELG___VISCODE", all=T)


    #===========================================================================
    # PTDEMO
    #===========================================================================
    ith_Merged_PTDEMO.df = merge(ith_Merged_CLIELG.df, New_PTDEMO.list[[i]], by.x = "VISCODE2", by.y = "PTDEMO___VISCODE2", all=T)


    #===========================================================================
    # PTDEMO
    #===========================================================================
    ith_Combined.df = ith_Merged_PTDEMO.df
    if(length(ith_Combined.df$VISCODE2) == nrow(ith_Combined.df)){
      ADNIMERGE_EXAMDATE_which.na = is.na(ith_Combined.df$ADNIMERGE___EXAMDATE) %>% which
      ith_Combined.df$NEW_EXAMDATE = ith_Combined.df$ADNIMERGE___EXAMDATE
      ith_Combined.df$NEW_EXAMDATE[ADNIMERGE_EXAMDATE_which.na] = ith_Combined.df$PTDEMO___USERDATE[ADNIMERGE_EXAMDATE_which.na]
    }



    #===========================================================================
    # relocate cols
    #===========================================================================
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("DATE"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("VISCODE2"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("VISCODE"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("RID"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("_DX"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("BCPREDX"))
    ith_Combined.df = ith_Combined.df %>% relocate(ends_with("DX.bl"))
    ith_Combined.df = ith_Combined.df %>% relocate(NEW_EXAMDATE, .after = "VISCODE2")



    #===========================================================================
    # arrange
    #===========================================================================
    # arrange
    Levels = c("f", "bl", "sc", "scmri", "m06", "m12", "m18", "m24", "m30", "m36", "m60", "m66", "m72", "m78", "m84", "m90", "m96", "m102", "m120", "m144", "m162", "m174")
    ith_Combined.df$VISCODE2 = factor(ith_Combined.df$VISCODE2, levels = Levels)
    ith_Combined.df = ith_Combined.df[order(ith_Combined.df$VISCODE2),]
    ith_Combined.df = ith_Combined.df %>% arrange(NEW_EXAMDATE)


    #===========================================================================
    # remove cols
    #===========================================================================
    ith_Combined.df = replace_elements(ith_Combined.df, col_name = "BLCHANGE___VISCODE", from = NA, "NA")
    ith_Combined.df = replace_elements(ith_Combined.df, col_name = "DXSUM___VISCODE", from = NA, "NA")

    if(sum(ith_Combined.df$BLCHANGE___VISCODE == ith_Combined.df$DXSUM___VISCODE)==nrow(ith_Combined.df)){
      ith_Combined.df$BLCHANGE___VISCODE = NULL
      ith_Combined.df = replace_elements(ith_Combined.df, col_name = "DXSUM___VISCODE", from = "NA", to = NA)
    }




    #===========================================================================
    # merging diagnosis vector
    #===========================================================================
    # Diagnosis
    # CLIELG : AD, CN, EMCI, LMCI, SMC
    # ADNIMERGE DX.bl :AD, CN, EMCI, LMCI, SMC
    # ADNIMERGE DX :  CN, MCI, Dementia
    # DXSUM Diagnosis : CN, Dementia, MCI
    # DXSUM Current : AD, CN, MCIs
    ith_Diagnosis.df = data.frame(a = ith_Combined.df$CLIELG___DIAGNOSIS, b = ith_Combined.df$ADNIMERGE___DX, c = ith_Combined.df$DXSUM___DIAGNOSIS, d = ith_Combined.df$DXSUM___DXCURREN)


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

    ith_Combined.df$CLIELG___DIAGNOSIS = NULL
    ith_Combined.df$ADNIMERGE___DX = NULL
    ith_Combined.df$DXSUM___DIAGNOSIS = NULL
    ith_Combined.df$DXSUM___DXCURREN = NULL


    # RID
    ith_RID_1 = merge_vec(ith_Combined.df$RID, ith_Combined.df$DXSUM___RID)
    ith_RID_2 = merge_vec(ith_Combined.df$CLIELG___RID, ith_Combined.df$PTDEMO___RID)
    ith_RID_3 = merge_vec(ith_Combined.df$BLCHANGE___RID, ith_Combined.df$ADNIMERGE___RID %>% as.numeric)
    ith_RID = merge_vec(ith_RID_1, ith_RID_2) %>% merge_vec(ith_RID_3)
    if(grep("DUP", ith_RID) %>% length == 0){
      ith_Combined.df$RID = NULL
      ith_Combined.df$DXSUM___RID = NULL
      ith_Combined.df$CLIELG___RID = NULL
      ith_Combined.df$PTDEMO___RID = NULL
      ith_Combined.df$BLCHANGE___RID = NULL
      ith_Combined.df$ADNIMERGE___RID = NULL
    }



    # VISCODE
    # ith_VISCODE = merge_vec(ith_Combined.df$VISCODE, ith_Combined.df$DXSUM___VISCODE) %>% merge_vec(ith_Combined.df$PTDEMO___VISCODE)
    # if(grep("DUP", ith_VISCODE) %>% length == 0){
    #   ith_Combined.df$VISCODE = NULL
    #   ith_Combined.df$DXSUM___VISCODE = NULL
    #   ith_Combined.df$PTDEMO___VISCODE = NULL
    # }


    # combining
    ith_Combined_New.df = cbind(RID = ith_RID, DIAGNOSIS = ith_New_Diagnosis, ith_Combined.df)
    ith_Combined_New.df = ith_Combined_New.df %>% relocate(DXSUM___DXCHANGE)

    # ith_Combined_New.df = ith_Combined_New.df %>% relocate(VISCODE2, .after=VISCODE)
    # ith_Combined_New.df = ith_Combined_New.df %>% relocate(NEW_EXAMDATE, .after=VISCODE2)



    cat("\n", crayon::blue("Merging diagnosis dataset :"), crayon::red(paste0("RID_", ith_RID[1])), "\n")
    return(ith_Combined_New.df)
  })
  names(Combined_Data.list) = RID
  # Combined_Data.list[[739]]

  cat("\n",crayon::green("Merging Data is done!"),"\n")
  return(Combined_Data.list)
}
