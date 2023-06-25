RS.fMRI_1.2_Merging.Lists___Protocol.Split = function(Data.list){
  # Data.list = Merging_Search.list
  #=============================================================================
  # Extract & Combine Imaging Protocol
  #=============================================================================
  EPI_Protocol = c()
  MT1_Protocol = c()
  Protocol_Extracted_Data.list = lapply(seq_along(Data.list), function(i, ...){
    ith_RID.list = Data.list[[i]]
    ith_EPI.df = ith_RID.list[[1]]
    ith_MT1.df = ith_RID.list[[2]]

    # Select protocol column
    ith_EPI_Protocol = ith_EPI.df$IMAGING.PROTOCOL;ith_EPI.df$IMAGING.PROTOCOL = NULL
    ith_MT1_Protocol = ith_MT1.df$IMAGING.PROTOCOL;ith_MT1.df$IMAGING.PROTOCOL = NULL

    # Extract df
    ith_EPI_Protocol.df = RS.fMRI_1.2_Merging.Lists___Protocol.Split___Extracting.Data.Frame(ith_EPI_Protocol, suffix = "IMAGING.PROTOCOL___")
    ith_MT1_Protocol.df = RS.fMRI_1.2_Merging.Lists___Protocol.Split___Extracting.Data.Frame(ith_MT1_Protocol, suffix = "IMAGING.PROTOCOL___")

    # Protocol intersection
    EPI_Protocol <<- c(EPI_Protocol, names(ith_EPI_Protocol.df)) %>% unique
    MT1_Protocol <<- c(MT1_Protocol, names(ith_MT1_Protocol.df)) %>% unique

    ith_EPI.df = cbind(ith_EPI.df, ith_EPI_Protocol.df)
    ith_MT1.df = cbind(ith_MT1.df, ith_MT1_Protocol.df)
    return(list(EPI = ith_EPI.df, MT1 = ith_MT1.df))
  })



  #=============================================================================
  # Extract & Combine Imaging Protocol
  #=============================================================================
  EPI_Protocol_Dummy.df = matrix(NA, ncol = length(EPI_Protocol)) %>% as.data.frame;names(EPI_Protocol_Dummy.df) = EPI_Protocol
  MT1_Protocol_Dummy.df = matrix(NA, ncol = length(MT1_Protocol)) %>% as.data.frame;names(MT1_Protocol_Dummy.df) = MT1_Protocol


  Protocol_Merged_Data.list = lapply(seq_along(Protocol_Extracted_Data.list), function(i, ...){
    ith_RID.list = Protocol_Extracted_Data.list[[i]]
    # ith_RID.list = Protocol_Extracted_Data.list[[1]]
    ith_EPI.df = ith_RID.list[[1]]
    ith_MT1.df = ith_RID.list[[2]]

    # Merge
    ith_EPI_Merged.df = merge(ith_EPI.df, EPI_Protocol_Dummy.df, by = intersect(names(ith_EPI.df), names(EPI_Protocol_Dummy.df)), all.x = T) %>% relocate(starts_with("IMAGING.PROTOCOL"), .after=last_col())
    ith_MT1_Merged.df = merge(ith_MT1.df, MT1_Protocol_Dummy.df, by = intersect(names(ith_MT1.df), names(MT1_Protocol_Dummy.df)), all.x = T) %>% relocate(starts_with("IMAGING.PROTOCOL"), .after=last_col())

    cat("\n", crayon::green("Merging Imaging Protocol :"), crayon::red(paste0("RID ", ith_EPI.df$RID)),"\n")

    return(list(EPI = ith_EPI_Merged.df, MT1 = ith_MT1_Merged.df))
  })


  return(Protocol_Merged_Data.list)
}





















