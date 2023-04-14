RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Dates = function(data.list){
  # data.list = RID_subjects.list
  Search_dates = union(data.list[[1]]$fMRI$STUDY.DATE, data.list[[1]]$MRI$STUDY.DATE)
  QC_dates = data.list[[2]]$SERIES_DATE

  intersect_dates = intersect(Search_dates, QC_dates)


  data.list[[1]]$fMRI = data.list[[1]]$fMRI %>% filter(STUDY.DATE %in% Search_dates)
  data.list[[1]]$MRI = data.list[[1]]$MRI %>% filter(STUDY.DATE %in% Search_dates)
  data.list[[2]] = data.list[[2]] %>% filter(SERIES_DATE %in% Search_dates )


  text = "1.1 : Subsetting by intersection Dates is done."
  cat("\n", crayon::green(text), "\n")
  return(data.list)
}
