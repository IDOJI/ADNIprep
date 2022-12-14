RS.fMRI_1.3_Exporting.List___SUB_Exporting.Subjects.List.CSV = function(data.df, path, filename){
  write.csv(x = data.df, file = paste(path, paste(filename, "csv", sep="."), sep="/"), row.names = F)
  text1 = crayon::blue("Writing")
  text2 = crayon::red("Subjects List")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")
}
