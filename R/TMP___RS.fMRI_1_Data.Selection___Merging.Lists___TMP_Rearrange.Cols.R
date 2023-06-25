RS.fMRI_1.2_Merging.Lists___Rearrange.Cols = function(data.list){
  ### load data
  combined = data.list[[1]]
  NFQ = data.list[[2]]


  ### rm duplicated cols
  dup_rm.df = rm_dup_cols(combined)
  dup_rm.df = dup_rm.df %>% dplyr::rename(RID=RIDSearch)


  # ### relocate cols
  # combined_2 = combined_1 %>% dplyr::relocate(starts_with("PHASE"), .after="IMAGE_ID");names(combined_2)
  # combined_3 = combined_2 %>% dplyr::relocate(starts_with("RID"), .after="IMAGE_ID");names(combined_3)
  # combined_4 = combined_3 %>% dplyr::relocate(ends_with("DATE"), .after="PHASE...53");names(combined_4)
  # combined_5 = combined_4 %>% dplyr::relocate(starts_with("FMRI"), .after="T1_ACCELERATED");names(combined_5)
  # combined_6 = combined_5 %>% dplyr::relocate(starts_with("MRI"), .after="T1_ACCELERATED");names(combined_6)
  # combined_7 = combined_6 %>% dplyr::relocate(starts_with("SLICE"), .after= "T1_ACCELERATED");names(combined_7)
  # combined_8 = combined_7 %>% dplyr::relocate(starts_with("SERIES"), .after= "SERIESDATE");names(combined_8)
  # combined_9 = combined_8 %>% dplyr::relocate(starts_with("MANUFACTURER"), .after= "SERIESTIME");names(combined_9)
  # combined_10 = combined_9 %>% dplyr::relocate(starts_with("VISCODE"), .before= "ARCHIVE.DATE");names(combined_10)
  # combined_11 = combined_10 %>% dplyr::relocate(starts_with("VISIT"), .before= "VISCODE2");names(combined_11)
  # combined_12 = combined_11 %>% dplyr::relocate(starts_with("FIELD"), .after= "SLICE.TIMING_ORDER");names(combined_12)
  # combined_13 = combined_12 %>% dplyr::relocate("REPETITIONTIME", .after= "FIELD_STRENGTH");names(combined_13)
  # combined_14 = combined_13 %>% dplyr::relocate(starts_with("MRI_"), .after= last_col());names(combined_14)
  # combined_15 = combined_14 %>% dplyr::relocate(starts_with("FMRI_"), .after= last_col());names(combined_15)
  # combined_16 = combined_15 %>% dplyr::relocate(starts_with("QC_COMMENTS"), .after= last_col());names(combined_16)
  # combined_17 = combined_16 %>% dplyr::relocate(starts_with("QC_VAR"), .after= last_col());names(combined_17)


  return(list(dup_rm.df, NFQ))
}
