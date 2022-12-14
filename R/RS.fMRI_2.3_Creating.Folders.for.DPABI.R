RS.fMRI_2.3_Creating.Folders.for.DPABI = function(path_Subjects, path_Subjects_RS.fMRI, All.Subjects=F){
  #=============================================================================
  # Creating Raw folders
  #=============================================================================
  ### folders
  Manu_folders = c(list.files(path_Subjects_RS.fMRI, pattern = "_MB"),
                   list.files(path_Subjects_RS.fMRI, pattern = "_SB")) %>% sort


  ### creating Raw Folders
  Raw_Path.list = lapply(Manu_folders, FUN=function(ith_Manu_folder, ...){
    # ith_Manu_folder = Manu_folders[1]
    FunRaw_path = paste0(path_Subjects_RS.fMRI, ith_Manu_folder, "/FunRaw/")
    T1Raw_path  = paste0(path_Subjects_RS.fMRI, ith_Manu_folder, "/T1Raw/")
    dir.create(FunRaw_path, showWarnings = F)
    dir.create(T1Raw_path,  showWarnings = F)
    cat("\n",
        crayon::blue("Creating"),
        crayon::red("FunRaw"),
        crayon::blue("&"),
        crayon::red("T1Raw"),
        crayon::blue("for"),
        crayon::yellow(ith_Manu_folder),
        crayon::blue("is done"),"\n")
    return(list(FunRaw_path=FunRaw_path, T1Raw_path=T1Raw_path))
  })



  #=============================================================================
  # Creating Sub_xxx folders
  #=============================================================================
  ### subjects folders' path
  if(All.Subjects){
    selected_folders = list.files(path_Subjects)[grep("All", list.files(path_Subjects))]
  }else{
    selected_folders = c(list.files(path_Subjects, pattern = "_MB"),
                         list.files(path_Subjects, pattern = "_SB"))
  }


  ### reading csv files for each manu subjects
  n_subjects_for_each_manu = sapply(selected_folders, FUN=function(x, ...){
    ind = which(selected_folders==x)
    ith_folder_path = paste0(path_Subjects, selected_folders[ind], "/")
    EPB_file_name       = list.files(ith_folder_path, "EPB")
    read.csv(paste0(ith_folder_path, "/", EPB_file_name)) %>% nrow %>% return
  })



  ### Creating "Sub_xxx" folders path
  Sub_folders_path_for_each_manu.list = lapply(selected_folders, function(y, ...){
    # y = selected_folders[1]



    ind = which(selected_folders == y)

    ith_manu_num = n_subjects_for_each_manu[ind]

    ith_manu_path = paste0(path_Subjects_RS.fMRI, y, "/")
    ith_manu_EPB_path = paste0(ith_manu_path, "FunRaw", "/")
    ith_manu_MT1_path = paste0(ith_manu_path, "T1Raw", "/")

    if(nchar(1:7) %>% max < 3){
      sub_folders_names = paste0("Sub_", fit_length(1:ith_manu_num, fit.num = 3))
    }else{
      sub_folders_names = paste0("Sub_", fit_length(1:ith_manu_num, fit.num = nchar(1:7) %>% max))
    }
    ith_EPB_MT1_Sub_folders_path = list(EPB=paste0(ith_manu_EPB_path, sub_folders_names), MT1=paste0(ith_manu_MT1_path, sub_folders_names))


    cat("\n",
        crayon::yellow(Manu_folders[ind]),
        crayon::blue(": Extracting"),
        crayon::red("Sub_xxx"),
        crayon::blue("folders is done!"),
        "\n")



    return(ith_EPB_MT1_Sub_folders_path)
  })



  ### creating folders for each path
  sapply(Manu_folders, FUN=function(ith_Manu,...){
    # ith_manu = Manu_folders[1]
    ind = which(Manu_folders==ith_Manu)
    ith_Sub_folders_path_for_each_manu = Sub_folders_path_for_each_manu.list[[ind]]

    EPB_sub = ith_Sub_folders_path_for_each_manu[[1]]
    MT1_sub = ith_Sub_folders_path_for_each_manu[[2]]
    sapply(EPB_sub, FUN=function(ith_EPB){
      # ith_EPB = EPB_sub[1]
      jth_sub = strsplit(ith_EPB, "/")[[1]][6]
      dir.create(ith_EPB, showWarnings = F)
      cat("\n",
          crayon::yellow(ith_Manu),
          crayon::blue(": Creating"),
          crayon::red(jth_sub),
          crayon::blue("in"),
          crayon::yellow("FunRaw"),
          crayon::blue("folder is done"), "\n")
    })
    sapply(MT1_sub, FUN=function(ith_MT1){
      # ith_MT1 = MT1_sub[1]
      jth_sub = strsplit(ith_MT1, "/")[[1]][6]
      dir.create(ith_MT1, showWarnings = F)
      cat("\n",
          crayon::yellow(ith_Manu),
          crayon::blue(": Creating"),
          crayon::red(jth_sub),
          crayon::blue("in"),
          crayon::yellow("T1Raw"),
          crayon::blue("folder is done"), "\n")
    })
  })

  return(Sub_folders_path_for_each_manu.list)
}





