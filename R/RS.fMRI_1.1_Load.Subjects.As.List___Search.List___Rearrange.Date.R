RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Rearrange.Date = function(data.list){
  # data.list = Search_2.list


  data_New.list = lapply(data.list, function(data.df){
    #=============================================================================
    # Rearrange dates cols
    #=============================================================================
    dates = filter_by(names(data.df), "DATE", ignore.case = F)
    for(i in 1:length(dates)){
      data.df[,dates[i]] = lubridate::mdy(data.df[,dates[i]] %>% unlist) %>% as.character
    }

    #=============================================================================
    # Rearrange by RID and dates
    #=============================================================================
    data.df$RID = data.df$RID %>% as.numeric
    data.df = data.df %>% arrange(RID, STUDY.DATE)
    return(data.df)
  })


  return(data_New.list)
}
