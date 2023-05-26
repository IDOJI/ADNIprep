RS.fMRI_3.7_Compressing.and.Removing.Raw.Folders___Having.Raw.Folders = function(ith_path, ith_folder_name, ith_FunRaw_path, ith_MT1Raw_path, hide.zip.file){
  #===========================================================================
  # Define the destination folder & file name
  #===========================================================================
  # Define the destination folder and the name of the compressed file
  ith_compressed_file_path = file.path(ith_path, paste0(ith_folder_name, ".zip"))



  #===========================================================================
  # Compressing folders
  #===========================================================================
  tictoc::tic()
  zip::zip(zipfile = ith_compressed_file_path, files = c(ith_FunRaw_path, ith_MT1Raw_path), include_directories = F, recurse = T, mode = "cherry-pick")
  cat("\n", crayon::green("Compressing Raw folders is done :"), crayon::red(ith_folder_name), "\n")
  tictoc::toc()



  #===========================================================================
  # Removing Raw folders
  #===========================================================================
  tictoc::tic()
  unlink(ith_FunRaw_path, recursive = T) %>% invisible()
  unlink(ith_MT1Raw_path, recursive = T) %>% invisible()
  cat("\n", crayon::green("Removing Raw folders is done :"), crayon::red(y), "\n")
  tictoc::toc()


  #===========================================================================
  # Hide zip file
  #===========================================================================
  if(hide.zip.file){
    paste("attrib +h", shQuote(ith_compressed_file_path)) %>% system() %>% invisible()
  }
}
