RS.fMRI_1.2_Merging.Lists___Merging.By.Date.Having.Both.Images = function(data.list=Intersect_by_RID.list, what.date){
  #=============================================================================
  # Loading datasets
  #=============================================================================
  df1_SQ = data.list[[1]]
  df2_SQ = data.list[[2]]
  df3_SQ = data.list[[3]]
  what_RID_have_Search.QC = df1_SQ$RID %>% unique



  #=============================================================================
  # Adding words after dup colnames
  #=============================================================================
  dup_cols_SQ = intersect(names(df1_SQ), names(df2_SQ))
  dup_cols_SQ_Search = paste0(dup_cols_SQ, "_Search")
  dup_cols_SQ_QC = paste0(dup_cols_SQ, "_QC")


  df1_SQ = df1_SQ %>% rename(PHASE_SEARCH = PHASE)
  df1_SQ = df1_SQ %>% rename(MANUFACTURER_SEARCH = MANUFACTURER)
  df1_SQ = df1_SQ %>% rename(FIELD_STRENGTH_SEARCH = `FIELD STRENGTH`)

  df2_SQ = df2_SQ %>% rename(FIELD_STRENGTH_QC = FIELD_STRENGTH)

  df3_SQ = df3_SQ %>% rename(PHASE_NFQ = PHASE)
  df3_SQ = df3_SQ %>% rename(MANUFACTURER_NFQ = MANUFACTURER)





  #=============================================================================
  # Extracting dates having both MT1 & EPB from SQ2 by each RID
  #=============================================================================
  df2_SQ_listed_by_RID.list = as_list_by(df2_SQ, "RID_QC", show.progress = T)
  df2_SQ_Selected.list = list()
  df2_SQ_Selected_RID = list()
  for(i in 1:length(df2_SQ_listed_by_RID.list)){
    ith_RID.df = df2_SQ_listed_by_RID.list[[i]]
    ith_listed_by_date = as_list_by(ith_RID.df, "STUDY.DATE_QC")
    dates_having_both_MT1_EPB  = sapply(ith_listed_by_date, FUN=function(jth_date.df){
      (jth_date.df$SERIES_TYPE %>% unique %>% length) > 1
    })
    if(sum(dates_having_both_MT1_EPB)>0){
      df2_SQ_Selected.list[[i]] = ith_listed_by_date[dates_having_both_MT1_EPB]
      df2_SQ_Selected_RID[[i]] = df2_SQ_Selected.list[[i]][[1]]$RID_QC %>% unique
    }
    cat("\n", crayon::bgMagenta(paste0(i/length(df2_SQ_listed_by_RID.list) * 100, "% RID")), crayon::yellow("is done"), "\n")
  }
  df2_SQ_Selected.list = rm_list_null(df2_SQ_Selected.list)
  names(df2_SQ_Selected.list) = unlist(df2_SQ_Selected_RID)





  #=============================================================================
  # Select by "what.date"
  #=============================================================================
  df2_SQ_Selected_by_what.date.list = lapply(df2_SQ_Selected.list, FUN=function(ith_RID.list, ...){
    if(length(ith_RID.list)>=what.date){
      ith_RID.list[[what.date]] %>% return
    }
  })
  RID_Selected_by_what.date = names(df2_SQ_Selected_by_what.date.list)
  Dates_for_each_selected_RID = sapply(df2_SQ_Selected_by_what.date.list, FUN=function(ith_RID.df){
    ith_RID.df$STUDY.DATE_QC %>% unique
  })




  #=============================================================================
  # Select by "what.date" RID
  #=============================================================================
  df1_selected_by_what.date_RID.list = subset(df1_SQ, RID_SEARCH %in% RID_Selected_by_what.date) %>% as_list_by("RID_SEARCH", T)
  df3_selected_by_what.date_RID.list = subset(df3_SQ, RID_NFQ %in% RID_Selected_by_what.date) %>% as_list_by("RID_NFQ", T)





  #=============================================================================
  # Select by the "selected date"
  #=============================================================================
  df1_selected_by_date.list = list()
  df3_selected_by_date.list = list()
  for(i in 1:length(Dates_for_each_selected_RID)){
    df1_selected_by_date.list[[i]] = df1_selected_by_what.date_RID.list[[i]] %>% filter(STUDY.DATE_SEARCH == Dates_for_each_selected_RID[i])
    df3_selected_by_date.list[[i]] = df3_selected_by_what.date_RID.list[[i]] %>% filter(STUDY.DATE_NFQ == Dates_for_each_selected_RID[i])
  }
  names(df1_selected_by_date.list) = RID_Selected_by_what.date
  names(df3_selected_by_date.list) = RID_Selected_by_what.date





  #=============================================================================
  # replace NULL with NA in df3_selected_by_date.list
  #=============================================================================
  which_null = which(sapply(df3_selected_by_date.list, FUN=nrow)==0)
  cols = names(df3_selected_by_date.list[[1]])
  for(i in 1:length(which_null)){
    df3_selected_by_date.list[[which_null[i]]] = matrix((rep(NA, length(cols))),nrow=1) %>% as.data.frame
    names(df3_selected_by_date.list[[which_null[i]]]) = cols
  }




  #=============================================================================
  # Select only EPB & MT1
  #=============================================================================
  EPB.list = list()
  MT1.list = list()
  for(i in 1:length(df1_selected_by_date.list)){
    EPB.list[[i]] = bind_cols(df1_selected_by_date.list[[i]] %>% filter(MODALITY == "fMRI"),
                              df2_SQ_Selected_by_what.date.list[[i]] %>% filter(SERIES_TYPE == "EPB"),
                              df3_selected_by_date.list[[i]])

    MT1.list[[i]] = bind_cols(df1_selected_by_date.list[[i]] %>% filter(MODALITY == "MRI"),
                              df2_SQ_Selected_by_what.date.list[[i]] %>% filter(SERIES_TYPE == "MT1"))
  }
  EPB.df = do.call(rbind, EPB.list)
  MT1.df = do.call(rbind, MT1.list)




  #=============================================================================
  # Moving cols with same elements
  #=============================================================================
  EPB_1.df = EPB.df %>% dplyr::relocate(starts_with("MANUFACTURER_"))
  EPB_2.df = EPB_1.df %>% dplyr::relocate(starts_with("PHASE_"))
  EPB_3.df = EPB_2.df %>% dplyr::relocate(starts_with("STUDY.DATE_"))
  EPB_4.df = EPB_3.df %>% dplyr::relocate(starts_with("IMAGE_ID"))
  EPB_5.df = EPB_4.df %>% dplyr::relocate(starts_with("RID_"))

  MT1_1.df = MT1.df %>% dplyr::relocate(starts_with("MANUFACTURER_"))
  MT1_2.df = MT1_1.df %>% dplyr::relocate(starts_with("PHASE_"))
  MT1_3.df = MT1_2.df %>% dplyr::relocate(starts_with("STUDY.DATE_"))
  MT1_4.df = MT1_3.df %>% dplyr::relocate(starts_with("IMAGE_ID"))
  MT1_5.df = MT1_4.df %>% dplyr::relocate(starts_with("RID_"))






  #=============================================================================
  # Remove dup cols
  #=============================================================================
  rm_dup_cols_EPB.df = rm_dup_cols(EPB_5.df)
  rm_dup_cols_MT1.df = rm_dup_cols(MT1_5.df)


#   #=============================================================================
#   # Checking results
#   #=============================================================================
#   RID = sapply(Merged_by_RID_and_Date_2.list, FUN=function(x){
#     return(x[[1]]$RID)
#   })
#   if(length(RID)!=length(Merged_by_RID_and_Date_2.list)){
#     stop("Length difference!")
#   }
#   n_col = sapply(Merged_by_RID_and_Date_2.list, FUN=function(x){
#     return(x[[1]] %>% ncol)
#   })
#   if(n_col %>% unique %>% length != 1){
#     stop("There is different number of cols.")
#   }



  return(list(EPB = rm_dup_cols_EPB.df, MT1 = rm_dup_cols_MT1.df))
}
