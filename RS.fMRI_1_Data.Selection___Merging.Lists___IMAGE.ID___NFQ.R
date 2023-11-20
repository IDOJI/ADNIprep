RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID___NFQ = function(QC.list, NFQ.list){
  Dummy.df = matrix(NA, nrow=1, ncol = ncol(NFQ.list[[1]])) %>% as.data.frame
  names(Dummy.df) = names(NFQ.list[[1]])


  Merged.list = lapply(seq_along(QC.list), function(i,...){
    ith_QC.df = QC.list[[i]];cat("\n", crayon::green("Merging with NFQ : "), crayon::red(paste0("RID_", ith_QC.df$RID)) ,"\n")
    ith_NFQ.df = NFQ.list[[i]] %>% filter(SCANDATE==ith_QC.df$SERIES_DATE)
    if(nrow(ith_NFQ.df)==0){
      ith_NFQ.df = Dummy.df
      ith_NFQ.df$RID = ith_QC.df$RID
      ith_NFQ.df$SCANDATE= ith_QC.df$SERIES_DATE
    }

    merge(ith_QC.df, ith_NFQ.df, by = intersect(names(ith_QC.df), names(ith_NFQ.df)), all = T) %>% relocate(c("PHASE_NFQ","SCANDATE","VISCODE", "VISCODE2"), .after = SERIES_DATE) %>% rename(PHASE = PHASE_NFQ)

  })
  return(Merged.list)
}
