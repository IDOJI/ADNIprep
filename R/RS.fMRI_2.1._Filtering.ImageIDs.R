RS.fMRI_2.1._Filtering.ImageIDs = function(path_Old.Subjects.List.Folder, path_New.Subjects.List.Folder, path_Export){
  # path_Old.Subjects.List.Folder = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported_OLD/0.All_Subjects"
  # path_New.Subjects.List.Folder = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects"
  # path_Export = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/New_ImageIDs_to_Download"


  #=============================================================================
  # Load image IDs
  #=============================================================================
  ImageID_Old = read.table(list.files(path_Old.Subjects.List.Folder, pattern = "ImageID", full.names = T)) %>% suppressWarnings()
  ImageID_Old = strsplit(ImageID_Old %>% unlist, split = ",")[[1]]


  ImageID_New = read.table(list.files(path_New.Subjects.List.Folder, pattern = "ImageID", full.names = T)) %>% suppressWarnings()
  ImageID_New = strsplit(ImageID_New %>% unlist, split = ",")[[1]]


  ImageID_To_Download = ImageID_New[!ImageID_New %in% ImageID_Old]


  #=============================================================================
  # Exporting Image IDs to Download
  #=============================================================================
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Image.ID(ImageID = ImageID_To_Download ,filename = "Additional_Download", path = path_Export)
  cat("\n", crayon::yellow("STEP 2.1 : Exporting New ImageID is done!"), "\n")
}
