RS.fMRI_2.7_Check.and.Rename.Sub.Numbering___Change.Sub.Num = function(path_Unzipped.Folders, only_folders=F, pattern_exclude=NULL){
  for(i in 1:length(path_Unzipped.Folders)){
    # ith_folder_path = path_Unzipped.Folders[300]
    ith_folder_path = path_Unzipped.Folders[i]
    ith_folder = strsplit(ith_folder_path, "/")[[1]];ith_folder = ith_folder[length(ith_folder)]
    ith_Sub_Num = strsplit(ith_folder, "___")[[1]][2]

    # changing folders names
    ith_folders = list_files_and_folders_path(path = ith_folder_path, recursive = T, only_folders = only_folders, full.path = F, pattern_exclude = pattern_exclude)
    ith_folders_path = list_files_and_folders_path(path = ith_folder_path, recursive = T, only_folders = only_folders, full.path = T, pattern_exclude=pattern_exclude)


    for(f in 1:length(ith_folders)){
      # fth = ith_folders[10]
      have_Sub_in_name = grep("Sub", ith_folders[f]) %>% length > 0
      if(have_Sub_in_name){
        fth_Sub_Num = str_match(ith_folders[f], 'Sub_[:digit:]+') %>% as.vector
        if(!is.na(fth_Sub_Num ) && fth_Sub_Num != ith_Sub_Num){
          fth_renamed = gsub(pattern = fth_Sub_Num, replacement = ith_Sub_Num, x = ith_folders[f])

          ith_Sub_folder_path = substr(ith_folders_path[f], 1, nchar(ith_folders_path[f])- nchar(ith_folders[f]))

          fs::file_move(path = ith_folders_path[f], new_path = paste0(ith_Sub_folder_path, fth_renamed))

        }
      }
    }
    cat("\n", crayon::green("Renmaing SubNum is done : "), crayon::bgRed(ith_folder) ,"\n")
  }
}
