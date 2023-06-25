RS.fMRI_1_Data.Selection___Imaging.Protocol___Protocol.Split = function(Selected_Subjects.df){
  #=============================================================================
  # Imaging Protocol Cols
  #=============================================================================
  RID = Selected_Subjects.df$RID
  MT1_Protocol = Selected_Subjects.df$MT1___SEARCH___IMAGING.PROTOCOL;Selected_Subjects.df$MT1___SEARCH___IMAGING.PROTOCOL = NULL
  EPI_Protocol = Selected_Subjects.df$EPI___SEARCH___IMAGING.PROTOCOL;Selected_Subjects.df$EPI___SEARCH___IMAGING.PROTOCOL = NULL


  #=============================================================================
  # Extract & Combine Imaging Protocol
  #=============================================================================
  EPI_Protocol_Extracted = c()
  MT1_Protocol_Extracted = c()

  Protocol_Extracted_Data.list = lapply(seq_along(MT1_Protocol), function(i, ...){
    ith_EPI_Protocol = EPI_Protocol[i]
    ith_MT1_Protocol = MT1_Protocol[i]

    # Extract df
    ith_EPI_Protocol.df = RS.fMRI_1_Data.Selection___Imaging.Protocol___Protocol.Split___Extracting.Data.Frame(ith_EPI_Protocol, suffix = "IMAGING.PROTOCOL___")
    ith_MT1_Protocol.df = RS.fMRI_1_Data.Selection___Imaging.Protocol___Protocol.Split___Extracting.Data.Frame(ith_MT1_Protocol, suffix = "IMAGING.PROTOCOL___")

    # Protocol intersection
    EPI_Protocol_Extracted <<- c(EPI_Protocol_Extracted, names(ith_EPI_Protocol.df)) %>% unique
    MT1_Protocol_Extracted <<- c(MT1_Protocol_Extracted, names(ith_MT1_Protocol.df)) %>% unique

    return(list(EPI = ith_EPI_Protocol.df, MT1 = ith_MT1_Protocol.df))
  })





  #=============================================================================
  # Extract & Combine Imaging Protocol
  #=============================================================================
  EPI_Protocol_Dummy.df = matrix(NA, ncol = length(EPI_Protocol_Extracted)) %>% as.data.frame;names(EPI_Protocol_Dummy.df) = EPI_Protocol_Extracted
  MT1_Protocol_Dummy.df = matrix(NA, ncol = length(MT1_Protocol_Extracted)) %>% as.data.frame;names(MT1_Protocol_Dummy.df) = MT1_Protocol_Extracted

  Protocol_Merged_Data.list = lapply(seq_along(Protocol_Extracted_Data.list), function(i, ...){
    ith_RID.list = Protocol_Extracted_Data.list[[i]]
    ith_EPI.df = ith_RID.list[[1]]
    ith_MT1.df = ith_RID.list[[2]]

    # Merge
    ith_EPI_Merged.df = merge(ith_EPI.df, EPI_Protocol_Dummy.df, by = intersect(names(ith_EPI.df), names(EPI_Protocol_Dummy.df)), all.x = T) %>% relocate(starts_with("IMAGING.PROTOCOL"), .after=last_col())
    ith_MT1_Merged.df = merge(ith_MT1.df, MT1_Protocol_Dummy.df, by = intersect(names(ith_MT1.df), names(MT1_Protocol_Dummy.df)), all.x = T) %>% relocate(starts_with("IMAGING.PROTOCOL"), .after=last_col())

    names(ith_EPI_Merged.df) = paste0("EPI___", names(ith_EPI_Merged.df))
    names(ith_MT1_Merged.df) = paste0("MT1___", names(ith_MT1_Merged.df))




    cat("\n", crayon::green("Merging Imaging Protocol :"), crayon::red(paste0("RID ", RID[i])),"\n")

    return(cbind(ith_EPI_Merged.df, ith_MT1_Merged.df))
  })




  #=============================================================================
  # Combining
  #=============================================================================
  Combined.df = cbind(Selected_Subjects.df, do.call(rbind, Protocol_Merged_Data.list))


  return(Combined.df)
}





















