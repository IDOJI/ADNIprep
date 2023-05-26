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
  destination_folders_path = sapply(folders_path, FUN=function(x){
    dir.create(paste0(x, "/", Template.Name), showWarnings = F)
    paste0(x, "/", Template.Name)
  })




  #=============================================================================
  # moving files except for
  #=============================================================================
  for(i in 1:length(destination_folders_path)){
    ith_files_path = files_path.list[[i]]
    ith_files = files.list[[i]]

    ith_Raw_index = filter_by(x = ith_files, including.words = c("FunRaw", "T1Raw", Template.Name, "@"), any_including.words = T, as.ind = T)

    ith_files_path_except_Raw = ith_files_path[-ith_Raw_index]
    ith_files_except_Raw = ith_files[-ith_Raw_index]

    sapply(ith_files_path_except_Raw, FUN=function(y, ...){
      # y = ith_files_path_except_Raw[1]
      ind = which(ith_files_path_except_Raw==y)


      fs::file_move(path = y, new_path = paste0(destination_folders_path[i], "/", ith_files_except_Raw[ind]))


      })
    cat("\n",crayon::green("Moving folders to a template-named folder is done : "), crayon::red(folders[i]),"\n")
  }





  #=============================================================================
  # moving FunImg files # 이거 왜 없어지지 자꾸???
  #=============================================================================
  files.list = lapply(folders_path, FUN=function(x){list.files(x)})
  files_path.list = lapply(folders_path, FUN=function(x){list.files(x, full.names = T)})
  for(n in 1:length(files.list)){
    nth_template.folder = filter_by(files.list[[n]], including.words = Template.Name)
    nth_template.folder_path = filter_by(files_path.list[[n]], including.words = Template.Name)
    nth_have_Sub = list.files(nth_template.folder_path, pattern = "Sub_") %>% length > 0
    nth_dont_have_FunImg = !"FunImg" %in% list.files(nth_template.folder_path)
    nth_dont_have_FunRaw = !"FunRaw" %in% list.files(nth_template.folder_path)

    if(nth_have_Sub && nth_dont_have_FunImg){
      dir.create(paste0(nth_template.folder_path, "/", "FunImg"), F)
      fs::file_move(list.files(nth_template.folder_path, pattern = "Sub_", full.names = T),
                    paste0(paste0(nth_template.folder_path, "/", "FunImg/"), list.files(nth_template.folder_path, pattern = "Sub_", full.names = F)))
    }else if(nth_have_Sub && nth_dont_have_FunRaw && !nth_dont_have_FunImg){
      dir.create(paste0(nth_template.folder_path, "/", "FunRaw"), F)
      fs::file_move(list.files(nth_template.folder_path, pattern = "Sub_", full.names = T),
                    paste0(paste0(nth_template.folder_path, "/", "FunRaw/"), list.files(nth_template.folder_path, pattern = "Sub_", full.names = F)))
    }
  }


  cat("\n", crayon::bgMagenta("Step 3.4"), crayon::red("Moving Files to a Template-Named Folder"), crayon::blue("is done!"),"\n")
}

























