RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Loading.Data = function(subjects_NFQ, path_Subjects.Lists.Downloaded){
  if(grep("csv", subjects_NFQ) %>% length  == 0){
    subjects_NFQ = paste(subjects_NFQ, ".csv", sep="")
  }


  # Load
  NFQ = read.csv(paste(path_Subjects.Lists.Downloaded, subjects_NFQ, sep=""))
  NFQ$RID = NFQ$RID %>% as.character


  ### renaming
  names(NFQ) = NFQ %>% names %>% toupper


  ### as tibble
  NFQ = dplyr::as_tibble(NFQ)


  ### remove dup rows
  NFQ = unique(NFQ)


  ### change Manufacturer description
  NFQ$MANUFACTURER = gsub(pattern = "_", replacement = ".", NFQ$MANUFACTURER)


  text = "1.1.3 : Loading data is done."
  cat("\n", crayon::green(text), "\n")
  return(NFQ)
}














