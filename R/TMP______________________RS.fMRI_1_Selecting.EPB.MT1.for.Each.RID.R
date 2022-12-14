RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID = function(merged_Search_QC.df, what.date=what.date){
  ### making list by RID
  data_by_RID.list = as_list_by(merged_Search_QC.df, which.ID.col = "RID", arrange.by="Study.Date", is.date=T, desc=F)
  text = "1.3 : Making list by RID is done."
  cat("\n", crayon::green(text), "\n")

  ### remove having only one row
  data_more_than_one_row.list = rm_list_elements_by_nrow(data_by_RID.list, nrow=1, as.df=F)
  text = "1.3 : Removing RID with only one row is done."
  cat("\n", crayon::green(text), "\n")


  ### select date having both MT1 & EPB for each RID
  selected_date.list = dates_having(data.list = data_more_than_one_row.list,
                                    date.col = "Study.Date",
                                    criterion.col = "Series_Type",
                                    having = c("EPB", "MT1"))
  text = "1.3 : Selecting dates having both MT1 & EPB is done."
  cat("\n", crayon::green(text), "\n")


  ### select data by "what.date"
  selected_by_what.date.list = RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Select_by_what.date(selected_date.list, what.date)
  text = "1.3 : Selecting MT1 & EPB by date for each RID is done."
  cat("\n", crayon::green(text), "\n")


  ### imageID는 같지 않지만, 같은 날짜에 찍은 MRI가 2개인 경우
  one_EPB_MT1.list = RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Select.One.EPB.MT1(selected_by_what.date.list)
  text = "1.3 : Selecting unique MT1 & EPB for each RID is done."
  cat("\n", crayon::green(text), "\n")


  ### Categorizing by Manufacturer
  categorized_by_manufacturer.list = RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Categorize.by.Manufacturer(one_EPB_MT1.list)
  text = "1.3 : Categorizing by manufacturer is done."
  cat("\n", crayon::green(text), "\n")


  ### returning results
  text = paste("\n","Step 1.3 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(categorized_by_manufacturer.list)
}
