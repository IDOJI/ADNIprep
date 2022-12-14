RS.fMRI_1.1_Load.Subjects.As.List___2.QC.List___Filtering.Data = function(QC.df,...){

  #===========================================================================
  # filter each dataset by "Description" : Excluding "Mocoseries"
  #===========================================================================
  selected_QC.df = QC.df %>% filter(SERIES_DESCRIPTION!="ANONYMIZED" & SERIES_DESCRIPTION!="MoCoSeries");dim(selected_QC.df)


  #===========================================================================
  # Removing NA in RID
  #===========================================================================
  selected_QC.df = selected_QC.df %>% filter(!is.na(RID));dim(selected_QC.df)



  #===========================================================================
  # Removing Bad data
  #===========================================================================
  # <blank> Not evaluated, (1) Excellent, (2) Good, (3) Fair, (4) Unusable
  selected_good_QC_1.df = selected_QC.df %>% filter(SERIES_QUALITY!=4);dim(selected_good_QC_1.df)

  # <blank> Not evaluated, (0) Not selected, (1) Selected)
  selected_good_QC_2.df = selected_good_QC_1.df %>% filter(SERIES_SELECTED==1);dim(selected_good_QC_2.df)
  selected_good_QC_2.df$SERIES_SELECTED = NULL

  #<blank> Not evaluated, (0) No coverage issue, (1) Coverage issue
  selected_good_QC_3.df = selected_good_QC_2.df %>% filter(SERIES_COVERAGE_OCCIPITAL %>% is.na | SERIES_COVERAGE_OCCIPITAL==0);dim(selected_good_QC_3.df)
  selected_good_QC_4.df = selected_good_QC_3.df %>% filter(SERIES_COVERAGE_VERMIS %>% is.na | SERIES_COVERAGE_VERMIS==0);dim(selected_good_QC_4.df)
  selected_good_QC_5.df = selected_good_QC_4.df %>% filter(SERIES_COVERAGE_CEREBELLUM %>% is.na | SERIES_COVERAGE_CEREBELLUM==0) ;dim(selected_good_QC_5.df)
  selected_good_QC_6.df = selected_good_QC_5.df %>% filter(SERIES_COVERAGE_SUPERIOR %>% is.na | SERIES_COVERAGE_SUPERIOR==0) ;dim(selected_good_QC_6.df)
  selected_good_QC_7.df = selected_good_QC_6.df %>% filter(SERIES_COVERAGE_TEMPORAL %>% is.na | SERIES_COVERAGE_TEMPORAL==0) ;dim(selected_good_QC_7.df)
  selected_good_QC_8.df = selected_good_QC_7.df %>% filter(SERIES_COVERAGE_OTHER %>% is.na | SERIES_COVERAGE_OTHER==0)  ;dim(selected_good_QC_8.df)


  selected_good_QC_9.df = selected_good_QC_8.df

  # <blank> Not relevant, (0) Not present, (1) Present
  selected_good_QC_10.df = selected_good_QC_9.df %>% filter(FMRI_PHASE %>% is.na | FMRI_PHASE==0);dim(selected_good_QC_10.df)
  selected_good_QC_11.df = selected_good_QC_10.df %>% filter(FMRI_PENCIL %>% is.na | FMRI_PENCIL==0);dim(selected_good_QC_11.df)
  selected_good_QC_12.df = selected_good_QC_11.df %>% filter(FMRI_VENETIAN %>% is.na | FMRI_VENETIAN==0);dim(selected_good_QC_12.df)
  selected_good_QC_13.df = selected_good_QC_12.df %>% filter(FMRI_DMN %>% is.na | FMRI_DMN==0);dim(selected_good_QC_13.df)
  selected_good_QC_14.df = selected_good_QC_13.df %>% filter(FMRI_MOTION_DISPLAY %>% is.na | FMRI_MOTION_DISPLAY==0);dim(selected_good_QC_14.df)
  selected_good_QC_15.df = selected_good_QC_14.df %>% filter(STUDY_MEDICAL_ABNORMALITIES %>% is.na | STUDY_MEDICAL_ABNORMALITIES==0);dim(selected_good_QC_15.df)
  selected_good_QC_16.df = selected_good_QC_15.df %>% filter(MEDICAL_EXCLUSION %>% is.na | MEDICAL_EXCLUSION==0);dim(selected_good_QC_16.df)

  # (-1) Not evaluated, (0) Fail, (1) Pass
  selected_good_QC_17.df = selected_good_QC_16.df %>% filter(STUDY_OVERALLPASS==1);dim(selected_good_QC_17.df)
  selected_good_QC_17.df$STUDY_OVERALLPASS = NULL


  # STUDY_RESCAN_REQUESTED : TRUE / FALSE / NA
  selected_good_QC_17_with_index.df = cbind(index=1:nrow(selected_good_QC_17.df), selected_good_QC_17.df)
  TRUE_ind = list()
  for(i in 1:nrow(selected_good_QC_17_with_index.df)){
    if(isTRUE(selected_good_QC_17_with_index.df$STUDY_RESCAN_REQUESTED[i])){
      TRUE_ind[i] = selected_good_QC_17_with_index.df$index[i]
    }
  }
  selected_good_QC_18.df = selected_good_QC_17.df[-unlist(TRUE_ind),];dim(selected_good_QC_18.df)



  ### QC Var ======================================================================
  QC_var = c("SERIES_QUALITY",
             "SERIES_COVERAGE_OCCIPITAL",
             "SERIES_COVERAGE_VERMIS",
             "SERIES_COVERAGE_CEREBELLUM",
             "SERIES_COVERAGE_SUPERIOR",
             "SERIES_COVERAGE_TEMPORAL",
             "SERIES_COVERAGE_OTHER",
             "FMRI_PHASE",
             "FMRI_PENCIL",
             "FMRI_VENETIAN",
             "FMRI_DMN",
             "FMRI_MOTION_DISPLAY",
             "STUDY_MEDICAL_ABNORMALITIES",
             "MEDICAL_EXCLUSION",
             "STUDY_RESCAN_REQUESTED")
  QC_named_var = paste0("QC_VAR_", QC_var)

  renamed.df = selected_good_QC_18.df
  for(i in 1:length(QC_var)){
    # i=1
    renamed.df = renamed.df %>% dplyr::rename(!!QC_named_var[i]:= !!QC_var[i])
  }




  ### QC comments ======================================================================
  QC_comments_var = which_col(renamed.df, "COMMENT", ignore.case = F, as.col.names = T)
  QC_renamed_comments_var = paste0("QC_COMMENTS_", QC_comments_var)
  for(i in 1:length(QC_comments_var)){
    # i=1
    renamed.df = renamed.df %>% dplyr::rename(!!QC_renamed_comments_var[i] := !!QC_comments_var[i])
  }



  ### relocating =======================================================================
  renamed.df = dplyr::as_tibble(renamed.df)
  relocated.df = renamed.df %>% dplyr::relocate(contains("COMMENT"), .after=last_col())
  relocated.df = relocated.df %>% dplyr::relocate(starts_with("QC_VAR_"), .after=last_col())



  #===========================================================================
  # Removing Bad data : comments
  #===========================================================================
  comments.df = relocated.df

  ### protocol comments
  comments_1.df = comments.df
  comments_1.df$QC_COMMENTS_PROTOCOL_COMMENTS %>% table


  ### series comments
  comments_2.df = comments_1.df
  comments_2.df$QC_COMMENTS_SERIES_COMMENTS %>% table
  which_motion = grep("motion", comments_2.df$QC_COMMENTS_SERIES_COMMENTS, ignore.case = T)
  comments_2.df = comments_2.df[-which_motion ,]


  ### Study comments
  comments_3.df = comments_2.df
  comments_3.df$QC_COMMENTS_STUDY_COMMENTS %>% table
  which_motion = grep("motion", comments_3.df$QC_COMMENTS_STUDY_COMMENTS, ignore.case=T)
  comments_3.df = comments_3.df[-which_motion,]


  ### study protocol comments
  comments_4.df = comments_3.df
  comments_4.df$QC_COMMENTS_STUDY_PROTOCOL_COMMENT %>% table
  which_motion = grep("motion", comments_4.df$QC_COMMENTS_STUDY_PROTOCOL_COMMENT, ignore.case=T)
  comments_4.df = comments_4.df[-which_motion,]


  return(comments_4.df)
}






