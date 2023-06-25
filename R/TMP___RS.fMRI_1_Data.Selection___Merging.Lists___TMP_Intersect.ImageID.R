RS.fMRI_1.2_Merging.Lists___Intersect.ImageID = function(data.list,...){

  ### loading the data
  df1 = Subjects.list[[1]] # Search
  df2 = Subjects.list[[2]] # QC

  Subjects.list[[3]] %>% str

  df1$VISIT %>% table


  ### Image ID
  ImageID_intersect = intersect(df1$IMAGE_ID, df2$IMAGE_ID)


  ### subset by ID
  ImageID_with_more_than_one_rows = c()
  combined.list = lapply(ImageID_intersect, FUN=function(x, ...){
    # x = ImageID_intersect[1]
    sub_1 = df1 %>% filter(IMAGE_ID==x)
    sub_2 = df2 %>% filter(IMAGE_ID==x)
    if(nrow(sub_1)==1 && nrow(sub_2)==1){
      combined_1 = dplyr::full_join(sub_1, sub_2, by="IMAGE_ID", suffix=c("_SEARCH", "_QC"))
      combined_2 = combined_1 %>% dplyr::relocate(starts_with("RID_"), .after="IMAGE_ID")
      cat("\n",crayon::blue(paste0(100 * which(ImageID_intersect==x)/length(ImageID_intersect), "% is done")),"\n")
      return(combined_2)
    }else{
      ImageID_with_more_than_one_rows <<- c(x, ImageID_with_more_than_one_rows)
      cat("\n",crayon::blue(paste0(100 * which(ImageID_intersect==x)/length(ImageID_intersect), "% is done")),"\n")
    }
  })
}
