RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Dir.Create.By.Manu.Name = function(manu_path, suffix){
  split_path = strsplit(manu_path, split = "/")[[1]]
  manu_name = split_path[length(split_path)]
  path_destination = paste0(manu_path, paste0(manu_name, "_", suffix))
  dir.create(path_destination, showWarnings = F)

  text1 = crayon::bgRed(paste0(manu_name, "_", suffix))
  text2 = crayon::yellow("is created for moving files !")
  cat("\n", text1, text2,"\n")

  return(path_destination)
}
