RS.fMRI_2_Changing.Folders.Names.By.Scanner.RID = function(path_All.Subjects.EPB.List.File,
                                                           path_ADNI.Unzipped.Folders,
                                                           filename_col_name = "File_Names_New"){
  # path_New.EPI.Subjects.Lists = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported_New/[Final_Selected]_Subjects_list_EPB_All_New.csv"
  # path_Sub.Folders = "E:/ADNI/ADNI_RS.fMRI___SB/New_Downloaded/ADNI"
  #===========================================================================================
  # path & folders
  #===========================================================================================
  Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders)
  path_Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders, full.names = T)





  #===========================================================================================
  # Extract RID from folders' name
  #===========================================================================================
  RID = sapply(Unzipped.Folders, FUN=function(ith_Folder){
    # ith_Folder = Unzipped.Folders[100]
    ith_RID = str_extract(ith_Folder, "RID_\\d+")
    gsub("[^0-9]", "", ith_RID) %>% as.numeric
  }) %>% unname





  #===========================================================================================
  # Loading subjects lists
  #===========================================================================================
  All_Subjects_EPB.df = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble





  #===========================================================================================
  # Rename Folders' name
  #===========================================================================================
  Results = sapply(seq_along(RID), FUN=function(i, ...){
    ith_RID = RID[i]
    ith_EPB.df = All_Subjects_EPB.df %>% filter(RID == ith_RID)

    ith_Filename_To = ith_EPB.df[,filename_col_name] %>% unlist %>% unname
    ith_Filename_From = Unzipped.Folders[i]
    ith_Filename_From_path = path_Unzipped.Folders[i]

    ith_Filename_From_path_split = strsplit(ith_Filename_From_path, "/")[[1]]
    ith_Filename_From_path_split = ith_Filename_From_path_split[-length(ith_Filename_From_path_split)]
    ith_Filename_From_path_split = paste0(ith_Filename_From_path_split, collapse = "/")


    ith_result = file.rename(from = ith_Filename_From_path, to = paste0(ith_Filename_From_path_split, "/", ith_Filename_To))

    if(ith_result){
      cat("\n", crayon::green("The folder's name has been changed : RID"), crayon::red(ith_RID),"\n")
    }
  })

  cat("\n", crayon::bgMagenta("Step 2"), crayon::blue("Changing folders names by Sub_Numbering is done!"), "\n")
}














