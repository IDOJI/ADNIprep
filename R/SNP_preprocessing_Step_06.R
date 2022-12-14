SNP_preprocessing_Step_06 = function(path_SNP){
  ###########################################################
  ### removing snps
  ###########################################################
  # remove snps with missing
  # remove
  # (1) missing proportion 0.05
  # (2) maf < 0.05
  # (3) hwe pvalue < 0.000001

  files = list.files(path_SNP)


  ped = have_this(list.files(path_SNP), this="ped")[1]
  ped_name = substr(ped, 1, nchar(ped)-4)

  pheno = have_this(list.files(path_SNP), this=c("_pheno.ped"))
  pheno_name = substr(pheno, 1, nchar(pheno)-4)

  cmd = paste("plink --file", pheno_name,
              "--geno 0.05 --maf 0.05  --hwe 0.000001",
              "--recode --out",
              paste(ped_name, "rmSNPs", sep="_"))
  system(cmd)

  text1 = crayon::blue("Removing")
  text2 = crayon::bgMagenta("SNPs with missing")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")
}
