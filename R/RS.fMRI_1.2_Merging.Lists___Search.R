RS.fMRI_1.2_Merging.Lists___Search = function(Subjects.list){
  # Subjects.list = Merged_QC_NFQ.list
  #=====================================================================================
  # Data Load
  #=====================================================================================
  QC_EPB.list = Subjects.list[[1]]
  QC_MT1.list = Subjects.list[[2]]
  Search.df = Subjects.list[[3]]




  #=====================================================================================
  # QC RID & Dates
  #=====================================================================================
  RID_QC = names(QC_EPB.list)
  Dates_QC = sapply(QC_EPB.list, FUN=function(x){x$SERIES_DATE}) %>% unlist

  ImageID_EPB_QC = sapply(QC_EPB.list, FUN=function(x){x$IMAGE_ID}) %>% unlist
  ImageID_MT1_QC = sapply(QC_MT1.list, FUN=function(x){x$IMAGE_ID}) %>% unlist
  ImageID_QC = c(ImageID_EPB_QC, ImageID_MT1_QC)




  #=====================================================================================
  # Search : Subset by Image ID
  #=====================================================================================
  Intersection_Search.df = Search.df %>% filter(IMAGE_ID %in% ImageID_QC)
  Search_ImageID = Intersection_Search.df$IMAGE_ID



  #=====================================================================================
  # QC : Having Image IDs in Search.df
  #=====================================================================================
  Index_EPB = which(ImageID_EPB_QC %in% Search_ImageID)
  Index_MT1 = which(ImageID_MT1_QC %in% Search_ImageID)
  intersection_Index = intersect(Index_EPB, Index_MT1)


  Intersection_QC_EPB.list = QC_EPB.list[intersection_Index]
  Intersection_QC_MT1.list = QC_MT1.list[intersection_Index]





  #=====================================================================================
  # Subset Search by EPB & MT1
  #=====================================================================================
  Search_EPB.df = Intersection_Search.df %>% filter(IMAGE_ID %in% ImageID_EPB_QC)
  Search_MT1.df = Intersection_Search.df %>% filter(IMAGE_ID %in% ImageID_MT1_QC)






  #=====================================================================================
  # Check Image ID matching
  #=====================================================================================
  Do_EPB_ImageID_match = sum(Search_EPB.df$IMAGE_ID %in% ImageID_EPB_QC) == Intersection_QC_EPB.list %>% names %>% length
  Do_MT1_ImageID_match = sum(Search_MT1.df$IMAGE_ID %in% ImageID_MT1_QC) == Intersection_QC_MT1.list %>% names %>% length
  if(!Do_EPB_ImageID_match || !Do_MT1_ImageID_match){
    stop("The Image IDs don's match betwee QC and Search")
  }else{
    Search_EPB.df$IMAGE_ID = NULL
    Search_MT1.df$IMAGE_ID = NULL
  }




  #=====================================================================================
  # Check RID
  #=====================================================================================
  Are_EPB_RID_same = sum(Search_EPB.df$RID %in% names(Intersection_QC_EPB.list)) == names(Intersection_QC_EPB.list) %>% length
  Are_MT1_RID_same = sum(Search_MT1.df$RID %in% names(Intersection_QC_MT1.list)) == names(Intersection_QC_MT1.list) %>% length
  if(Are_EPB_RID_same || Are_MT1_RID_same){
    Search_EPB.df$RID = NULL
    Search_MT1.df$RID = NULL
  }




  #=====================================================================================
  # binding QC & NFQ
  #=====================================================================================
  Merged_EPB.list = list()
  Merged_MT1.list = list()
  if(length(QC_EPB.list)>0 & length(QC_MT1.list)){
    for(i in 1:length(Intersection_QC_EPB.list)){
      Merged_EPB.list[[i]] = bind_cols(Intersection_QC_EPB.list[[i]], Search_EPB.df[i,]) %>% as_tibble
      Merged_MT1.list[[i]] = bind_cols(Intersection_QC_MT1.list[[i]], Search_MT1.df[i,]) %>% as_tibble
    }

  }


  #=====================================================================================
  # Renaming
  #=====================================================================================
  names(Merged_EPB.list) = names(Intersection_QC_EPB.list)
  names(Merged_MT1.list) = names(Intersection_QC_EPB.list)


  return(list(EPB = Merged_EPB.list, MT1 = Merged_MT1.list))
}















