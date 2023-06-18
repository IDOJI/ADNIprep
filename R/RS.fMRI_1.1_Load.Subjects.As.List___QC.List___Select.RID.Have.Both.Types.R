RS.fMRI_1.1_Load.Subjects.As.List___QC.List___Select.RID.Have.Both.Types = function(QC.df, what.date){
  # QC.df = QC_8.df
  #===========================================================================
  # 1) Remove RIDs which don't have either type
  #===========================================================================
  RID = QC.df$RID %>% unique()
  selected_RID = sapply(RID, FUN=function(ith_RID, ...){
    if(QC.df %>% filter(RID ==ith_RID) %>% select(SERIES_TYPE) %>% unlist %>% unique %>% length == 2){
      return(ith_RID)
    }
  }) %>% unlist
  if(length(selected_RID)==0){
    stop("There is no RID having both MT1 & EPB")
  }
  QC_1.df = QC.df %>% filter(RID %in% selected_RID)





  #===========================================================================
  # Select dates having EPB for each RID
  #===========================================================================
  RID = QC_1.df$RID %>% unique
  Having_Both_Type_QC.list = lapply(RID, FUN=function(ith_RID, ...){
    ith_EPB_dates = QC_1.df %>% filter(RID == ith_RID & SERIES_TYPE == "EPB") %>% select(SERIES_DATE) %>% unlist
    ith_MT1_dates = QC_1.df %>% filter(RID == ith_RID & SERIES_TYPE == "MT1" & SERIES_DATE %in% ith_EPB_dates) %>% select(SERIES_DATE) %>% unlist
    cat("\n", crayon::yellow("QC_RID :"), crayon::bgRed(ith_RID), crayon::yellow("is being selected by dates"),"\n")
    if(!is.na(ith_MT1_dates[what.date])){
      QC_1.df %>% filter(RID == ith_RID & SERIES_DATE %in% ith_MT1_dates[what.date])
    }
  }) %>% rm_list_null()




  #===========================================================================
  # Naming with RID
  #===========================================================================
  names(Having_Both_Type_QC.list) = sapply(Having_Both_Type_QC.list, FUN=function(ith_RID.df){
    ith_RID.df$RID %>% unique
  })




  #===========================================================================
  # Having only 2 rows?
  #===========================================================================
  if(length(Having_Both_Type_QC.list)>0){
    nrows_are_2 = sapply(Having_Both_Type_QC.list, nrow) %>% table %>% length == 1
    if(!nrows_are_2){
      stop("There are selected data with more than 2 rows")
    }
  }



  #===========================================================================
  # Split by SERIES_TYPE
  #===========================================================================
  EPB.list = lapply(Having_Both_Type_QC.list, FUN=function(ith_RID){
    ith_RID %>% filter(SERIES_TYPE == "EPB")
  })
  MT1.list = lapply(Having_Both_Type_QC.list, FUN=function(ith_RID){
    ith_RID %>% filter(SERIES_TYPE == "MT1")
  })

  return(list(QC_EPB = EPB.list, QC_MT1 = MT1.list))
}
