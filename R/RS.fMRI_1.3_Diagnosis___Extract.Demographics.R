RS.fMRI_1.3_Diagnosis___Extract.Demographics = function(Time_To_First_AD.list){
  #=============================================================================
  # Add empty elements
  #=============================================================================
  Add_Empty_Elements.list = lapply(seq_along(Time_To_First_AD.list), function(i){
    ith_RID.df = Time_To_First_AD.list[[i]]

    # Hand
    ith_Hand = ith_RID.df$PTDEMO___PTHAND %>% na.omit %>% unique
    if(1 %in% ith_Hand | "Right" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Right", nrow(ith_RID.df))
    }else if(2 %in% ith_Hand | "Left" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Left", nrow(ith_RID.df))
    }


    # Gender
    ith_Gender = ith_RID.df$SEX %>% na.omit %>% unique
    if("Female" %in% ith_Gender | "F" %in% ith_Gender){
      ith_RID.df$ADNIMERGE___PTGENDER = rep("Female", nrow(ith_RID.df))
      ith_RID.df$SEX = rep("Female", nrow(ith_RID.df))
    }else if("Male" %in% ith_Gender | "M" %in% ith_Gender){
      ith_RID.df$ADNIMERGE___PTGENDER = rep("Male", nrow(ith_RID.df))
      ith_RID.df$SEX = rep("Male", nrow(ith_RID.df))
    }

    return(ith_RID.df)
  })



  #=============================================================================
  # demographic variable
  #=============================================================================
  Demo_Variables = c("WEIGHT",
                     "ADNIMERGE___AGE", "ADNIMERGE___PTGENDER", "ADNIMERGE___PTEDUCAT",
                     "ADNIMERGE___PTETHCAT", "ADNIMERGE___PTRACCAT",
                     "ADNIMERGE___PTMARRY", "ADNIMERGE___APOE4",
                     "ADNIMERGE___ADAS11", "ADNIMERGE___ADAS13", "ADNIMERGE___ADASQ4", "ADNIMERGE___MMSE",
                     "PTDEMO___PTWORKHS", "PTDEMO___PTWORK", "PTDEMO___PTWRECNT", "PTDEMO___PTNOTRT",
                     "PTDEMO___PTRTYR", "PTDEMO___PTHOME", "PTDEMO___PTOTHOME",
                     "PTDEMO___PTTLANG", "PTDEMO___PTPLANG")
  Demo_Variables_Added = paste0("DEMO___", Demo_Variables)
  Demo_Added.list = lapply(Add_Empty_Elements.list , function(ith_RID.df, ...){
    for(k in seq_along(Demo_Variables_Added)){
      ith_RID.df = change_colnames(ith_RID.df, from = Demo_Variables[k], to = Demo_Variables_Added[k])
    }


    for(k in seq_along(ith_RID.df)){
      ith_RID.df[,k] = ith_RID.df[,k] %>% as.character()

    }
    return(ith_RID.df)
  })





  #=============================================================================
  # Extract Demo variables
  #=============================================================================
  Selected_Variables = c("ADNIMERGE___COLPROT", "ADNIMERGE___ORIGPROT",
                         "PTDEMO___SITEID", "RID", "SUBJECT.ID", "Manufacturer_New",
                         "DAYS_TO_FIRST_AD",
                         "DIAGNOSIS_NEW", "BLCHANGE___BCSUMM", "DXSUM___DXCHANGE",
                         # fMRI MRI
                         "EPI___IMAGE_ID", "MT1___IMAGE_ID", "EPI___MANUFACTURER",
                         "EPI___SERIES_DESCRIPTION", "EPI___PROTOCOL___TR(QC)", "EPI___PROTOCOL___MANUFACTURER", "EPI___PROTOCOL___FIELD STRENGTH",
                         "EPI___SLICE.BAND.TYPE", "EPI___SERIES_DESCRIPTION", "MT1___T1_ACCELERATED",
                         # VISCODE
                         "VISIT", "VISCODE2", "VISCODE", "STUDY.DATE", "NEW_EXAMDATE",
                         # Diagnosis
                         "DIAGNOSIS_NEW","BLCHANGE___BCSUMM", "DXSUM___DXCHANGE",
                         # Demographic
                         "DEMO___WEIGHT", "DEMO___ADNIMERGE___AGE", "DEMO___ADNIMERGE___PTGENDER",
                         "DEMO___ADNIMERGE___PTEDUCAT", "DEMO___ADNIMERGE___PTETHCAT",
                         "DEMO___ADNIMERGE___PTRACCAT", "DEMO___ADNIMERGE___PTMARRY",
                         "DEMO___ADNIMERGE___APOE4", "DEMO___ADNIMERGE___ADAS11",
                         "DEMO___ADNIMERGE___ADAS13", "DEMO___ADNIMERGE___ADASQ4",
                         "DEMO___ADNIMERGE___MMSE", "DEMO___PTDEMO___PTWORKHS",
                         "DEMO___PTDEMO___PTWORK", "DEMO___PTDEMO___PTWRECNT",
                         "DEMO___PTDEMO___PTNOTRT", "DEMO___PTDEMO___PTRTYR",
                         "DEMO___PTDEMO___PTHOME", "DEMO___PTDEMO___PTOTHOME",
                         "DEMO___PTDEMO___PTTLANG", "DEMO___PTDEMO___PTPLANG")

  Selected_by_STUDY.DATE.list = lapply(Demo_Added.list, function(ith_RID.df, ...){
    ith_Selected.df = ith_RID.df %>% select(all_of(Selected_Variables))
    ith_Selected.df[!is.na(ith_Selected.df$STUDY.DATE),]
  })




  #=============================================================================
  # Binding
  #=============================================================================
  Only_Demographics.df = do.call(dplyr::bind_rows, Selected_by_STUDY.DATE.list) %>% relocate(starts_with("EPI___"), .after=last_col()) %>% relocate(starts_with("MT1___"), .after=last_col())
  Full.df = do.call(dplyr::bind_rows, Demo_Added.list) %>% relocate(starts_with("EPI___"), .after=last_col()) %>% relocate(starts_with("MT1___"), .after=last_col())


  Only_Demographics.df$BLCHANGE___VISCODE = Only_Demographics.df$VISCODE
  Only_Demographics.df = Only_Demographics.df %>% relocate(starts_with("SUBJECT.ID")) %>% relocate(starts_with("RID"))


  Full.df$BLCHANGE___VISCODE =  Full.df$VISCODE
  Full.df = Full.df %>% relocate(BLCHANGE___VISCODE, .after = PTDEMO___VISCODE)
  Full.df = Full.df %>% relocate(starts_with("SUBJECT.ID")) %>% relocate(starts_with("RID"))



  cat("\n", crayon::green("Extracting Demographics is done!") ,"\n")
  return(list(Only_Study.Date = Only_Demographics.df, Full_Data = Full.df))
}
