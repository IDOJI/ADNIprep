RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.Results = function(Selected_Subjects_Lists.list, Extracted_Data.list){
  selected_names = names(Selected_Subjects_Lists.list)
  combined.list = lapply(selected_names, FUN=function(ith_name, ...){
    # ith_name = selected_names[1]
    ind = which(selected_names == ith_name)
    ith_combined = list(Selected_Subjects_Lists.list[[ind]], Extracted_Data.list[[1]][[ind]], Extracted_Data.list[[2]][[ind]])
    names(ith_combined) = c("Subject.Information", "ROI.Signals", "Functional.Connectivity")
    return(ith_combined)
  })
  names(combined.list)  = selected_names
  return(combined.list)
}
