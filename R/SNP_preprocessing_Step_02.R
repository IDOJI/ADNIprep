SNP_preprocessing_Step_02 = function(path_SNP){
  # changing 'bed' to 'ped'


  # require(refineR)
  # require(dplyr)
  # path_ADNI = "E:/ADNI" %>% path_tail_slash()
  # path_SNP = paste(path_ADNI, "ADNI_SNP", sep="") %>% path_tail_slash()
  # path = paste(path_SNP, "ADNI_WGS", sep="")
  files = list.files(path_SNP)
  bed_file = have_this(files, this=".bed")
  ped_file = have_this(files, this=".ped")

  if(length(bed_file)==1 && length(ped_file)==0){
    # PLINK를 실행해서
    # bed file을 읽어오고,
    # ped 파일로 내보낸다.
    ped = bed = substr(bed_file, start=1, nchar(bed_file)-4)
    bed_path = paste(path_SNP, bed, sep="/")
    ped_path = paste(path_SNP, ped, sep="/")

    cmd = paste("plink", "--bfile", bed, "--recode --out", ped)
    system(cmd)
  }

  text1 = crayon::blue("Converting to")
  text2 = crayon::bgMagenta("ped")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")

  text1 = crayon::bgMagenta("Step_02")
  text2 = crayon::green("is done")
  cat("\n", text1, text2, "\n")
}
