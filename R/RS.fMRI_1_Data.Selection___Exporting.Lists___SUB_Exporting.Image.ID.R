RS.fMRI_1_Data.Selection___Exporting.Lists___SUB_Exporting.Image.ID = function(ImageID, filename, path){
  dir.create(path, showWarnings = F)
  ImageID.txt = paste(filename, "txt", sep=".")
  # ImageID.csv = paste("[Final_Selected]_Image_ID_(",list_names,").csv", sep="")
  write.table(ImageID,
              paste(path, ImageID.txt, sep="/"),
              sep="",
              quote = FALSE,
              eol = ",",
              row.names = F,
              col.names = F)

  text1 = crayon::blue("Writing")
  text2 = crayon::red("ImageID.txt")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")
}
