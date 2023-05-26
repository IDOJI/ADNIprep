RS.fMRI_3.4_Moving.Files.to.Template.Named.Folder = function(path_Preprocessing.Completed, Template.Name = "@Original_EPI"){
  #=============================================================================
  # folders' list
  #=============================================================================
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)




  #=============================================================================
  # files list for each folders
  #=============================================================================
  files.list = lapply(folders_path, FUN=function(x){list.files(x)})
  files_path.list = lapply(folders_path, FUN=function(x){list.files(x, full.names = T)})





  #=============================================================================
  # Creating destination folders
  #=============================================================================
  destination_folders_path = sapply(folders_path, FUN=function(x, ...){
    dir.create(paste0(x, "/", Template.Name), showWarnings = F)
    paste0(x, "/", Template.Name)
  })




  #=============================================================================
  # moving files except for
  #=============================================================================
  sapply(seq_along(destination_folders_path), function(i,...){
    ith_files_path = files_path.list[[i]]
    ith_files = files.list[[i]]

    ith_Raw_index = filter_by(x = ith_files, include = c("FunRaw", "T1Raw", Template.Name, "@"), any_include = T, as.ind = T)

    if(length(ith_Raw_index)>0){
      ith_files_path_except_Raw = ith_files_path[-ith_Raw_index]
      ith_files_except_Raw = ith_files[-ith_Raw_index]
    }else{
      ith_files_path_except_Raw = ith_files_path
      ith_files_except_Raw = ith_files
    }


    sapply(seq_along(ith_files_path_except_Raw), FUN=function(k, ...){
      fs::file_move(path = ith_files_path_except_Raw[k], new_path = paste0(destination_folders_path[i], "/", ith_files_except_Raw[k])) %>% invisible
    })
    cat("\n",crayon::green("Moving folders to a template-named folder is done : "), crayon::red(folders[i]),"\n")
  })

  cat("\n", crayon::bgMagenta("Step 3.4"), crayon::red("Moving Files to a Template-Named Folder"), crayon::blue("is done!"),"\n")
}

























