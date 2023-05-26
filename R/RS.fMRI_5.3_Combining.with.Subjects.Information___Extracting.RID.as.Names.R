RS.fMRI_4.3_Combining.with.Subjects.Information___Extracting.RID.as.Names = function(Combined_by_RID.list){
  Named_by_RID.list = lapply(Combined_by_RID.list, FUN=function(ith_manu){
    # ith_manu = Combined_by_RID.list[[1]]
    ith_RIDs = lapply(ith_manu, FUN=function(kth_subject){
      # kth_subject =ith_manu[[1]]
      kth_subject[[1]]$RID
    }) %>% unlist
    names(ith_manu) = ith_RIDs
    return(ith_manu)
  })
  return(Named_by_RID.list)
}
