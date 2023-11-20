RS.fMRI_1_Data.Selection___Loading.Lists___NFQ = function(Selected_RID, Subjects_NFQ, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # 1.데이터 로드
  #=============================================================================
  NFQ_1.df = RS.fMRI_1_Data.Selection___Loading.Lists___NFQ___Loading.Data(Subjects_NFQ, path_Subjects.Lists_Downloaded)



  #=============================================================================
  # 2.Data selection & rename
  #=============================================================================
  NFQ_2.df = RS.fMRI_1_Data.Selection___Loading.Lists___NFQ___Select.Rename.Data(NFQ_1.df)



  #=============================================================================
  # 3.Rearrange dates
  #=============================================================================
  NFQ_3.df = RS.fMRI_1_Data.Selection___Loading.Lists___NFQ___Rearranging.Dates(NFQ_2.df)



  #=============================================================================
  # 4.Extract Slice timing info
  #=============================================================================
  NFQ_4.df = RS.fMRI_1_Data.Selection___Loading.Lists___NFQ___Slice.Timing(NFQ_3.df)



  #=============================================================================
  # 5.Bandtype
  #=============================================================================
  NFQ_4.df$BAND.TYPE = ifelse(NFQ_4.df$REPETITIONTIME > 2000, "SB", "MB")



  #=============================================================================
  # 5.renaming cols
  #=============================================================================
  NFQ_5.df = NFQ_4.df
  names(NFQ_5.df) = names(NFQ_5.df) %>% toupper
  # names(NFQ_5.df) = paste0("NFQ___", names(NFQ_5.df))
  # print_colnames(NFQ_5.df)
  selected_cols = c("SERIESTIME", "MANUFACTURER", "MANUFACTURERSMODELNAME", "REPETITIONTIME", "SOFTWAREVERSIONS", "PATIENTSAGE", "NFQ", "OVERALLQC", "SLICE.TIMING", "SLICE.ORDER", "SLICE.ORDER.TYPE", "BAND.TYPE")
  names(NFQ_5.df)[which(names(NFQ_5.df) %in% selected_cols)] = paste0("NFQ___", selected_cols)





  #=============================================================================
  # 6.arrange
  #=============================================================================
  NFQ_6.df = NFQ_5.df
  NFQ_6.df$RID = NFQ_6.df$RID %>% as.numeric
  NFQ_6.df = NFQ_6.df %>% arrange(RID, SCANDATE)



  #=============================================================================
  # 7.RID
  #=============================================================================
  NFQ_7.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, NFQ_6.df)


  #=============================================================================
  # 5.Saving results
  #=============================================================================
  ADNI_Subjects_NFQ =  NFQ_7.list
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

