RS.fMRI_1_Data.Selection___Demographics = function(Merged_Diagnosis.list, path_Subjects.Lists_Downloaded, Subjects_APOE){
  #=============================================================================
  # Handedness
  #=============================================================================
  Handedness.list = RS.fMRI_1_Data.Selection___Demographics___Handedness(Merged_Diagnosis.list)




  #=============================================================================
  # Gender
  #=============================================================================
  Gender.list = RS.fMRI_1_Data.Selection___Demographics___Gender(Handedness.list)




  #=============================================================================
  # Retirement
  #=============================================================================
  Retire.list = RS.fMRI_1_Data.Selection___Demographics___Retirement(Gender.list)





  #=============================================================================
  # Education
  #=============================================================================
  Education.list = RS.fMRI_1_Data.Selection___Demographics___Education(Retire.list)





  #=============================================================================
  # Marital status
  #=============================================================================
  Marriage.list = RS.fMRI_1_Data.Selection___Demographics___Marriage(Education.list)





  #=============================================================================
  # APOE
  #=============================================================================
  APOE.list = RS.fMRI_1_Data.Selection___Demographics___APOE(Marriage.list, path_Subejcts_APOE, Subjects_APOE)




  #=============================================================================
  # Binding
  #=============================================================================
  Binded.df = RS.fMRI_1_Data.Selection___Demographics___Combining.Data(APOE.list)




  #=============================================================================
  # Selecting demographic variable
  #=============================================================================
  Demo.df = RS.fMRI_1_Data.Selection___Demographics___Demographic.Variables(Binded.df)



  #=============================================================================
  # MMSE
  #=============================================================================
  MMSE.df = RS.fMRI_1_Data.Selection___Demographics___MMSE(Demo.df)



  cat("\n", crayon::green("Extracting Demographics is done!") ,"\n")
  return(MMSE.df)
}




