RS.fMRI_1.2_Merging.Lists___Merging.EPI.and.MT1 = function(Modifying_cols.list){
  #=============================================================================
  # EPB & MT1
  #=============================================================================
  EPB.df = Modifying_cols.list[[1]]
  MT1.df = Modifying_cols.list[[2]]



  #=============================================================================
  # MRI colnames change
  #=============================================================================
  MRI_Info_1.1 = c("PROTOCOL.MRI___SLICE THICKNESS", "PROTOCOL.MRI___FIELD STRENGTH", "PROTOCOL.MRI___MFG MODEL", "PROTOCOL.MRI___ACQUISITION PLANE", "PROTOCOL.MRI___MATRIX Z", "PROTOCOL.MRI___ACQUISITION TYPE", "PROTOCOL.MRI___MANUFACTURER", "PROTOCOL.MRI___WEIGHTING")
  MRI_Info_1.2 = gsub(pattern = "PROTOCOL.MRI___", replacement = "MT1___PROTOCOL___", MRI_Info_1.1)
  Result = sapply(seq_along(MRI_Info_1.1), function(k,...){
    MT1.df <<- change_colnames(MT1.df, from = MRI_Info_1.1[k], to = MRI_Info_1.2[k])
  })

  MRI_Info_2.1 = c("IMAGE_ID", "VISIT", "ARCHIVE.DATE", "SERIES_TYPE", "SERIES_DESCRIPTION", "FIELD_STRENGTH",
                   "QC_VAR_SERIES_QUALITY", "QC_VAR_SERIES_COVERAGE_OCCIPITAL", "QC_VAR_SERIES_COVERAGE_VERMIS",
                   "QC_VAR_SERIES_COVERAGE_CEREBELLUM", "QC_VAR_SERIES_COVERAGE_SUPERIOR",
                   "QC_VAR_SERIES_COVERAGE_TEMPORAL", "QC_VAR_SERIES_COVERAGE_OTHER", "QC_VAR_FMRI_PHASE", "QC_VAR_FMRI_PENCIL", "QC_VAR_FMRI_VENETIAN", "QC_VAR_FMRI_DMN", "QC_VAR_FMRI_MOTION_DISPLAY", "QC_VAR_STUDY_MEDICAL_ABNORMALITIES", "QC_VAR_STUDY_RESCAN_REQUESTED", "QC_VAR_MEDICAL_EXCLUSION", "QC_COMMENTS_SERIES_COMMENTS", "QC_COMMENTS_STUDY_COMMENTS", "QC_COMMENTS_STUDY_PROTOCOL_COMMENT", "QC_COMMENTS_PROTOCOL_COMMENTS")
  MRI_Info_2.2 = paste0("MT1___", MRI_Info_2.1)
  Result = sapply(seq_along(MRI_Info_2.1), function(k,...){
    MT1.df <<- change_colnames(MT1.df, from = MRI_Info_2.1[k], to = MRI_Info_2.2[k])
  })



  MRI_Info_3.1 = c("MRI___T1_ACCELERATED", "MRI___MODALITY", "MRI___LONI.STUDY", "MRI___LONI.SERIES")
  MRI_Info_3.2 = gsub("MRI___", "MT1___", MRI_Info_3.1)
  Result = sapply(seq_along(MRI_Info_3.1), function(k,...){
    MT1.df <<- change_colnames(MT1.df, from = MRI_Info_3.1[k], to = MRI_Info_3.2[k])
  })


  MT1.df$SEX = NULL
  MT1.df$WEIGHT = NULL
  MT1.df$AGE = NULL
  MT1.df$PHASE = NULL
  MT1.df$PROJECT = NULL
  MT1.df$RESEARCH.GROUP = NULL
  MT1.df$Manufacturer_New = NULL
  MT1.df = MT1.df %>% relocate(starts_with("MT1___"), .after = last_col())






  #=============================================================================
  # Change fMRI names
  #=============================================================================
  fMRI_Info_1.1 = c("IMAGE_ID",
                    "PATIENTSAGE",
                    "NFQ",
                    "MODALITY",
                    "SERIES_DESCRIPTION",
                    "DESCRIPTION",
                    "SERIES_TYPE",
                    "MANUFACTURER",
                    "MANUFACTURERSMODELNAME",
                    "QC_VAR_OVERALLQC",
                    "QC_VAR_SERIES_QUALITY",
                    "QC_VAR_SERIES_COVERAGE_OCCIPITAL",
                    "QC_VAR_SERIES_COVERAGE_VERMIS",
                    "QC_VAR_SERIES_COVERAGE_CEREBELLUM",
                    "QC_VAR_SERIES_COVERAGE_SUPERIOR",
                    "QC_VAR_SERIES_COVERAGE_TEMPORAL",
                    "QC_VAR_SERIES_COVERAGE_OTHER",
                    "QC_VAR_FMRI_PHASE",
                    "QC_VAR_FMRI_PENCIL",
                    "QC_VAR_FMRI_VENETIAN",
                    "QC_VAR_FMRI_DMN",
                    "QC_VAR_FMRI_MOTION_DISPLAY",
                    "QC_VAR_STUDY_MEDICAL_ABNORMALITIES",
                    "QC_VAR_STUDY_RESCAN_REQUESTED",
                    "QC_VAR_MEDICAL_EXCLUSION",
                    "QC_COMMENTS_SERIES_COMMENTS",
                    "QC_COMMENTS_STUDY_COMMENTS",
                    "QC_COMMENTS_STUDY_PROTOCOL_COMMENT",
                    "QC_COMMENTS_PROTOCOL_COMMENTS")
  fMRI_Info_1.2 = paste0("EPI___", fMRI_Info1.1)

  Result = sapply(seq_along(fMRI_Info_1.1), function(k,...){
    EPB.df <<- change_colnames(EPB.df, from = fMRI_Info_1.1[k], to = fMRI_Info_1.2[k])
  })

  fMRI_Info_2.1 = c("PROTOCOL.FMRI___SERIESTIME", "PROTOCOL.FMRI___TR QC.",
                    "PROTOCOL.FMRI___TR SEARCH.", "PROTOCOL.FMRI___SOFTWAREVERSIONS",
                    "PROTOCOL.FMRI___MANUFACTURER", "PROTOCOL.FMRI___MFG MODEL",
                    "PROTOCOL.FMRI___TE", "PROTOCOL.FMRI___SLICE.THICKNESS",
                    "PROTOCOL.FMRI___FIELD STRENGTH", "PROTOCOL.FMRI___ACQUISITION PLANE",
                    "PROTOCOL.FMRI___MATRIX Z", "PROTOCOL.FMRI___ACQUISITION TYPE", "PROTOCOL.FMRI___WEIGHTING",
                    "PROTOCOL.FMRI___TR(QC)", "PROTOCOL.FMRI___TR(SEARCH)", "PROTOCOL.FMRI___SLICE THICKNESS")

  fMRI_Info_2.2 = gsub("PROTOCOL.FMRI", "EPI___PROTOCOL", fMRI_Info_2.1)
  Result = sapply(seq_along(fMRI_Info_2.1), function(k,...){
    EPB.df <<- change_colnames(EPB.df, from = fMRI_Info_2.1[k], to = fMRI_Info_2.2[k])
  })


  fMRI_Info_3.1 = c("FMRI___LONI.STUDY", "FMRI___LONI.SERIES", "FMRI___SLICE.TIMING", "FMRI___SLICE.ORDER", "FMRI___SLICE.ORDER.TYPE", "FMRI___SLICE.BAND.TYPE", "FMRI___PHASE_DIRECTION", "FMRI___MEAN_SNR")
  fMRI_Info_3.2 = gsub("FMRI___", "EPI___", fMRI_Info_3.1)
  Result = sapply(seq_along(fMRI_Info_3.1), function(k,...){
    EPB.df <<- change_colnames(EPB.df, from = fMRI_Info_3.1[k], to = fMRI_Info_3.2[k])
  })

  EPB.df = EPB.df %>% relocate(starts_with("EPI___"), .after = last_col())




  #=============================================================================
  # merge with MT1
  #=============================================================================
  EPB.df$RID = EPB.df$RID %>% as.numeric
  MT1.df$RID = MT1.df$RID %>% as.numeric
  Merged.df = merge(MT1.df, EPB.df, by = "RID") %>% arrange(RID)
  Merged.df = Merged.df %>% relocate(starts_with("EPI___"), .after = last_col())
  Merged.df = Merged.df %>% relocate(starts_with("MT1___"), .after = last_col())



  #=============================================================================
  # remove same cols
  #=============================================================================
  if(sum(Merged.df$SUBJECT.ID.x == Merged.df$SUBJECT.ID.y) == nrow(Merged.df)){
    Merged.df$SUBJECT.ID.x = NULL
    Merged.df = Merged.df %>% rename(SUBJECT.ID = SUBJECT.ID.y)
  }

  if(sum(Merged.df$STUDY.DATE.x == Merged.df$STUDY.DATE.y) == nrow(Merged.df)){
    Merged.df$STUDY.DATE.y = NULL
    Merged.df = Merged.df %>% rename(STUDY.DATE = STUDY.DATE.x)
  }


  cat("\n", crayon::green("Merging EPI and MT1 df is done!") ,"\n")
  return(Merged.df)
}











