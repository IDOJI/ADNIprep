RS.fMRI_1.2_Merging.Lists___Merging.With.NFQ = function(Merging_Search_and_QC.list){
  EPB = Merging_Search_and_QC.list[[1]]
  MT1 = Merging_Search_and_QC.list[[2]]
  NFQ = Merging_Search_and_QC.list[[3]]


  #===========================================================================
  # Merging EPB & NFQ
  #===========================================================================
  RID = EPB$RID
  Dates = EPB$STUDY.DATE
  EPB.list = list()
  for(i in 1:length(RID)){
    ith_RID_NFQ = NFQ[NFQ$RID==RID[i] & NFQ$STUDY.DATE == Dates[i],]
    if(nrow(ith_RID_NFQ) != 0){
      EPB.list[[i]] = merge(EPB %>% filter(RID==RID[i]), ith_RID_NFQ, by = "RID")
    }else{
      ith_RID_NFQ = rep(NA, ncol(NFQ)) %>% matrix(nrow=1) %>% as.data.frame
      names(ith_RID_NFQ) = names(NFQ)
      ith_RID_NFQ$STUDY.DATE = EPB[i,]$STUDY.DATE
      ith_RID_NFQ$PHASE = EPB[i,]$PHASE
      ith_RID_NFQ$RID = EPB[i,]$RID
      EPB.list[[i]] = merge(EPB[i,], ith_RID_NFQ, by = "RID")
    }
    cat("\n", crayon::yellow("Merging EPB & NFQ : "), crayon::bgRed( round(100 * which(RID == RID[i])/length(RID), 4)), crayon::blue("% is done"),"\n")
  }
  EPB_NFQ.df = do.call(rbind, EPB.list) %>% as_tibble()




  #===========================================================================
  # EPB : rm cols
  #===========================================================================
  EPB_RmCols.df = EPB_NFQ.df
  EPB_RmCols.df = EPB_RmCols.df %>% relocate(ends_with(".x"))
  EPB_RmCols.df = EPB_RmCols.df %>% relocate(ends_with(".y"))
  EPB_RmCols.df = EPB_RmCols.df %>% relocate(starts_with("MANUFACTURER"))
  EPB_RmCols.df = EPB_RmCols.df %>% relocate(starts_with("PHASE"))
  if(sum(EPB_RmCols.df$STUDY.DATE.y == EPB_RmCols.df$STUDY.DATE.x) == nrow(EPB_RmCols.df)){
    EPB_RmCols.df$STUDY.DATE.y = NULL
    EPB_RmCols.df = EPB_RmCols.df %>% rename(STUDY.DATE = STUDY.DATE.x)
  }
  EPB_RmCols.df = EPB_RmCols.df %>% relocate(c("RID", "STUDY.DATE", "IMAGE_ID"))
  EPB_RmCols.df$MANUFACTURER.y = NULL
  EPB_RmCols.df = EPB_RmCols.df %>% rename(MANUFACTURER = MANUFACTURER.x)

  if(EPB_RmCols.df$PHASE.y %>% is.na %>% sum == 0 && EPB_RmCols.df$PHASE.x %>% is.na %>% sum == 0){
    EPB_RmCols.df$PHASE.y = NULL
    EPB_RmCols.df = EPB_RmCols.df %>% rename(PHASE = PHASE.x)
  }

  # description
  EPB_RmCols.df$DESCRIPTION = NULL
  MT1$DESCRIPTION == NULL

  return(list(EPB = EPB_RmCols.df, MT1 = MT1))
}
