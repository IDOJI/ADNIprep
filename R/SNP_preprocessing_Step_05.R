SNP_preprocessing_Step_05 = function(path_SNP){
  ###########################################################
  ### 4.Removing low-genotyped individuals
  ###########################################################
  # remove individuals low genotyped,
  # remove subject with missing proportion of genotype > 0.1
  files = list.files(path_SNP)

  ped = have_this(list.files(path_SNP), this=".ped")[1]
  ped_keep = have_this(list.files(path_SNP), this="_keep")

  ped_name = substr(ped, 1, nchar(ped)-4)
  ped_keep_name = substr(ped_keep, 1, nchar(ped)-4)

  if(length(ped_keep)==1){
    cmd = paste("plink --file", ped_keep_name, "--mind 0.1 --recode --out", paste(ped_name, "pheno", sep="_"))
  }else{
    cmd = paste("plink --file", ped_name, "--mind 0.1 --recode --out", paste(ped_name, "pheno", sep="_"))
  }

  system(cmd)

  text1 = crayon::blue("Removing")
  text2 = crayon::bgMagenta("low phenotype individuals")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")
}
