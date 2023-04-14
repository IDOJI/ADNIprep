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
  QC_RID = names(QC_EPB.list)
  QC_Dates = sapply(QC_EPB.list, FUN=function(x){x$SERIES_DATE}) %>% unlist
  QC_ImageID_EPB = sapply(QC_EPB.list, FUN=function(x){x$IMAGE_ID}) %>% unlist
  QC_ImageID_MT1 = sapply(QC_MT1.list, FUN=function(x){x$IMAGE_ID}) %>% unlist
  QC_ImageID = c(QC_ImageID_EPB, QC_ImageID_MT1)



  #=====================================================================================
  # Search : Intersection Image ID
  #=====================================================================================
  Search_ImageID = Search.df$IMAGE.ID
  Have_QC_ImageID_Not.In.Search = sum(!QC_ImageID %in% Search_ImageID) > 0
  if(Have_QC_ImageID_Not.In.Search){
    cat("\n", crayon::blue(QC_ImageID[!QC_ImageID %in% Search_ImageID]), "\n")
    stop("There are Image ID in QC which are not in Search list !!!")
  }
  ImageID_EPB_Search.df = Search.df %>% filter(IMAGE.ID %in% QC_ImageID_EPB)
  ImageID_MT1_Search.df = Search.df %>% filter(IMAGE.ID %in% QC_ImageID_MT1)




  #=====================================================================================
  # As df QC data
  #=====================================================================================
  QC_EPB.df = do.call(rbind, QC_EPB.list);QC_EPB.df$RID = NULL
  QC_MT1.df = do.call(rbind, QC_MT1.list);QC_MT1.df$RID = NULL

  ImageID_QC_EPB = QC_EPB.df$IMAGE_ID
  ImageID_QC_MT1 = QC_MT1.df$IMAGE_ID

  ImageID_Search_EPB = ImageID_EPB_Search.df$IMAGE.ID
  ImageID_Search_MT1 = ImageID_MT1_Search.df$IMAGE.ID



  #=====================================================================================
  # binding QC & NFQ
  #=====================================================================================
  does_EPB_match = sum(ImageID_QC_EPB %in% ImageID_Search_EPB) == length(ImageID_QC_EPB)
  does_MT1_match = sum(ImageID_QC_MT1 %in% ImageID_Search_MT1) == length(ImageID_QC_MT1)
  if(does_EPB_match && does_MT1_match){
    EPB_Combined = bind_cols(QC_EPB.df, ImageID_EPB_Search.df)
    MT1_Combined = bind_cols(QC_MT1.df, ImageID_EPB_Search.df)
  }else{
    stop("The ImageIDs don't match ! ")
  }



  return(list(EPB = EPB_Combined, MT1_Combined))
}















