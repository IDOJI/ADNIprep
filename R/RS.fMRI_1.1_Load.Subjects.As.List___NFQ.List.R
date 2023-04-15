RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List = function(subjects_NFQ, path_Subjects.Lists.Downloaded){
  #=============================================================================
  # 1.데이터 로드
  #=============================================================================
  NFQ_1.df = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Loading.Data(subjects_NFQ, path_Subjects.Lists.Downloaded)



  #=============================================================================
  # 2.Data selection & rename
  #=============================================================================
  NFQ_2.df = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Select.Rename.Data(NFQ_1.df)



  #=============================================================================
  # 3.Rearrange dates
  #=============================================================================
  NFQ_3.df = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Rearranging.Dates(NFQ_2.df)



  #=============================================================================
  # 4.Extract Slice timing info
  #=============================================================================
  NFQ_4.df = RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Slice.Timing(NFQ_3.df)


  #=============================================================================
  # 5.renaming
  #=============================================================================
  NFQ_5.df = NFQ_4.df
  names(NFQ_5.df) = names(NFQ_5.df) %>% toupper




  #=============================================================================
  # 6.arrange
  #=============================================================================
  NFQ_6.df = NFQ_5.df
  NFQ_6.df$RID = NFQ_6.df$RID %>% as.numeric
  NFQ_6.df = NFQ_6.df %>% arrange(RID, SCANDATE)
  NFQ_6.df$RID = NFQ_6.df$RID %>% as.character




  #=============================================================================
  # 5.Saving results
  #=============================================================================
  ADNI_Subjects_NFQ =  NFQ_6.df
  # if(is.null(path_Rda)){
  #   setwd(path_Rda)
  #   usethis::use_data(ADNI_Subjects_NFQ, overwrite=T)
  # }
  # text = "1.1.1 : Saving rda is done."
  # cat("\n", crayon::green(text), "\n")


  text = paste("\n","Step 1.1.3 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_NFQ)
}

