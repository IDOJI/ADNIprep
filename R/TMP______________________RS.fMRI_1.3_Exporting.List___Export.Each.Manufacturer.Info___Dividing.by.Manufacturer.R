RS.fMRI_1.3_Exporting.List___Export.Each.Manufacturer.Info___Dividing.by.Manufacturer = function(EPB, MT1){
  ### EPB
  Manu = EPB$MANUFACTURER %>% unique
  EPB.list = lapply(Manu, FUN=function(x){
    data.df %>% filter(MANUFACTURER==x) %>% return
  })
  names(EPB.list) = Manu


  ### MT1
  EPB_RID.list = lapply(EPB.list, FUN=function(y){
    return(y$RID)
  })
  MT1.list = lapply(EPB_RID.list, FUN=function(ith_RID,...){
    MT1 %>% dplyr::filter(RID %in% ith_RID) %>% return
  })
  names(MT1.list) = Manu


  ### check
  EPB_nrow = sapply(EPB.list, FUN=function(ith_df){
    return(ith_df %>% nrow)
  })
  MT1_nrow = sapply(MT1.list, FUN=function(ith_df){
    return(ith_df %>% nrow)
  })
  if((EPB_nrow==MT1_nrow) %>% sum  != length(EPB_nrow)){
    stop("Different rows")
  }


  ### combining
  combined.list = list()
  for(i in 1:length(EPB.list)){
    combined.list[[i]] = list(EPB.list[[i]], MT1.list[[i]])
  }
  names(combined.list) = Manu

  return(combined.list)

}
