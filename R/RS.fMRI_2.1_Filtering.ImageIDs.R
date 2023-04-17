RS.fMRI_2.1_Filtering.ImageIDs = function(path_Old.Subjects.List.Folder = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported_OLD/0.All_Subjects",
                                          path_New.Subjects.List.Folder = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/0.All_Subjects",
                                          path_Export = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported/Newly_selected",
                                          path_ADNI.Unzipped.Folders = "D:/ADNI/ADNI_RS.fMRI_2/ADNI"){
  #=============================================================================
  # Load image IDs
  #=============================================================================
  ImageID_Old = read.table(list.files(path_Old.Subjects.List.Folder, pattern = "Image", full.names = T)) %>% suppressWarnings()
  ImageID_Old = strsplit(ImageID_Old %>% unlist, split = ",")[[1]]

  ImageID_New = read.table(list.files(path_New.Subjects.List.Folder, pattern = "ImageID", full.names = T)) %>% suppressWarnings()
  ImageID_New = strsplit(ImageID_New %>% unlist, split = ",")[[1]]





  #=============================================================================
  # Exporting Image IDs to Download
  #=============================================================================
  ImageID_To_Download = ImageID_New[!ImageID_New %in% ImageID_Old]
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Image.ID(ImageID = ImageID_To_Download ,filename = "Additional_Download", path = path_Export)





  #=============================================================================
  # Select Images to remove
  #=============================================================================
  ImageID_To_Remove = ImageID_Old[!ImageID_Old %in% ImageID_New]
  Subject_Lists_EPB_Old.df = read.csv(paste0(path_Old.Subjects.List.Folder, "/[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv")) %>% as_tibble
  Subject_Lists_MT1_Old.df = read.csv(paste0(path_Old.Subjects.List.Folder, "/[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv")) %>% as_tibble

  Selected_EPB_Old.df = Subject_Lists_EPB_Old.df %>% filter(IMAGE_ID %in% ImageID_To_Remove)
  Selected_MT1_Old.df = Subject_Lists_MT1_Old.df %>% filter(IMAGE_ID %in% ImageID_To_Remove)

  selected_RID = union(Selected_EPB_Old.df$RID, Selected_MT1_Old.df$RID)

  write.csv(Subject_Lists_EPB_Old.df %>% filter(RID %in% selected_RID), paste0(path_Export, "/EPB_Old_To_Remove.csv"))





  #=============================================================================
  # Renaming unzipped folders : remove the excluded image IDs' folders
  #=============================================================================
  if(!is.null(path_ADNI.Unzipped.Folders)){
    path_Exclude = paste0(paste(strsplit(path_ADNI.Unzipped.Folders, "/")[[1]], collapse = "/", sep = ""), "/###___Exclude_Old_Images")
    dir.create(path_Exclude, showWarnings = F)

    New_selected_RID = paste0("RID_", selected_RID)
    sapply(New_selected_RID, FUN=function(ith_RID, ...){
      # ith_RID = New_selected_RID[1]
       path_ith_folder = list.files(path_ADNI.Unzipped.Folders, pattern = ith_RID, full.names = T)
       ith_folder = list.files(path_ADNI.Unzipped.Folders, pattern = ith_RID, full.names = F)
       if(length(path_ith_folder)>0){
         file.rename(from = path_ith_folder, to = paste0(path_Exclude, "/", ith_folder))
       }

    })
  }



  cat("\n", crayon::yellow("STEP 2.1 : Exporting New ImageID & moving old folders is done!"), "\n")
}
