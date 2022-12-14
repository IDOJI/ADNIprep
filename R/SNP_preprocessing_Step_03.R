SNP_preprocessing_Step_03 = function(path_SNP){
  ###########################################################
  ### 2.selecting specific subjects
  ###########################################################
  # Exclude subjects with missing response variable(y), RID in keep.txt
  # RID correspond to the 2nd column of the PED file
  # If you are using all the subjects without selecting a subset of them,
  # just ignore this step

  # require(refineR)
  # require(dplyr)
  # path_ADNI = "E:/ADNI" %>% path_tail_slash()
  # path_SNP = paste(path_ADNI, "ADNI_SNP", sep="") %>% path_tail_slash()
  # path = paste(path_SNP, "ADNI_WGS", sep="")

  files = list.files(path_SNP)
  keep = have_this(list.files(path_SNP) %>% unlist, "keep")
  ped = have_this(list.files(path_SNP), this=".ped")
  ped_name = substr(ped, start=1, stop=nchar(ped)-4)

  if(length(keep)==1){
    ped_keep = paste(ped_name, "_keep", sep="")
    # genetic data with extension ".ped" or ".map"
    cmd = paste("plink --file", ped, "--keep", paste(keep,"txt",sep="."), "--recode --out", ped_keep)
    system(cmd)
  }
  text1 = crayon::blue("Selecting RID in")
  text2 = crayon::bgMagenta("keep.txt")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")
}
