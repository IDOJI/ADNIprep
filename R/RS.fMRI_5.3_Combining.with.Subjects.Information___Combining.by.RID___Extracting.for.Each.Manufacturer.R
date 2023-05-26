RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.by.RID___Extracting.for.Each.Manufacturer = function(ith_manu_subjects, ith_manu.list){
  ith_manu_subjects_by_RID.list = lapply(ith_manu_subjects, FUN=function(kth_subject, ...){
    # kth_subject = ith_manu_subjects[2]
    ind = which(ith_manu_subjects == kth_subject)
    kth_data.list = list(ith_manu.list[[1]][ind,])
    for(m in 2:length(ith_manu.list)){
      kth_data.list[[m]] = ith_manu.list[[m]][[ind]]
    }
    names(kth_data.list) = names(ith_manu.list)
    return(kth_data.list)
  })
  return(ith_manu_subjects_by_RID.list)
}