#=============================================================================
# Extract Demo variables
#=============================================================================
# Selected.list = RS.fMRI_1_Data.Selection___Demographics___Selecting.Variables(Demo.list)
#
# RS.fMRI_1.2_Merging.Lists___Modifying.Cols = function(data.list){
#   # data.list = Combined.list
#   #=============================================================================
#   # Rename cols
#   #=============================================================================
#   selected_cols = c("MODALITY", "DESCRIPTION")
#   data_2.list = lapply(data.list, function(ith_df, ...){
#     names(ith_df)[which(names(ith_df) %in% c(selected_cols))] = paste0("IMAGING.PROTOCOL___", selected_cols)
#     return(ith_df)
#   })
#
#
#   #=============================================================================
#   # Moving Cols
#   #=============================================================================
#   Selected_Cols = c("NFQ___", "IMAGING.PROTOCOL", "QC_VAR_", "QC_COMMENTS")
#   data_3.list = lapply(data_2.list, function(ith_df,...){
#     for(k in seq_along(Selected_Cols)){
#       ith_df = ith_df %>% relocate(starts_with(Selected_Cols[k]), .after = last_col())
#     }
#     return(ith_df)
#   })
#
#   EPI.df = data_3.list[[1]]
#   MT1.df = data_3.list[[2]]
#
#
#
#
#   #=============================================================================
#   # Define and Move Dates Variables
#   #=============================================================================
#   Selected_Cols = c("SCAN.DATE", "VISCODE", "VISCODE2", "VISIT", "ARCHIVE.DATE")
#   names(EPI.df)[which(names(EPI.df) %in% Selected_Cols)] = paste0("DATES___", Selected_Cols)
#   EPI.df = EPI.df %>% relocate(starts_with("DATES___"), .after = FAQ.TOTAL.SCORE)
#
#   Selected_Cols = c("SCAN.DATE", "VISIT", "ARCHIVE.DATE")
#   names(MT1.df)[which(names(MT1.df) %in% Selected_Cols)] = paste0("DATES___", Selected_Cols)
#   MT1.df = MT1.df %>% relocate(starts_with("DATES___"), .after = FAQ.TOTAL.SCORE)
#
#
#
#
#   #=============================================================================
#   # Demographics
#   #=============================================================================
#   Selected_Demo_Cols = c("SEX", "WEIGHT", "RESEARCH.GROUP", "APOE.A1", "APOE.A2", "AGE", "GLOBAL.CDR", "NPI.Q.TOTAL.SCORE", "MMSE.TOTAL.SCORE", "GDSCALE.TOTAL.SCORE", "FAQ.TOTAL.SCORE")
#   # remove from MT1
#   for(k in seq_along(Selected_Demo_Cols)){
#     MT1.df[, Selected_Demo_Cols[k]] = NULL
#   }
#   # adding DEMO
#   names(EPI.df)[which(names(EPI.df) %in% Selected_Demo_Cols)] = paste0("DEMO___", Selected_Demo_Cols)
#
#
#
#
#
#   #=============================================================================
#   # Adding "EPI" & "MT1"
#   #=============================================================================
#   # print_colnames(MT1.df)
#   # print_colnames(EPI.df)
#   MT1_Cols = c("IMAGING.PROTOCOL___MODALITY", "IMAGING.PROTOCOL___DESCRIPTION", "IMAGING.PROTOCOL___Acquisition Plane", "IMAGING.PROTOCOL___Slice Thickness", "IMAGING.PROTOCOL___Matrix Z", "IMAGING.PROTOCOL___Acquisition Type", "IMAGING.PROTOCOL___Manufacturer", "IMAGING.PROTOCOL___Mfg Model", "IMAGING.PROTOCOL___Field Strength", "IMAGING.PROTOCOL___Weighting", "IMAGING.PROTOCOL___LONI_STUDY", "IMAGING.PROTOCOL___LONI_SERIES", "IMAGING.PROTOCOL___FMRI_PHASE_DIRECTION", "IMAGING.PROTOCOL___SERIES_DESCRIPTION", "IMAGING.PROTOCOL___SERIES_TYPE", "IMAGING.PROTOCOL___FIELD_STRENGTH", "IMAGING.PROTOCOL___FMRI_MEAN_SNR", "IMAGING.PROTOCOL___T1_ACCELERATED", "QC_VAR_SERIES_QUALITY", "QC_VAR_SERIES_COVERAGE_OCCIPITAL", "QC_VAR_SERIES_COVERAGE_VERMIS", "QC_VAR_SERIES_COVERAGE_CEREBELLUM", "QC_VAR_SERIES_COVERAGE_SUPERIOR", "QC_VAR_SERIES_COVERAGE_TEMPORAL", "QC_VAR_SERIES_COVERAGE_OTHER", "QC_VAR_FMRI_PHASE", "QC_VAR_FMRI_PENCIL", "QC_VAR_FMRI_VENETIAN", "QC_VAR_FMRI_DMN", "QC_VAR_FMRI_MOTION_DISPLAY", "QC_VAR_STUDY_MEDICAL_ABNORMALITIES", "QC_VAR_STUDY_RESCAN_REQUESTED", "QC_VAR_MEDICAL_EXCLUSION", "QC_COMMENTS_SERIES_COMMENTS", "QC_COMMENTS_STUDY_COMMENTS", "QC_COMMENTS_STUDY_PROTOCOL_COMMENT", "QC_COMMENTS_PROTOCOL_COMMENTS")
#   EPI_Cols = c("NFQ___SERIESTIME", "NFQ___MANUFACTURER", "NFQ___MANUFACTURERSMODELNAME", "NFQ___REPETITIONTIME", "NFQ___SOFTWAREVERSIONS", "NFQ___PATIENTSAGE", "NFQ___NFQ", "NFQ___OVERALLQC", "NFQ___SLICE.TIMING", "NFQ___SLICE.ORDER", "NFQ___SLICE.ORDER.TYPE", "NFQ___BAND.TYPE", "IMAGING.PROTOCOL___MODALITY", "IMAGING.PROTOCOL___DESCRIPTION", "IMAGING.PROTOCOL___Field Strength", "IMAGING.PROTOCOL___Manufacturer", "IMAGING.PROTOCOL___Slice Thickness", "IMAGING.PROTOCOL___TE", "IMAGING.PROTOCOL___TR", "IMAGING.PROTOCOL___LONI_STUDY", "IMAGING.PROTOCOL___LONI_SERIES", "IMAGING.PROTOCOL___FMRI_PHASE_DIRECTION", "IMAGING.PROTOCOL___SERIES_DESCRIPTION", "IMAGING.PROTOCOL___SERIES_TYPE", "IMAGING.PROTOCOL___FIELD_STRENGTH", "IMAGING.PROTOCOL___FMRI_MEAN_SNR", "IMAGING.PROTOCOL___T1_ACCELERATED", "IMAGING.PROTOCOL___Acquisition Plane", "IMAGING.PROTOCOL___Matrix Z", "IMAGING.PROTOCOL___Acquisition Type", "IMAGING.PROTOCOL___Mfg Model", "IMAGING.PROTOCOL___Weighting", "QC_VAR_SERIES_QUALITY", "QC_VAR_SERIES_COVERAGE_OCCIPITAL", "QC_VAR_SERIES_COVERAGE_VERMIS", "QC_VAR_SERIES_COVERAGE_CEREBELLUM", "QC_VAR_SERIES_COVERAGE_SUPERIOR", "QC_VAR_SERIES_COVERAGE_TEMPORAL", "QC_VAR_SERIES_COVERAGE_OTHER", "QC_VAR_FMRI_PHASE", "QC_VAR_FMRI_PENCIL", "QC_VAR_FMRI_VENETIAN", "QC_VAR_FMRI_DMN", "QC_VAR_FMRI_MOTION_DISPLAY", "QC_VAR_STUDY_MEDICAL_ABNORMALITIES", "QC_VAR_STUDY_RESCAN_REQUESTED", "QC_VAR_MEDICAL_EXCLUSION", "QC_COMMENTS_SERIES_COMMENTS", "QC_COMMENTS_STUDY_COMMENTS", "QC_COMMENTS_STUDY_PROTOCOL_COMMENT", "QC_COMMENTS_PROTOCOL_COMMENTS")
#
#   names(MT1.df)[which(names(MT1.df) %in% MT1_Cols)] = paste0("MT1___", MT1_Cols)
#   names(EPI.df)[which(names(EPI.df) %in% EPI_Cols)] = paste0("EPI___", EPI_Cols)
#
#   MT1.df = MT1.df %>% rename(IMAGE_ID_MT1 = IMAGE_ID)
#   EPI.df = EPI.df %>% rename(IMAGE_ID_EPI = IMAGE_ID)
#
#
#   return(list(EPI = EPI.df , MT1 = MT1.df))
# }




