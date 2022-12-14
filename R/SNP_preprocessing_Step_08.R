SNP_preprocessing_Step_08 = function(path_SNP, compress_final.raw){
  ###########################################################
  ### 8.compressing final.raw file
  ###########################################################
  if(compress_final.raw){
    files = list.files(path_SNP)

    # final.raw
    final = have_this(list.files(path_SNP), this=c("_final.raw"))[1]
    name_final = substr(final, 1, nchar(final)-4)
    zip(zipfile = name_final, files = final)


    text1 = crayon::blue("Compressing")
    text2 = crayon::bgMagenta("a Raw file")
    text3 = crayon::blue("is done!")
    cat("\n", text1, text2, text3, "\n")
  }
}
