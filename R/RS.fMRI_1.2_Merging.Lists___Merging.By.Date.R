RS.fMRI_1.2_Merging.Lists___Merging.By.Date = function(data.list=Intersect_by_RID.list, what.date){
  #=============================================================================
  # Loading datasets
  #=============================================================================
  df1_SQ = data.list[[1]]
  df2_SQ = data.list[[2]]
  df3_SQ = data.list[[3]]
  what_RID_have_Search.QC = df1_SQ$RID %>% unique


  #=============================================================================
  # Change date name
  #=============================================================================
  df2_SQ = df2_SQ %>% dplyr::rename(STUDY.DATE=SERIES_DATE)
  df3_SQ = df3_SQ %>% dplyr::rename(STUDY.DATE=SCANDATE)



  #=============================================================================
  # Merging by date & RID
  #=============================================================================
  Merged_by_RID_and_Date.list = lapply(what_RID_have_Search.QC, FUN=function(ith_RID, ...){
    # ith_RID = what_RID_have_Search.QC[1]
    text0 = crayon::yellow("Merging by dates : ")
    text1 = crayon::blue("RID")
    text2 = crayon::bgMagenta(ith_RID)
    text3 = crayon::blue("is done")
    text4 = paste0("( ", round(100 * which(what_RID_have_Search.QC==ith_RID)/length(what_RID_have_Search.QC), 4), "% )")
    cat("\n", text0, text1, text2, text3, text4, "\n")


    #=============================================================================
    # selecting ith QC
    #=============================================================================
    ith_QC = df2_SQ %>% dplyr::filter(RID==ith_RID)



    #=============================================================================
    # Dates having both MT1 & EPB
    #=============================================================================
    ith_dates = ith_QC$STUDY.DATE %>% unique %>% sort
    each_n_rows = sapply(ith_dates, FUN=function(kth_date,...){
      dplyr::filter(ith_QC, STUDY.DATE==kth_date)[,"SERIES_TYPE"] %>% unlist %>% unique %>% length %>% return
    })
    what_dates_have_both = ith_dates[each_n_rows==2]


    #=============================================================================
    # Selecting a date by what.date
    #=============================================================================
    if(length(what_dates_have_both) >= what.date){
      ith_QC     = ith_QC %>% dplyr::filter(STUDY.DATE == what_dates_have_both[what.date])
      ith_SEARCH = df1_SQ %>% dplyr::filter(STUDY.DATE == what_dates_have_both[what.date] & RID==ith_RID)
      ith_NFQ    = df3_SQ %>% dplyr::filter(STUDY.DATE == what_dates_have_both[what.date] & RID==ith_RID)
      ith_SQ     = dplyr::full_join(ith_SEARCH, ith_QC, by = c("IMAGE_ID", "STUDY.DATE"), suffix = c("_SEARCH", "_QC"))

      ith_EPB = ith_SQ %>% dplyr::filter(SERIES_TYPE == "EPB")
      ith_MT1 = ith_SQ %>% dplyr::filter(SERIES_TYPE == "MT1")
      if(nrow(ith_NFQ)==0){
        NFQ_names          = c("PHASE", "RID", "STUDY.DATE", "VISCODE","VISCODE2","SERIESTIME", "MANUFACTURER", "MANUFACTURERSMODELNAME", "REPETITIONTIME","SOFTWAREVERSIONS","NFQ","OVERALLQC", "SLICE.TIMING_RAW","SLICE.TIMING_MIN", "SLICE.TIMING_ORDER")
        ith_NFQ            = matrix(NA, 1, length(NFQ_names)) %>% as.data.frame
        names(ith_NFQ)     = NFQ_names
        ith_NFQ$RID        = ith_RID
        ith_NFQ$STUDY.DATE = ith_EPB$STUDY.DATE[1]
      }
      ith_EPB_NFQ = dplyr::full_join(ith_EPB, ith_NFQ, by="STUDY.DATE", suffix = c("_SQ", "_NFQ"))
      return(list(ith_EPB_NFQ, ith_MT1))
    }
  })
  Merged_by_RID_and_Date_2.list = Merged_by_RID_and_Date.list %>% rm_list_null


  #=============================================================================
  # Checking results
  #=============================================================================
  RID = sapply(Merged_by_RID_and_Date_2.list, FUN=function(x){
    return(x[[1]]$RID)
  })
  if(length(RID)!=length(Merged_by_RID_and_Date_2.list)){
    stop("Length difference!")
  }
  n_col = sapply(Merged_by_RID_and_Date_2.list, FUN=function(x){
    return(x[[1]] %>% ncol)
  })
  if(n_col %>% unique %>% length != 1){
    stop("There is different number of cols.")
  }



  #=============================================================================
  #
  #=============================================================================
  return(Merged_by_RID_and_Date_2.list)
}
