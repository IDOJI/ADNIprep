RS.fMRI_1.1_Load.Subjects.As.List___QC.List___Selecting.Cols = function(QC.list, ...){
  QC.list[[1]] = QC.list[[1]] %>% rename(IMAGE_ID=LONI_IMAGE)
  QC.list[[2]] = QC.list[[2]] %>% rename(IMAGE_ID=LONI_IMAGE)


  #============================================================================
  # ADNI2GO
  #============================================================================
  selected_colnames_1.list = list(NULL, NULL, NULL, NULL)
  names(selected_colnames_1.list) = c("Subjects.info", "Scan.info", "QC.info", "Comments")

  selected_colnames_1.list[[1]] = "RID"
  selected_colnames_1.list[[2]] = c("IMAGE_ID",

                                    # ADNI LONI Series ID
                                    "LONI_STUDY",

                                    # ADNI LONI Study ID
                                    "LONI_SERIES",

                                    # yyyymmdd
                                    "SERIES_DATE",

                                    # # Slice acqusition order, comma separated integers, used for slice timing correction
                                    # "FMRI_TEMPORAL_SLICE_ORDER",

                                    # AP, PA, No Eval
                                    "FMRI_PHASE_DIRECTION",

                                    "SERIES_DESCRIPTION",
                                    "SERIES_TYPE",
                                    "FIELD_STRENGTH")
  selected_colnames_1.list[[3]] = c(
                                    # Mean of temporal SNR values in brain
                                    "FMRI_MEAN_SNR",

                                    # <blank> Not evaluated, (1) Excellent, (2) Good, (3) Fair, (4) Unusable
                                    "SERIES_QUALITY",

                                    # blank or Not applicable (-1), Non Accelerated (0) Accelerated (1)
                                    # The scan acceleration permits higher spatial resolution,
                                    # increased temporal resolution, shorter scan duration, or a combination of these benefits.
                                    # Along with the exciting developments is a dizzying proliferation of acronyms and variations of the techniques.
                                    "T1_ACCELERATED",


                                    # <blank> Not evaluated, (0) Not selected, (1) Selected
                                    "SERIES_SELECTED",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_OCCIPITAL",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_VERMIS",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_CEREBELLUM",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_SUPERIOR",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_TEMPORAL",
                                    # <blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
                                    "SERIES_COVERAGE_OTHER",


                                    # <blank> Not relevant, (0) Not present, (1) Present
                                    "FMRI_PHASE",
                                    # <blank> Not relevant, (0) Not present, (1) Present
                                    "FMRI_PENCIL",
                                    # <blank> Not relevant, (0) Not present, (1) Present
                                    "FMRI_VENETIAN",
                                    # <blank> Not relevant, (0) Not present, (1) Present
                                    "FMRI_DMN",
                                    # <blank> Not relevant, (0) Not present, (1) Present
                                    "FMRI_MOTION_DISPLAY",


                                    # (0) Not present, (1) Present, (-1) Not evaluated
                                    "STUDY_MEDICAL_ABNORMALITIES",

                                    # (-1) Not evaluated, (0) Fail, (1) Pass
                                    "STUDY_OVERALLPASS")
  selected_colnames_1.list[[4]] = c("SERIES_COMMENTS", "STUDY_COMMENTS")
  QC_1_selected.df = QC.list[[1]][,unlist(selected_colnames_1.list)]






  #============================================================================
  # ADNI3
  #============================================================================
  selected_colnames_2.list = list(NULL, NULL, NULL, NULL)
  names(selected_colnames_2.list) = c("Subjects.info", "Scan.info", "QC.info", "Comments")

  selected_colnames_2.list[[1]] = "RID"
  selected_colnames_2.list[[2]] = c("IMAGE_ID",

                                    # ADNI LONI Study ID
                                    "LONI_STUDY",

                                    # ADNI LONI Series ID
                                    "LONI_SERIES",

                                    # yyyymmdd
                                    # Series Scan Date
                                    "SERIES_DATE",

                                    "FIELD_STRENGTH",
                                    "SERIES_DESCRIPTION",
                                    "SERIES_TYPE")
  selected_colnames_2.list[[3]] = c(
                                    # TRUE / FALSE
                                    "STUDY_RESCAN_REQUESTED",

                                    # Study Overall Quality Assessment
                                    # (-1) Not evaluated, (0) Fail, (1) Pass
                                    "STUDY_OVERALLPASS",

                                    # <blank> Not evaluated, (1) Excellent, (2) Good, (3) Fair, (4) Unusable
                                    "SERIES_QUALITY",

                                    # <blank> Not evaluated, (0) Not selected, (1) Selected
                                    "SERIES_SELECTED",


                                    # (0) Not present, (1) Present, (-1) Not evaluated
                                    "STUDY_MEDICAL_ABNORMALITIES",

                                    # (0) Not present, (1) Present, (NA) Not evaluated
                                    "MEDICAL_EXCLUSION",

                                    # blank or Not applicable (-1), Non Accelerated (0) Accelerated (1)
                                    "T1_ACCELERATED")
  selected_colnames_2.list[[4]] = c("STUDY_COMMENTS",
                                    "STUDY_PROTOCOL_COMMENT",
                                    "SERIES_COMMENTS",
                                    "PROTOCOL_COMMENTS")
  QC_2_selected.df = QC.list[[2]][,unlist(selected_colnames_2.list)]

  # names(QC_2_selected.df)%in%names(QC_1_selected.df)
  # names(QC_1_selected.df)%in%names(QC_2_selected.df)

  return(list(QC_1_selected.df, QC_2_selected.df))

}
