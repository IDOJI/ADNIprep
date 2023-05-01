RS.fMRI_2.5_Changing.Folders.Names.By.Sub.Numbering = function(path_All.Subjects.EPB.List.File,
                                                               path_ADNI.Unzipped.Folders){
  #===========================================================================================
  # path & folders
  #===========================================================================================
  Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders)
  path_Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders, full.names = T)





  #===========================================================================================
  # Extract RID from folders' name
  #===========================================================================================
  RID = sapply(Unzipped.Folders, FUN=function(ith_Folder){
    # ith_Folder = Unzipped.Folders[430]
    ith_RID = substr(ith_Folder, nchar(ith_Folder)-3, nchar(ith_Folder))
    gsub("[^0-9]", "", ith_RID) %>% as.numeric
  })
  names(RID) = NULL




  #===========================================================================================
  # Loading subjects lists
  #===========================================================================================
  All_Subjects_EPB.df = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble





  #===========================================================================================
  # Rename Folders' name
  #===========================================================================================
  sapply(RID, FUN=function(ith_RID, ...){
    # ith_RID = RID[1]
    ind = which(RID == ith_RID)
    ith_EPB.df = All_Subjects_EPB.df %>% filter(RID == ith_RID)
    ith_Filename_To = ith_EPB.df$File_Names
    ith_Filename_From = Unzipped.Folders[ind]
    ith_Filename_From_path = path_Unzipped.Folders[ind]

    ith_Filename_From_path_split = strsplit(ith_Filename_From_path, "/")[[1]]
    ith_Filename_From_path_split = ith_Filename_From_path_split[-length(ith_Filename_From_path_split)]
    ith_Filename_From_path_split = paste0(ith_Filename_From_path_split, collapse = "/")


    ith_result = file.rename(from = ith_Filename_From_path, to = paste0(ith_Filename_From_path_split, "/", ith_Filename_To))

    if(ith_result){
      cat("\n", crayon::green("The folder's name has been changed : RID"), crayon::red(ith_RID),"\n")
    }
  })

  cat("\n", crayon::bgMagenta("Step 2.5"), crayon::blue("Changing folders names by Sub_Numbering is done!"), "\n")
}
