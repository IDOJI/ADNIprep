RS.fMRI_4.3_Combining.with.Subjects.Information = function(Extracted_Data.list, path_ADNI="D:/ADNI"){
  ### path
  path_ADNI = path_ADNI %>% path_tail_slash()
  path_ADNI_Subjects = paste0(path_ADNI, "ADNI_Subjects")
  path_ADNI_RS.fMRI = paste0(path_ADNI, "ADNI_RS.fMRI")

  ### Loading subjects list
  folders = names(Extracted_Data.list[[1]])
  Subjects.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Loading.Subjects.Lists(path_ADNI_Subjects, folders)



  ### Subset results
  Selected_Subjects_Lists.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Subset.Results.by.Subjects.List(Subjects.list, Extracted_Data.list)


  ### combining results
  Combined.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.Results(Selected_Subjects_Lists.list, Extracted_Data.list)


  ### Combining by RID for each data in each manufacturer
  Combined_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.by.RID(Combined.list)


  ### Extracting RID as each name
  Named_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Extracting.RID.as.Names(Combined_by_RID.list)


  ### Combine each element
  Combined_lists = c()
  for(i in 1:length(Named_by_RID.list)){
    Combined_lists = c(Combined_lists, Named_by_RID.list[[i]])
  }


  ### sorting
  Sorted_lists = sort_list_by_names(Combined_lists, numeric=T)
  return(Sorted_lists)
}
