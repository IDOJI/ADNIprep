RS.fMRI_1.2_Merging.Lists___Remove.Same.Cols = function(Combined_by_SeriesType.list){
  EPB = Combined_by_SeriesType.list[[1]]
  MT1 = Combined_by_SeriesType.list[[2]]

  ### merge Manufacturer
  Manu_Search = table(EPB$MANUFACTURER_SEARCH) %>% names
  Manu_NFQ = table(EPB$MANUFACTURER_NFQ) %>% names
  for(i in 1:length(EPB$MANUFACTURER_SEARCH)){
    EPB = change_description(EPB, "MANUFACTURER_SEARCH", from = Manu_Search[i], to = Manu_NFQ[i])
  }
  if(EPB$MANUFACTURER_SEARCH %>% is.na %>% sum == 0){
    which_na = EPB$MANUFACTURER_NFQ %>% is.na
    if(sum(EPB$MANUFACTURER_SEARCH[!which_na] == EPB$MANUFACTURER_NFQ[!which_na]) == length(EPB$MANUFACTURER_NFQ[!which_na])){
      EPB$MANUFACTURER_NFQ = NULL
      EPB = EPB %>% rename(MANUFACTURER = MANUFACTURER_SEARCH)
    }
  }

  ### merge RID
  if(EPB$RID_SEARCH %>% is.na %>% sum == 0){
    which_na = EPB$RID_NFQ %>% is.na
    if(sum(EPB$RID_SEARCH[!which_na] == EPB$RID_NFQ[!which_na]) == length(EPB$RID_SEARCH[!which_na])){
      EPB$RID_NFQ = NULL
      EPB = EPB %>% rename(RID = RID_SEARCH)
    }
  }

  ### merge study.date
  if(EPB$STUDY.DATE_NFQ %>% is.na %>% sum == 0){
    which_na = EPB$STUDY.DATE_NFQ %>% is.na

  }

}
