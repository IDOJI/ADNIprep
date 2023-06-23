RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Rearranging.Dates = function(NFQ.df){
  # NFQ.df = NFQ_2.df
  NFQ_New.df = NFQ.df %>% dplyr::relocate(contains("DATE"), .after=RID)

  NFQ_New.df$SERIESDATE = lubridate::ymd(NFQ_New.df$SERIESDATE) %>% as.character
  # NFQ_1.df$SCANDATE = lubridate::ymd(NFQ_1.df$SCANDATE) %>% as.character


  ### removing dup cols
  NFQ_New_2.df = rm_dup_cols(NFQ_New.df)

  text = "1.1.3 : Rearraging dates is done."
  cat("\n", crayon::green(text), "\n")
  return(NFQ_New_2.df)
}
