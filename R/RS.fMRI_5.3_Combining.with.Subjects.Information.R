RS.fMRI_4.3_Combining.with.Subjects.Information = function(Extracted_Results.list, path_Subjects="D:/ADNI/ADNI_Subjects"){
  ##############################################################################
  ### Loading subjects list
  ##############################################################################
  folders = names(Extracted_Results.list[[1]])
  Subjects.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Loading.Subjects.Lists(path_Subjects, folders)

  

  ##############################################################################
  ### Subset Subjects list
  ##############################################################################
  Selected_Subjects_Lists.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Subset.Subjects.List(Subjects.list, Extracted_Results.list)
  


  # ### combining results
  # Combined.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.Results(Selected_Subjects_Lists.list, Extracted_Data.list)
  #
  #
  # ### Combining by RID for each data in each manufacturer
  # Combined_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Combining.by.RID(Combined.list)
  #
  #
  # ### Extracting RID as each name
  # Named_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Extracting.RID.as.Names(Combined_by_RID.list)



  ##############################################################################
  ### Combining Data
  ##############################################################################
  combined.list = c(list(Selected_Subjects_Lists.list), Extracted_Results.list)
  names(combined.list)[1] = "Subjects_Information"
  
  return(combined.list)
}
