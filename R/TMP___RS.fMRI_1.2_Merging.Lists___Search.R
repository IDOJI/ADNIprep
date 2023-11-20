RS.fMRI_1.2_Merging.Lists___Search = function(Merged_QC_NFQ.list, Search.df){
  #=====================================================================================
  # Data Load
  #=====================================================================================
  QC_EPB.list = Merged_QC_NFQ.list[[1]]
  QC_MT1.list = Merged_QC_NFQ.list[[2]]




  #=====================================================================================
  # Binding QC & Search
  #=====================================================================================
  RID = c()
  Merged_QC_Search.list = lapply(seq_along(QC_EPB.list), function(i, ... ){
    # EPI
    ith_EPB.df = QC_EPB.list[[i]]
    ith_EPB_Search.df = Search.df %>% filter(IMAGE_ID == ith_EPB.df$IMAGE_ID)
    ith_EPB_Merged.df = merge(ith_EPB.df, ith_EPB_Search.df, by = "IMAGE_ID")
    ith_EPB_Merged.df = rm_same_col(ith_EPB_Merged.df, col1 = "RID.x", col2 = "RID.y", col.name = "RID") %>% relocate(RID, IMAGE_ID, SCANDATE, SERIES_DATE)


    # MT1
    ith_MT1.df = QC_MT1.list[[i]]
    ith_MT1_Search.df = Search.df %>% filter(IMAGE_ID == ith_MT1.df$IMAGE_ID)
    ith_MT1_Merged.df = merge(ith_MT1.df, ith_MT1_Search.df, by = "IMAGE_ID")
    ith_MT1_Merged.df = rm_same_col(ith_MT1_Merged.df, col1 = "RID.x", col2 = "RID.y", col.name = "RID") %>% relocate(RID, IMAGE_ID, SERIES_DATE)


    cat("\n", crayon::green("Merging QC and Search  :"), crayon::red(paste0("RID ", ith_EPB.df$RID)) ,"\n")


    RID <<- c(RID, ith_MT1.df$RID)
    return(list(EPB = ith_EPB_Merged.df, MT1 = ith_MT1_Merged.df))
  })
  names(Merged_QC_Search.list) = RID

  return(Merged_QC_Search.list)
}















