RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Rearranging.Dates = function(NFQ.df){
  NFQ_1.df = NFQ.df %>% dplyr::relocate(contains("DATE"), .after=RID)

  NFQ_1.df$SERIESDATE = lubridate::ymd(NFQ_1.df$SERIESDATE) %>% as.character
  NFQ_1.df$SCANDATE = lubridate::mdy(NFQ_1.df$SCANDATE) %>% as.character


  ### removing dup cols
  NFQ_2.df = rm_dup_cols(NFQ_1.df)

  text = "1.1.3 : Rearraging dates is done."
  cat("\n", crayon::green(text), "\n")
  return(NFQ_2.df)
}
