SNP_preprocessing_Step_04 = function(path_SNP){
  ###########################################################
  ### 3.기록된 성별과 유전자 성별이 다른 경우 찾기
  ###########################################################
  # a funny step
  # check if there is any subject with discrepency
  # between the gender they reported
  # and gender inferred by sex chromosome information

  files = list.files(path_SNP)

  ped = have_this(list.files(path_SNP), this=".ped")[1]
  ped_keep = have_this(list.files(path_SNP), this="_keep")

  ped_name = substr(ped, 1, nchar(ped)-4)
  ped_keep_name = substr(ped_keep, 1, nchar(ped)-4)

  if(length(ped_keep)==1){
    cmd = paste("plink --file", ped_keep_name, "--check-sex")
  }else{
    cmd = paste("plink --file", ped_name, "--check-sex")
  }

  system(cmd)

  text1 = crayon::blue("Checking")
  text2 = crayon::bgMagenta("gender discrepancy")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3, "\n")
}
