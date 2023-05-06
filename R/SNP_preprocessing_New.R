SNP_preprocessing = function(path_SNP   = "E:/ADNI/ADNI_SNP/ADNI2",
                             path_PLINK = "E:/ADNI/ADNI_SNP/PLINK",
                             path_keep  = NULL,
                             compress_final.raw = F){

  ### package
  # require(dplyr)
  # require(refineR)

  ### 0) path
  # path_SNP = path_SNP_folders[i]
  path_SNP = path_tail_slash(path_SNP)
  path_PLINK = path_tail_slash(path_PLINK)
  setwd(path_SNP)

  ### preprocessing
  SNP_files = list.files(paste(path_SNP), recursive = T)
  SNP_raw = have_this(SNP_files, this="\\.raw")

  if(length(SNP_raw)==0){
    ### 1) Copying PLINK & keep
    SNP_preprocessing_Step_01(path_SNP, path_PLINK, path_keep)

    ### 2) bed -> ped for each folder
    SNP_preprocessing_Step_02(path_SNP)

    ### 3) keep RID
    SNP_preprocessing_Step_03(path_SNP)
    text1 = crayon::bgMagenta("Step_03")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")

    ### 4) gender discrepancy
    SNP_preprocessing_Step_04(path_SNP)
    text1 = crayon::bgMagenta("Step_04")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")

    ### 5) Removing low-genotyped
    SNP_preprocessing_Step_05(path_SNP)
    text1 = crayon::bgMagenta("Step_05")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")

    ### 6) Removing SNPs with missing
    SNP_preprocessing_Step_06(path_SNP)
    text1 = crayon::bgMagenta("Step_06")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")

    ### 7) Converting to raw
    SNP_preprocessing_Step_07(path_SNP)
    text1 = crayon::bgMagenta("Step_07")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")

    ### 8) compressing as zip
    SNP_preprocessing_Step_08(path_SNP, compress_final.raw)
    text1 = crayon::bgMagenta("Step_08")
    text2 = crayon::green("is done")
    cat("\n", text1, text2,"\n")
  }else{
    text1 = crayon::green("There already exists ")
    text2 = crayon::bgMagenta("a raw file.")
    cat("\n", text1, "\n", text2, "\n")
  }

  cat("\n", crayon::blue("Preprocessing SNP data is done !"), "\n")
}
