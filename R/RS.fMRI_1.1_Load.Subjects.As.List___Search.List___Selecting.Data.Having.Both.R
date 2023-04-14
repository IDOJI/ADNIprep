RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Selecting.Data.Having.Both = function(data.list){
  # data.list = Search_7.list

  #=====================================================================================================
  # Intersect by STUDY.DATE for each RID
  #=====================================================================================================
  unique_RID = unique(data.list[[1]]$RID)
  Subjects_intersect_by_dates.list = lapply(unique_RID, FUN=function(ith_RID, ...){
    cat("\n",crayon::green("RID"), crayon::bgMagenta(ith_RID), crayon::green("is selected by STUDY.DATE") ,"\n")
    ith_RID_fMRI.df = data.list[[1]] %>% filter(RID == ith_RID)
    ith_RID_MRI.df = data.list[[2]] %>% filter(RID == ith_RID)


    ith_intersect_dates = intersect(ith_RID_fMRI.df$STUDY.DATE, ith_RID_MRI.df$STUDY.DATE)
    list(EPI = ith_RID_fMRI.df %>% filter(STUDY.DATE  %in% ith_intersect_dates),
         MT1 = ith_RID_MRI.df %>% filter(STUDY.DATE  %in% ith_intersect_dates))
  })
  names(Subjects_intersect_by_dates.list) = unique_RID
  Subjects_intersect_by_dates.list = Subjects_intersect_by_dates.list %>% rm_list_null()



  #=====================================================================================================
  # Extract fMRI
  #=====================================================================================================
  fMRI.list = lapply(Subjects_intersect_by_dates.list, FUN=function(ith_RID){
    ith_RID[[1]]
  })
  MRI.list = lapply(Subjects_intersect_by_dates.list, FUN=function(ith_RID){
    ith_RID[[2]]
  })


  return(list(fMRI = do.call(rbind, fMRI.list), MRI = do.call(rbind, MRI.list)))
}
