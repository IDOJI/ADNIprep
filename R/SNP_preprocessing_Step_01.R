SNP_preprocessing_Step_01 = function(path_SNP, path_PLINK, path_keep=NULL){
  # copy PLINK

  # path_ADNI = "E:/ADNI" %>% path_tail_slash()
  ### PLINK folder
  # folder = have_this(list.files(path_PLINK), this="PLINK", exact = T, except = F)
  # if(length(folder)==0){
  #   stop("There is no PLINK folder!")
  # }
  # path_PLINK = paste(path_SNP, folder, sep="") %>% path_tail_slash()
  PLINK_files = list.files(path_PLINK, include.dirs = T, full.names = T)

  ### copy PLINK
  for(j in 1:length(PLINK_files)){
    file.copy(from = PLINK_files[j], to = path_SNP, overwrite = T)
  }
  text1 = crayon::green("Copying")
  text2 = crayon::bgMagenta("PLINK files")
  text3 = crayon::green("to")
  text4 = crayon::bgGreen(paste(basename(path_SNP), "folder"))
  text5 = crayon::green("is done!")
  cat("\n",text1, text2, text3, text4, text5, "\n")

  ### copy keep.txt
  if(!is.null(path_keep)){
    keep_files = list.files(path_keep, include.dirs = T, full.names=T)
    file.copy(from = keep_files, to = path_SNP, overwrite = T)
    text1 = crayon::green("Copying")
    text2 = crayon::bgMagenta("keep.txt files")
    text3 = crayon::green("to")
    text4 = crayon::bgGreen(paste(basename(path_SNP), "folder"))
    text5 = crayon::green("is done!")
    cat("\n",text1, text2, text3, text4, text5, "\n")
  }

  text1 = crayon::bgMagenta("Step_01")
  text2 = crayon::green("is done")
  cat("\n", text1, text2, "\n")
}
