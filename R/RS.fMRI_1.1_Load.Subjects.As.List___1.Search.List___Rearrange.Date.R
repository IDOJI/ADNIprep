RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Rearrange.Date = function(Search.df){
  dates.df = Search.df %>% select(ends_with("DATE"))
  for(i in 1:ncol(dates.df)){
    dates.df[,i] = lubridate::mdy(dates.df[,i] %>% unlist) %>% as.character
  }

  selected_names = names(dates.df)
  for(j in 1:length(selected_names)){
    #j=1
    Search.df[,which_col(Search.df, selected_names[j])] = dates.df[,j]
  }

  return(Search.df)
}
