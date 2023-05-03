RS.fMRI_3.5_Checking.Pipeline.Folders = function(path_Preprocessing.Completed, DPABI.Template="Original_EPI"){
  #=============================================================================
  # folders
  #=============================================================================
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)



  #=============================================================================
  # Generated Folders for each DPABI template
  #=============================================================================
  Template_Original_EPI = c("FunImg", "FunImgA", "FunImgAR", "FunImgARC", "FunImgARCF", "FunImgARCovs",
                            "T1Img", "T1ImgBet", "T1ImgCoreg", "T1ImgSegment",
                            "Masks", "PicturesForChkNormalization", "QC", "RealignParameter", "ReorientMats",
                            "Results", "ResultsW", "ResultsWS",
                            "TRInfo.tsv", "SliceOrderInfo.tsv")





  #=============================================================================
  # Check files for each Subject
  #=============================================================================
  files_not_in_Template_files = lapply(folders_path, FUN=function(ith_path, ...){
    # ith_path = folders_path[627]
    if(DPABI.Template=="Original_EPI"){
      ith_files = list.files(ith_path, pattern = DPABI.Template, full.names = T) %>% list.files

      if(grep("DPARSFA_AutoSave", ith_files) %>% length > 0){
        ith_files = ith_files[-grep("DPARSFA_AutoSave", ith_files)]
      }

      ith_selected_files = ith_files[! ith_files %in% Template_Original_EPI]

      if(length(ith_selected_files) > 0){
        return(ith_selected_files)
      }
    }
  })

  names(files_not_in_Template_files) = folders_path
  files_not_in_Template_files = rm_list_null(files_not_in_Template_files)
  if(length(files_not_in_Template_files)>0){
    return(files_not_in_Template_files)
  }else{
    cat("\n",crayon::green("There were no abnormal folders!"),"\n")
  }

}
