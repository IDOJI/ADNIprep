RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.by.RID = function(Combined.list){
  ### Combining for each manufacturer
  Combined_by_RID.list = lapply(Combined.list, FUN=function(ith_manu.list){
    # ith_manu.list = Combined.list[[1]]
    ith_manu_subjects = ith_manu.list[[1]]$Sub_folder
    ith_manu_subjects_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.by.RID___Extracting.for.Each.Manufacturer(ith_manu_subjects, ith_manu.list)

    return(ith_manu_subjects_by_RID.list)
  })
  return(Combined_by_RID.list)
}
