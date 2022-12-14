RS.fMRI_1.2_Merging.Lists___Combining.By.Series.Type = function(data.list=Merged_by_dates.list){
  ### extracting
  EPB.list = lapply(data.list, FUN=function(x){
    return(x[[1]])
  })
  MT1.list = lapply(data.list, FUN=function(x){
    return(x[[2]])
  })


  ### combining
  EPB.df = do.call(rbind, EPB.list)
  MT1.df = do.call(rbind, MT1.list)


  ### rm same cols
  EPB_2.df = rm_dup_cols(EPB.df)
  MT1_2.df = rm_dup_cols(MT1.df)

  ### rm cols
  EPB_3.df = EPB_2.df
  EPB_3.df$ARCHIVE.DATE = NULL
  EPB_3.df$T1_ACCELERATED = NULL
  EPB_3.df = EPB_3.df %>% dplyr::rename(RID=RID_SEARCH)
  EPB_3.df = EPB_3.df %>% dplyr::rename("TE"="FMRI_TE")
  EPB_3.df = EPB_3.df %>% dplyr::rename("TR"="FMRI_TR")
  EPB_3.df = EPB_3.df %>% dplyr::rename("MEAN_SNR"="FMRI_MEAN_SNR")
  EPB_3.df = EPB_3.df %>% dplyr::rename("QC_VAR_OVERALLQC"="OVERALLQC")
  EPB_3.df = EPB_3.df%>% dplyr::select(-starts_with("MRI_"))


  MT1_3.df = MT1_2.df
  MT1_3.df$FMRI_MEAN_SNR = NULL
  MT1_3.df$FMRI_TE       = NULL
  MT1_3.df = MT1_3.df %>% dplyr::rename(RID=RID_SEARCH)



  #=============================================================================
  # EPB : relocate cols & renaming
  #=============================================================================
  EPB_4.df = EPB_3.df
  PHASE = c("PHASE_SQ", "PHASE_NFQ")
  ID    = c("IMAGE_ID", "LONI_STUDY", "LONI_SERIES","RID", "SUBJECT.ID")
  DEMO  = c("AGE","SEX","WEIGHT", "RESEARCH.GROUP")
  TIME  = c("VISIT", "VISCODE", "VISCODE2","STUDY.DATE","SERIESTIME")
  TYPE  = c("MODALITY","SERIES_TYPE", "DESCRIPTION")
  MANU  = c("MANUFACTURER_SQ", "MANUFACTURER_NFQ", "MANUFACTURERSMODELNAME","SOFTWAREVERSIONS")
  SCANNING  = c("FIELD STRENGTH", "FIELD_STRENGTH", "SLICE THICKNESS", "REPETITIONTIME", "TR","TE", "MEAN_SNR", "NFQ")
  SLICE.TIMING = c("SLICE.TIMING_RAW", "SLICE.TIMING_MIN", "SLICE.TIMING_ORDER")
  QC_COMMENTS =c("QC_COMMENTS_SERIES_COMMENTS","QC_COMMENTS_STUDY_COMMENTS","QC_COMMENTS_STUDY_PROTOCOL_COMMENT","QC_COMMENTS_PROTOCOL_COMMENTS")
  QC_VAR =c("QC_VAR_SERIES_QUALITY","QC_VAR_SERIES_COVERAGE_OCCIPITAL","QC_VAR_STUDY_MEDICAL_ABNORMALITIES","QC_VAR_STUDY_RESCAN_REQUESTED","QC_VAR_MEDICAL_EXCLUSION","QC_VAR_OVERALLQC")
  names.list = list(PHASE, ID, DEMO, TIME, TYPE, MANU, SCANNING, SLICE.TIMING, QC_COMMENTS, QC_VAR)
  for(i in 1:length(names.list)){
    ith_names = names.list[[i]]
    EPB_4.df = EPB_4.df %>% dplyr::relocate(!!ith_names, .after = last_col())
  }
  # renames_before.vec = c(ID, DEMO, TIME, TYPE, MANU, SCANNING)
  # ID = paste("ID", ID, sep="___")
  # DEMO = paste("DEMO", DEMO, sep="___")
  # TIME = paste("TIME", TIME, sep="___")
  # TYPE = paste("TYPE", TYPE, sep="___")
  # MANU = paste("MANU", MANU, sep="___")
  # SCANNING = paste("SCANNING", SCANNING, sep="___")
  # renames_after.vec = c(ID, DEMO, TIME, TYPE, MANU, SCANNING)
  # for(k in 1:length(renames_after.vec)){
  #   EPB_4.df = EPB_4.df %>% dplyr::rename(!!renames_after.vec[k]:=!!renames_before.vec[k])
  # }



  #=============================================================================
  # MT1 : relocate cols & renaming
  #=============================================================================
  MT1_4.df = MT1_3.df

  return(list(EPB_4.df, MT1_4.df))
}
