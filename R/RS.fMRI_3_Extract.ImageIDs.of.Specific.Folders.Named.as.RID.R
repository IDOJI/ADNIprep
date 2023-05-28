RS.fMRI_3_Extract.ImageIDs.of.Specific.Folders.Named.as.RID = function(path_All.Subjects.EPB.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv"),
                                                                       path_All.Subjects.MT1.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv"),
                                                                       path_Sub.Folders){
  #=============================================================================
  # Loading subjects lists for each Manufacturer
  #=============================================================================
  EPB_Subjects.df = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble
  MT1_Subjects.df = read.csv(path_All.Subjects.MT1.List.File) %>% as_tibble



  #=============================================================================
  # Loading Folders list
  #=============================================================================
  Sub_Folders = list.files(path_Sub.Folders)




  #=============================================================================
  # Find matching Image IDs
  #=============================================================================
  ImageIDs = lapply(seq_along(Sub_Folders), FUN=function(i, ...){
    ith_Sub_Folders = Sub_Folders[i]


    ith_RID = substr(ith_Sub_Folders, nchar(ith_Sub_Folders)-7, nchar(ith_Sub_Folders))
    ith_RID = strsplit(ith_RID, "_")[[1]][2] %>% as.numeric


    ith_ImageID_EPB = filter(EPB_Subjects.df, RID == ith_RID)$IMAGE_ID
    ith_ImageID_MT1 = filter(MT1_Subjects.df, RID == ith_RID)$IMAGE_ID

    return(c(ith_ImageID_EPB, ith_ImageID_MT1))
  }) %>% unlist




  cat("\n", crayon::blue("The selected Image IDs are as follows : ") ,"\n")
  paste(ImageIDs, collapse=",") %>% cat
}
