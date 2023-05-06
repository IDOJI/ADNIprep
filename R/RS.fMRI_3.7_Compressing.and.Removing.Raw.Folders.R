RS.fMRI_3.7_Compressing.and.Removing.Raw.Folders = function(path_Preprocessing.Completed,
                                                            hide.zip.file = T){
  # ith_path = "C:/Users/lleii/Desktop/Test"
  # which.Folders = c("FunImg")
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)


  sapply(folders, FUN=function(y,...){
    # y = folders[1]
    ind = which(folders == y)
    ith_path = folders_path[ind]

    # Define the path to the folder containing the files you want to compress
    ith_FunRaw_path = list.files(ith_path, full.names = T, pattern = "FunRaw")[list.files(ith_path, full.names = F, pattern = "FunRaw") == "FunRaw"]
    ith_MT1Raw_path = list.files(ith_path, full.names = T, pattern = "T1Raw")[list.files(ith_path, full.names = F, pattern = "T1Raw") == "T1Raw"]


    if(length(ith_FunRaw_path)>0 & length(ith_MT1Raw_path) > 0){
      # Define the destination folder and the name of the compressed file
      ith_destination_folder = ith_path
      ith_compressed_file_name = paste0(y, ".zip")
      ith_compressed_file_path = file.path(ith_destination_folder, ith_compressed_file_name)



      # compress folders
      tictoc::tic()
      zip::zip(zipfile = ith_compressed_file_path, files = c(ith_FunRaw_path, ith_MT1Raw_path), include_directories = F, recurse = T, mode = "cherry-pick")
      cat("\n", crayon::green("Compressing Raw folders is done : "), crayon::red(y), "\n")
      tictoc::toc()



      # remove folders
      tictoc::tic()
      unlink(ith_FunRaw_path, recursive = T) %>% invisible()
      unlink(ith_MT1Raw_path, recursive = T) %>% invisible()
      cat("\n", crayon::green("Removing Raw folders is done : "), crayon::red(y), "\n")
      tictoc::toc()


      # Hide zip file
      if(hide.zip.file){
        cmd = paste("attrib +h", shQuote(ith_compressed_file_path))
        system(cmd) %>% invisible()
      }
    }else{
      cat("\n", crayon::green("Compressing Raw folders is done : "), crayon::red(y), "\n")
      # cat("\n", crayon::green("Removing Raw folders is done : "), crayon::red(y), "\n")
    }
  })
  cat("\n", crayon::bgMagenta("Step 3.7"), crayon::blue("Compressing and Removing Raw folders is done!"), "\n")
}
