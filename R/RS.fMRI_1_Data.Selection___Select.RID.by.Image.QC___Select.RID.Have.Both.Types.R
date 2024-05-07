RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Select.RID.Have.Both.Types = function(QC.df, what.date){
  # QC.df = QC_8.df
  #===========================================================================
  # divide data
  #===========================================================================
  MT1.df = QC.df %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "MT1")
  EPI.df = QC.df %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "EPB")



  #===========================================================================
  # rename
  #===========================================================================
  Colnames_Selected = c("IMAGE_ID", "IMAGING.PROTOCOL___LONI_STUDY", "IMAGING.PROTOCOL___LONI_SERIES", "IMAGING.PROTOCOL___FMRI_PHASE_DIRECTION", "IMAGING.PROTOCOL___SERIES_DESCRIPTION", "IMAGING.PROTOCOL___SERIES_TYPE", "IMAGING.PROTOCOL___FIELD_STRENGTH", "IMAGING.PROTOCOL___FMRI_MEAN_SNR", "IMAGING.PROTOCOL___T1_ACCELERATED", "QC_VAR_SERIES_QUALITY", "QC_VAR_SERIES_COVERAGE_OCCIPITAL", "QC_VAR_SERIES_COVERAGE_VERMIS", "QC_VAR_SERIES_COVERAGE_CEREBELLUM", "QC_VAR_SERIES_COVERAGE_SUPERIOR", "QC_VAR_SERIES_COVERAGE_TEMPORAL", "QC_VAR_SERIES_COVERAGE_OTHER", "QC_VAR_FMRI_PHASE", "QC_VAR_FMRI_PENCIL", "QC_VAR_FMRI_VENETIAN", "QC_VAR_FMRI_DMN", "QC_VAR_FMRI_MOTION_DISPLAY", "QC_VAR_STUDY_MEDICAL_ABNORMALITIES", "QC_VAR_STUDY_RESCAN_REQUESTED", "QC_VAR_MEDICAL_EXCLUSION", "QC_COMMENTS_SERIES_COMMENTS", "QC_COMMENTS_STUDY_COMMENTS", "QC_COMMENTS_STUDY_PROTOCOL_COMMENT", "QC_COMMENTS_PROTOCOL_COMMENTS")
  MT1_2.df = change_colnames(MT1.df, from = Colnames_Selected, to = paste0("MT1___", Colnames_Selected))
  EPI_2.df = change_colnames(EPI.df, from = Colnames_Selected, to = paste0("EPI___", Colnames_Selected))



  #===========================================================================
  # RID having both
  #===========================================================================
  RID = QC.df$RID %>% unique()
  Selected_RID.list = lapply(RID, FUN=function(ith_RID, ...){
    ith_EPI.df = EPI_2.df %>% filter(RID==ith_RID)
    ith_MT1.df = MT1_2.df %>% filter(RID==ith_RID)

    if(nrow(ith_EPI.df)>0 && nrow(ith_MT1.df)>0){
      return(list(EPI = ith_EPI.df, MT1 = ith_MT1.df))
    }
  }) %>% rm_list_null()




  #===========================================================================
  # Select by date
  #===========================================================================
  RID_by_Date.list = lapply(Selected_RID.list, function(ith_RID.list, ...){
    ith_EPI.df = ith_RID.list[[1]]
    ith_MT1.df = ith_RID.list[[2]]

    ith_EPB_Dates = ith_EPI.df$SERIES_DATE
    ith_MT1_Dates = ith_MT1.df$SERIES_DATE
    ith_Intersection_Date = intersect(ith_EPB_Dates, ith_MT1_Dates)[what.date]

    cat("\n", crayon::yellow("QC_RID :"), crayon::bgRed(ith_EPI.df$RID %>% unique), crayon::yellow("is being selected by dates"),"\n")

    if(!is.na(ith_Intersection_Date)){
      list(EPI = ith_EPI.df %>% filter(SERIES_DATE == ith_Intersection_Date), MT1 = ith_MT1.df %>% filter(SERIES_DATE == ith_Intersection_Date)) %>% return
    }
  }) %>% rm_list_null()






  #===========================================================================
  # Merging
  #===========================================================================
  Merged.list = lapply(RID_by_Date.list, function(ith_RID.list){
    ith_EPI.df = ith_RID.list[[1]]
    ith_MT1.df = ith_RID.list[[2]]
    merge(ith_EPI.df, ith_MT1.df, by = intersect(names(ith_EPI.df), names(ith_MT1.df)), all = T) %>% relocate(ends_with("IMAGE_ID"), .after = SERIES_DATE)
  })
  names(Merged.list) = sapply(Merged.list, function(x){x$RID})


  return(Merged.list)
}


















