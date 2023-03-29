RS.fMRI_1.2_Merging.Lists___Merging.Search.and.QC = function(Intersection.list, what.date){
  df1 = Intersection.list[[1]]
  df2 = Intersection.list[[2]] %>% as_tibble
  df3 = Intersection.list[[3]]





  ### Date Having both MT1 & EPB in QC
  RID = df2$RID %>% unique
  Having_both_types = lapply(RID, FUN=function(ith_RID, ...){
    cat("\n", crayon::yellow("Date Having both MT1 & EPB in QC : "), crayon::bgRed( round(100 * which(RID == ith_RID)/length(RID), 4)), crayon::blue("% is done"),"\n")
    ith_df2 = df2 %>% filter(RID == ith_RID)
    ith_dates = ith_df2$STUDY.DATE %>% unique
    wheather_have_both = sapply(ith_dates, FUN=function(kth_date, ...){
      filter(ith_df2, STUDY.DATE == kth_date)$SERIES_TYPE %>% unique %>% length > 1
    })
    list(RID = ith_RID, Selected_Date = ith_dates[wheather_have_both][what.date]) %>% return
  })





  ### Filter the date for each RID
  Filtered_by_Date.list = lapply(Having_both_types, FUN=function(ith_RID_Date, ...){
    cat("\n", crayon::yellow("Filtering the date for each RID : "), crayon::bgRed(paste0("RID_", ith_RID_Date[[1]])), crayon::blue("is done"),"\n")
    ith_RID = ith_RID_Date[[1]]
    ith_Date = ith_RID_Date[[2]]
    if(!is.na(ith_Date)){
      merge(df1 %>% filter(RID == ith_RID & STUDY.DATE == ith_Date),
            df2 %>% filter(RID == ith_RID & STUDY.DATE == ith_Date), by="IMAGE_ID") %>% as_tibble %>% return

    }
  }) %>% rm_list_null()






  ### Divide by EPB & MT1
  EPB_SQ.list = lapply(Filtered_by_Date.list, FUN=function(ith_RID){
    # ith_RID = Filtered_by_Date.list[[1]]
    ith_RID %>% filter(SERIES_TYPE == "EPB")
  })
  MT1_SQ.list = lapply(Filtered_by_Date.list, FUN=function(ith_RID){
    # ith_RID = Filtered_by_Date.list[[1]]
    ith_RID %>% filter(SERIES_TYPE == "MT1")
  })
  EPB_SQ.df = do.call(rbind, EPB_SQ.list)
  MT1_SQ.df = do.call(rbind, MT1_SQ.list)







  ##############################################################################
  # EPB : renaming cols & nullify
  ##############################################################################
  EPB_SQ.df = EPB_SQ.df %>% relocate(ends_with(".x"))
  EPB_SQ.df = EPB_SQ.df %>% relocate(ends_with(".y"))
  EPB_SQ.df = EPB_SQ.df %>% relocate(starts_with("MRI"))

  if(sum(EPB_SQ.df$RID.y == EPB_SQ.df$RID.x)==nrow(EPB_SQ.df)){
    EPB_SQ.df$RID.y = NULL
    EPB_SQ.df = EPB_SQ.df %>% rename(RID = RID.x)
  }
  if(sum(EPB_SQ.df$STUDY.DATE.x == EPB_SQ.df$STUDY.DATE.y) == nrow(EPB_SQ.df)){
    EPB_SQ.df$STUDY.DATE.y = NULL
    EPB_SQ.df = EPB_SQ.df %>% rename(STUDY.DATE = STUDY.DATE.x)
  }
  EPB_SQ.df$`MRI_ACQUISITION PLANE` = NULL
  EPB_SQ.df$`MRI_MFG MODEL` = NULL
  EPB_SQ.df$`MRI_MATRIX Z` = NULL
  EPB_SQ.df$`MRI_ACQUISITION TYPE` = NULL
  EPB_SQ.df$MRI_WEIGHTING = NULL
  EPB_SQ.df$T1_ACCELERATED = NULL


  ##############################################################################
  # MT1 : renaming cols & nullify
  ##############################################################################
  MT1_SQ.df = MT1_SQ.df %>% relocate(ends_with(".x"))
  MT1_SQ.df = MT1_SQ.df %>% relocate(ends_with(".y"))
  MT1_SQ.df = MT1_SQ.df %>% relocate(starts_with("FMRI"))

  if(sum(MT1_SQ.df$RID.y == MT1_SQ.df$RID.x)==nrow(MT1_SQ.df)){
    MT1_SQ.df$RID.y = NULL
    MT1_SQ.df = MT1_SQ.df %>% rename(RID = RID.x)
  }
  if(sum(MT1_SQ.df$STUDY.DATE.x == MT1_SQ.df$STUDY.DATE.y) == nrow(MT1_SQ.df)){
    MT1_SQ.df$STUDY.DATE.y = NULL
    MT1_SQ.df = MT1_SQ.df %>% rename(STUDY.DATE = STUDY.DATE.x)
  }
  MT1_SQ.df$FMRI_TE = NULL
  MT1_SQ.df$FMRI_TR = NULL
  MT1_SQ.df$FMRI_PHASE_DIRECTION = NULL
  MT1_SQ.df$FMRI_MEAN_SNR = NULL

  return(list(EPB_QC = EPB_SQ.df, MT1_SQ = MT1_SQ.df, NFQ = df3))
}















