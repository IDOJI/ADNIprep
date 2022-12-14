SNP_preprocessing_Step_07 = function(path_SNP){
  ###########################################################
  ### 7.converting to raw
  ###########################################################
  # recode the data in raw data
  # under additive assumption
  files = list.files(path_SNP)

  # .ped
  ped = have_this(list.files(path_SNP), this="ped")[1]
  ped_name = substr(ped, 1, nchar(ped)-4)

  # rmSNPs.ped
  rmSNPs = have_this(list.files(path_SNP), this=c("rmSNPs.ped"))
  rmSNPs_name = substr(rmSNPs, 1, nchar(rmSNPs)-4)

  # writing final.raw
  cmd = paste("plink --file", rmSNPs_name, "--recodeA --out", paste(ped_name, "final", sep="_"))
  system(cmd)

  text1 = crayon::blue("Converting to")
  text2 = crayon::bgMagenta("a Raw file")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")
}
