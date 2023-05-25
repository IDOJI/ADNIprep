RS.fMRI_3.2_Extract.ImageIDs.of.Error.Folders.RID = function(path_All.Subjects.EPB.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv"),
                                                             path_All.Subjects.MT1.List.File = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv"),
                                                             path_Error.Folder){
  #=============================================================================
  # Loading subjects lists for each Manufacturer
  #=============================================================================
  EPB_Subjects.df = read.csv(path_All.Subjects.EPB.List.File) %>% as_tibble
  MT1_Subjects.df = read.csv(path_All.Subjects.MT1.List.File) %>% as_tibble



  #=============================================================================
  # Loading Folders list
  #=============================================================================
  Error_Folders = list.files(path_Preprocessing.Error)
  path_ADNI = list.files(path_ADNI.Unzipped.Folders, full.names = T)




  #=============================================================================
  # Find matching Image IDs
  #=============================================================================
  Not_Matching_RID = sapply(path_ADNI, FUN=function(ith_path, ...){
    # ith_path = path_ADNI[153]

    ith_RID = substr(ith_path, nchar(ith_path)-8, nchar(ith_path))
    ith_RID = strsplit(ith_RID, "_")[[1]]
    ith_RID = ith_RID[length(ith_RID)] %>% as.integer

    ith_ImageID_EPB = filter(EPB_Subjects.df, RID == ith_RID)$IMAGE_ID
    ith_ImageID_MT1 = filter(MT1_Subjects.df, RID == ith_RID)$IMAGE_ID


    tictoc::tic()
    file_list = files.list(ith_path)
    tictoc::toc()


    Fun_Does_ImageID_Match = grep(ith_ImageID_EPB, file_list) %>% length > 0
    MT1_Does_ImageID_Match = grep(ith_ImageID_MT1, file_list) %>% length > 0

    percent = round(which(path_ADNI == ith_path)/length(path_ADNI) * 100, 4)
    cat("\n", crayon::bgMagenta(percent), crayon::yellow("% is done!"), "\n")

    if(!Fun_Does_ImageID_Match | !MT1_Does_ImageID_Match){
      return(ith_RID)
    }
  }) %>% rm_list_null



  #=============================================================================
  # Extract Image IDs to Download
  #=============================================================================
  Not_Matching_RID = Not_Matching_RID %>% as.numeric
  EPB_ImageID = sapply(Not_Matching_RID, FUN=function(jth_RID, ...){
    EPB_Subjects.df %>% filter(RID == jth_RID) %>% select(IMAGE_ID)
  }) %>% unlist
  MT1_ImageID = sapply(Not_Matching_RID, FUN=function(jth_RID, ...){
    MT1_Subjects.df %>% filter(RID == jth_RID) %>% select(IMAGE_ID)
  }) %>% unlist
  Images_To_Download.df = data.frame(RID = Not_Matching_RID, EPB = EPB_ImageID, MT1 = MT1_ImageID, path = names(Not_Matching_RID))
  rownames(Images_To_Download.df) = NULL



  return(Images_To_Download.df)

}
