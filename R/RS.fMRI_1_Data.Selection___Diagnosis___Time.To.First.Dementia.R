RS.fMRI_1_Data.Selection___Diagnosis___Time.To.First.Dementia = function(Diagnosis.list){

  Added_AD_Days.list = lapply(seq_along(Diagnosis.list), function(i){
    # ith_RID.df = Diagnosis.list[[469]]
    ith_RID.df = Diagnosis.list[[i]]
    ith_RID.df$DAYS_TO_FIRST_AD = NA
    ith_RID.df = ith_RID.df %>% relocate(DAYS_TO_FIRST_AD) %>% relocate(ends_with("DATE"), .after=RID)
    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW

    ith_Current_Row = which(!is.na(ith_RID.df$STUDY.DATE))
    ith_Diagnosis_Current = ith_RID.df[ith_Current_Row, "DIAGNOSIS_NEW"]


    ith_Dates = ith_RID.df$REGISTRY___EXAMDATE
    View(ith_RID.df)
    ith_study.date = ith_RID.df$STUDY.DATE %>% na.omit %>% as.Date()

    if("AD" %in% ith_Diagnosis | "AD(Probable)" %in% ith_Diagnosis | "AD(Possible)" %in% ith_Diagnosis | "Dementia" %in% ith_Diagnosis){
      ith_which_First_AD = which(ith_Diagnosis %in% c("AD", "AD(Probable)", "AD(Possible)", "Dementia"))[1]
      if(ith_Current_Row < ith_which_First_AD){
        ith_First_AD_Date = ith_Dates[ith_which_First_AD] %>% as.Date()
        DAYS_TO_FIRST_AD = difftime(ith_First_AD_Date, ith_study.date, units = "days")
        ith_RID.df[ith_Current_Row, "DAYS_TO_FIRST_Dementia"] = DAYS_TO_FIRST_AD
      }
    }
    return(ith_RID.df)
  })

  cat("\n",crayon::green("Adding days to the first AD is done!"),"\n")
  return(Added_AD_Days.list)
}
