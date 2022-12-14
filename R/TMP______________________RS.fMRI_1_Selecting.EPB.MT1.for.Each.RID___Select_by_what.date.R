RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Select_by_what.date = function(data.list, what.date){
  # what.date = 1
  # data.list = selected_date.list

  results.list = lapply(data.list, what.date, FUN=function(x, what.date=what.date){
    # x = data.list[[100]]
    x_dates = unique(x$Study.Date) %>% sort

    ### what.date의 인덱스가 존재하는 date의 개수 이하인 경우
    if(length(x_dates)>=1 && length(x_dates)>=what.date){
      return(x[x$Study.Date == x_dates[what.date],])
    }
  })# lapply

  return(results.list %>% rm_list_null)
}
