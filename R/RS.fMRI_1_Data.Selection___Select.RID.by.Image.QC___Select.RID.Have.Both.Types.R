RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Select.RID.Have.Both.Types = function(QC.df, what.date){
  # QC.df = QC_8.df
  #===========================================================================
  # 1) Remove RIDs which don't have either type
  #===========================================================================
  RID = QC.df$RID %>% unique()
  selected_RID = sapply(RID, FUN=function(ith_RID, ...){
    ith_Types = QC.df %>% filter(RID ==ith_RID) %>% select(IMAGING.PROTOCOL___SERIES_TYPE) %>% unlist %>% unique
    ith_have_both = c("EPB", "MT1") %in% ith_Types
    if(sum(ith_have_both)>1){
      return(ith_RID)
    }
  }) %>% unlist %>% unname %>% as.numeric
  if(length(selected_RID)==0){
    stop("There is no RID having both MT1 & EPB")
  }
  QC_New.df = QC.df %>% filter(RID %in% selected_RID)
  QC.df %>% filter(RID==6956)




  #===========================================================================
  # Select dates having EPB for each RID
  #===========================================================================
  RID = QC_New.df$RID %>% unique
  Having_Both_Type_QC.list = lapply(seq_along(RID), FUN=function(i, ...){
    ith_RID = RID[i]
    ith_RID.df = QC_New.df %>% filter(RID == ith_RID)

    ith_RID_EPI = ith_RID.df %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "EPB")
    ith_RID_MT1 = ith_RID.df %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "MT1")


    ith_EPB_Dates = ith_RID_EPI$SERIES_DATE
    ith_MT1_Dates = ith_RID_MT1$SERIES_DATE
    ith_Intersection_Date = intersect(ith_EPB_Dates, ith_MT1_Dates)[what.date]

    cat("\n", crayon::yellow("QC_RID :"), crayon::bgRed(ith_RID), crayon::yellow("is being selected by dates"),"\n")

    if(!is.na(ith_Intersection_Date)){
      ith_RID.df %>% filter(SERIES_DATE == ith_Intersection_Date)
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
  EPB.list = lapply(Having_Both_Type_QC.list, FUN=function(ith_RID.df){
    ith_RID.df %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "EPB")
  })
  MT1.list = lapply(Having_Both_Type_QC.list, FUN=function(ith_RID){
    ith_RID %>% filter(IMAGING.PROTOCOL___SERIES_TYPE == "MT1")
  })




  return(list(QC_EPB = EPB.list, QC_MT1 = MT1.list))
}


















