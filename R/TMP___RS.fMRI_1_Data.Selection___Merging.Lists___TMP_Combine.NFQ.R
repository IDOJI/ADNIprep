RS.fMRI_1.2_Merging.Lists___Combine.NFQ = function(data.list=Rearranged.list,...){
  combined = data.list[[1]]
  NFQ = data.list[[2]]
  RID = NFQ$RID_NFQ
  combined.list = lapply(NFQ$RID_NFQ, FUN=function(x,...){
    cat("\n",crayon::green(paste(100*which(RID==x)/length(RID), "%")), "\n")
    # x= NFQ$RID_NFQ[1]
    ith_EPB = combined %>% dplyr::filter(RID==x) %>% filter(SERIES_TYPE=="EPB")
    ith_MT1 = combined %>% dplyr::filter(RID==x) %>% filter(SERIES_TYPE=="MT1")
    ith_NFQ = NFQ %>% dplyr::filter(RID==x)

    EPB_combined = cbind(ith_EPB, ith_NFQ)
    return(list(EPB_combined, ith_MT1))
  })


  EPB.list = lapply(combined.list, FUN=function(y,...){
    y[[1]] %>% return
  })
  MT1.list = lapply(combined.list, FUN=function(y,...){
    y[[2]] %>% return
  })

  EPB.df = do.call(rbind, EPB.list) %>% rm_dup_cols()
  MT1.df = do.call(rbind, MT1.list)

  ### rename
  EPB.df = EPB.df %>% dplyr::rename(MANUFACTURER_NFQ = MANUFACTURER.1)
  return(list(EPB.df, MT1.df))

}
