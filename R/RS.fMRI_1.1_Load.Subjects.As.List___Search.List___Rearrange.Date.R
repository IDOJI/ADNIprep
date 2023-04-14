RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Rearrange.Date = function(data.df){
  # data.df = Search_2.df

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
}
