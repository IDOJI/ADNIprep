RS.fMRI_4.3_Combining.with.Subjects.Information___Subset.Subjects.List = function(Subjects.list, Extracted_Results.list){
  ##############################################################################
  # Selected subjects
  ##############################################################################
  selected_Sub.list = lapply(Extracted_Results.list[[1]], FUN=function(ith_manu, ...){
    names(ith_manu)
  })


  ##############################################################################
  # subset by selected Subs
  ##############################################################################
  for(i in 1:length(selected_Sub.list)){
    Subjects.list[[i]] = Subjects.list[[i]][Subjects.list[[i]]$Sub_folder %in% selected_Sub.list[[i]], ]
  }

  return(Subjects.list)
}


