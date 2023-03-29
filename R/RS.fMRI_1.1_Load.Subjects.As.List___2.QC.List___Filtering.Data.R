RS.fMRI_1.1_Load.Subjects.As.List___2.QC.List___Filtering.Data = function(QC.df){
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
  ### extracting
  comments.df = relocated.df
  only_comments_col.df = comments.df %>% select(contains("comments"))
  no_comments_col.df = comments.df %>% select(!contains("comments"))


  ### trimming comments
  trimmed_comments_col.df = apply(only_comments_col.df, MARGIN=2, FUN=function(y){
    stringr::str_trim(y %>% as.vector) %>% suppressWarnings()
  })


  ### containing keywords
  exclusion_words = c(# the other imaging methods
                      "B0FM still need QC",

                      # tissues
                      "CSF suppression not very good",
                      "CSF suppression issue",

                      # SNR
                      "Low SNR",
                      "SNR and flow artifacts noted.",
                      "SNR and motion artifacts noted. ",
                      "grainy/low SNR",
                      "low snr",
                      "poor SNR",
                      "Poor SNR",

                      # motion
                      "some motion noted around mouth and nose area",
                      "Motion noted in the mouth and nose area",
                      "some motion noted",
                      "moderate motion noted",
                      "motion;",

                      # wrap
                      "wrap noted",
                      "wrap",
                      "bright artifact noted",
                      "Possible AVM noted",
                      "patient motion",
                      "metal artifact",


                      "Distortion Correction Issue",
                      "coverage;",
                      "dmn,motion;",
                      "dmn,venetian;",
                      "venetian;",
                      ";Appears to be flipped in FSL",
                      "dmn,venetian,motion;",
                      ";failed protocol",
                      "dmn,coverage;",
                      "motion;Wrapping noted",
                      "venetian,motion;",
                      ";Wrap noted",
                      ";Unexpected inhomogeneity",
                      ";Images Flipped in Viewer",
                      "motion;low SNR",
                      "snr;",
                      "motion,snr;",
                      "motion;Low SNR",
                      "inhomogeneity;",
                      "inhomogeneity;Unexpected left/right inhomogeneity",
                      "susceptibility;",
                      ";Slight left/right inhomogeneity",
                      ";very slight unexpected left/right inhomogeneity",
                      "inhomogeneity;Unusual signal drop-off near center center of the image",
                      "motion,wrap;",
                      "motion,inhomogeneity;very slight frontal left/right inhomogeneity",
                      "IMAGES COMPROMISED DUE TO PATIENT MOTION",
                      "1.5T scanner no longer available.  ",
                      "Subject moved from 1.5T to 3T (Scanner no longer available)",
                      "Not sure this is the same subject.",
                      "All scans contain mild to moderate motion.  ",
                      "Motion noted. Subject was unable to complete the scan.  ",
                      "All scans contain motion. ",
                      "Subject moved to 3T",
                      "Subject has moved to 3T",
                      "fMRI is 20mins long.  Site has changed TR",
                      "All scans show moderate to severe motion",
                      "pencil;",
                      "motion noted on all scans except MPRAGE scans",
                      "Rescan",
                      "possible micro-hemorrhage in caudate noted by Dr. Jack",
                      "B0FM still needs QC",
                      "checkerboard artifact noted. ",
                      "fMRI scan did not come up.",
                      "Motion noted on all scans",
                      "All scans contain mild motion. ",
                      "All scans show moderate motion",
                      "All scans show mild motion.",
                      "All scans seem grainy.  Low SNR?  Site contacted.  ",
                      "SNR Seems low on all scans",
                      "All scans show mild motion. ",
                      "dmn,pencil;",
                      "CSF Supression problems on IR-SPGR scans, high intensity area on GRE",
                      "All scans contain motion.  ",
                      "All scans show motion",
                      "Nearly all scans show severe motion",
                      "All scans show moderate to severe motion.",
                      "Motion noted in all scans",
                      "All scans show moderate motion.",
                      "MPRAGE Shows moderate to severe motion",
                      "ASL and Hippo Scans do not cover anatomy.  ",
                      "waiting for missing slice",
                      "Slices Reduced",
                      "All scans seem low in SNR",
                      "Missing fMRI",
                      "No masks available",
                      "Motion noted on all scans.",
                      "Distortion Correction Issues",
                      "WMH Noted.",
                      "Motion noted on all sequences.",
                      "mild motion noted",
                      "Site did not have distortion correction for many scans.",
                      "Slight motion noted on all scans.",
                      "Metal artifact noted.",
                      "Slight motion noted.",
                      "Truncated protocol",
                      "Poor FOV placement on the T1, FOV cuts off a bit of occipital lobe, consider when using for analysis.",
                      "QC'd - Motion noted on most scans.",
                      "QC'd - fMRI PE Incorrect",
                      "Motion noted on most scans.",
                      "flipped PE",
                      "Swapped PE",
                      "Incorrect PE",
                      "QC'd - \tSite reduced slices on several series.",
                      "Motion noted on all series.",
                      "QC'd - Motion noted on all series.",
                      "Missing vols?",
                      "QC'd - Distortion Correct Issues",
                      "QC'd - Motion noted on all sequences.",
                      "QC'd - All scans contain motion.",
                      "QC'd - Subject has a metal artifact causing distortion of the face.",
                      "QC'd - \tSite did not have distortion correction for many scans. Contacted and site was very upset.",
                      ###########################################################
                      # # ????
                      # "Truncated protocol.",
                      # "QC'd - Truncated protocol.",
                      # "QC'd Truncated protocol.",
                      # "QC'd - Truncated protocol",
                      # "QC'd - Truncated Protocol",
                      ##########################################################
                      "Swapped PE, Site reduced slices.",
                      "PE Swapped",
                      "swapped PE",
                      "QC'd - All scans obliqued. Swapped PE on DTI/fMRI",
                      "QC'd - No ASL License. Swapped PE on DTI/fMRI",
                      "QC'd - Swapped PE on DTI and fMRI",
                      "QC'd - fMRI/DTI PE Swapped",
                      "QC'd - Non ADNI ASL, DTI and fMRI Swapped PE",
                      "QC'd - Site changed FOVs for several scans.",
                      "QC'd - Distortion correct shows up as off. Site has said that is not the case.",
                      "QC'd - Axial 2D PASL not processed by Mayo",
                      "Problem fields: phase_encoding_direction",
                      "No distortion correction.",
                      "Incorrect slice thickness",
                      "removed some slices",
                      "Distortion Correct Issue",
                      "PE = AP",
                      "Slices reduced.",
                      "Problem fields: obliquity_min",
                      "Distortion Correction",
                      "swapped PE - other changes noted, perhaps to cover head?",
                      "swapped pe",
                      "Site reduced number of slices.",
                      "incorrect FOV",
                      "Maybe missing vols.",
                      "Significant WMH noted."





                      ) %>% stringr::str_trim()
  ### Exclude
  which_to_exclude = apply(trimmed_comments_col.df, MARGIN = 2, FUN = function(y, ...){
    y %in% exclusion_words
  })
  exclude_rows = rowSums(which_to_exclude)>0

  After_Exclusion_Comments.df = trimmed_comments_col.df[!exclude_rows,]
  After_Exclusion_NonComments.df = no_comments_col.df[!exclude_rows, ]


  ### combine
  Combined.df = cbind(After_Exclusion_NonComments.df, After_Exclusion_Comments.df)


  return(Combined.df)
}








