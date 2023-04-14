RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Select.Rename.Data = function(NFQ.df){
  # NFQ.df = NFQ_1.df
  ### selection
  df1 = NFQ.df %>% dplyr::select(-starts_with(c("WADDMN", "WVDMN", "WPDMN", "WAVDMN")))
  df2 = df1 %>% dplyr::select(-c("SERIESNUMBER", "ECHOTIME", "UPDATE_STAMP"))

  ### rename
  df3 = df2 %>% dplyr::rename("PHASE":="COLPROT")

  ### NFQ overall QC가 4인 것 제외 : 1=excellent; 2=good; 3=fair; 4=fail
  df4 = df3 %>% dplyr::filter(OVERALLQC!=4)

  ### QC_VAR_OVERALLQC
  df5 = df4 %>% dplyr::rename(QC_VAR_OVERALLQC=OVERALLQC)


  text = "1.1.3 : Selecting & Renaming Data is done."
  cat("\n", crayon::green(text), "\n")

  return(df4)
}
