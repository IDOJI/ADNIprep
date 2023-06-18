RS.fMRI_1.3_Diagnosis___Time.To.First.AD = function(Merged_with_MT1.list){
  Added_AD_Days.list = lapply(Merged_with_MT1.list, function(ith_RID.df){
    # ith_RID.df = Merged_with_MT1.list[[486]]
    ith_RID.df$DAYS_TO_FIRST_AD = NA
    ith_RID.df = ith_RID.df %>% relocate(DAYS_TO_FIRST_AD)
    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW

    ith_Current_Row = which(!is.na(ith_RID.df$STUDY.DATE))
    ith_Diagnosis_Current = ith_RID.df[ith_Current_Row, "DIAGNOSIS_NEW"]

    ith_Dates = ith_RID.df$NEW_EXAMDATE
    ith_study.date = ith_RID.df$STUDY.DATE %>% na.omit %>% as.Date()

    if("AD" %in% ith_Diagnosis | "AD(Probable)" %in% ith_Diagnosis | "AD(Possible)" %in% ith_Diagnosis){
      ith_which_First_AD = which(ith_Diagnosis %in% c("AD", "AD(Probable)", "AD(Possible)"))[1]
      if(ith_Current_Row < ith_which_First_AD){
        ith_First_AD_Date = ith_Dates[ith_which_First_AD] %>% as.Date()
        DAYS_TO_FIRST_AD = difftime(ith_First_AD_Date, ith_study.date, units = "days")
        ith_RID.df[ith_Current_Row, "DAYS_TO_FIRST_AD"] = DAYS_TO_FIRST_AD
      }
    }
    return(ith_RID.df)
  })

  cat("\n",crayon::green("Adding days to the first AD is done!"),"\n")
  return(Added_AD_Days.list)
}
