RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Image.ID = function(subjects.list){
  ### intersection by image ID (RID 기준으로 합치면 QC 정보를 빠뜨리게 된다.)
  #============================================================================
  # Extract Image ID
  #============================================================================
  ImageID_Search = c(subjects.list[[1]]$fMRI$IMAGE.ID, subjects.list[[1]]$MRI$IMAGE.ID)

  ImageID_SQ = intersect(ImageID_Search, subjects.list[[2]]$IMAGE_ID)


  #============================================================================
  # Intersection by Image ID
  #============================================================================
  subjects.list[[1]]$fMRI = subjects.list[[1]]$fMRI %>% filter(IMAGE.ID %in% ImageID_SQ)
  subjects.list[[1]]$MRI = subjects.list[[1]]$MRI %>% filter(IMAGE.ID %in% ImageID_SQ)
  subjects.list[[2]] = subjects.list[[2]] %>% filter(IMAGE_ID %in% ImageID_SQ)


  text = "1.1 : Subsetting by intersection IMAGE_ID is done."
  cat("\n", crayon::green(text), "\n")

  return(subjects.list)
}
