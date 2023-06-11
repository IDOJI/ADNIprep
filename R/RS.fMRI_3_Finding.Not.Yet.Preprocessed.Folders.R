RS.fMRI_3_Finding.Not.Yet.Preprocessed.Folders = function(path_Sub_Folders, recursive.folder=NULL, which.file="ROISignals_FunImgARglobalCWSF"){
  # path_Sub_Folders =  "E:/ADNI/ADNI_RS.fMRI___SB/AutoMask___O/MNI_EPI_AAL3___GE.MEDICAL.SYSTEMS"
  # recursive.folder = "Results"
  #=============================================================================
  # path
  #=============================================================================
  path_Folders_Backup = path_Folders = fs::dir_ls(path_Sub_Folders, type="dir") %>% sort
  if(!is.null(recursive.folder)){
   path_Folders = paste(path_Folders, recursive.folder, sep="/")
  }


  #=============================================================================
  # Finding Folders
  #=============================================================================
  path_Folders_that_Dont_Have_which.file = sapply(seq_along(path_Folders), function(i, ...){
    ith_Folder = path_Folders[i]

    if(fs::dir_exists(ith_Folder)){
      if(list.files(ith_Folder, pattern=which.file) %>% length == 0){
        return(path_Folders_Backup[i])
      }
    }else{
      return(path_Folders_Backup[i])
    }
  }) %>% unlist


  if(!is.null(path_Folders_that_Dont_Have_which.file)){
    cat("\n", crayon::red("There are"), crayon::cyan(length(path_Folders_that_Dont_Have_which.file)), crayon::red("unpreprocessed subejcts!") ,"\n")

    Results = sapply(path_Folders_that_Dont_Have_which.file, function(x){
      cat("\n", crayon::yellow(x), "\n")
    })
  }else{
    cat("\n", crayon::blue("Congratulation! There is no unpreprocessed subject!") ,"\n")
  }


}



