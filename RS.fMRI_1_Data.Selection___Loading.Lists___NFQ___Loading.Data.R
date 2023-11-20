RS.fMRI_1_Data.Selection___Loading.Lists___NFQ___Loading.Data = function(Subjects_NFQ, path_Subjects.Lists_Downloaded){
  if(grep("csv", Subjects_NFQ) %>% length  == 0){
    Subjects_NFQ = paste(Subjects_NFQ, ".csv", sep="")
  }


  # Load
  NFQ = read.csv(paste(path_Subjects.Lists_Downloaded, Subjects_NFQ, sep=""))
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














