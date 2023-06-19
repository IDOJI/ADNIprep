RS.fMRI_1.3_Diagnosis___Extract.Demographics___Selecting.Variables = function(Data.list){
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

  cat("\n",crayon::green("Selecting"), crayon::red("Variables"), crayon::green("is done!"),"\n")
  return(list(Data.list, Selected_by_STUDY.DATE.list))
}
