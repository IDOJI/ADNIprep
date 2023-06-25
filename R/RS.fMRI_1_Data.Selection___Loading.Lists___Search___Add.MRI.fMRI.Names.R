RS.fMRI_1_Data.Selection___Loading.Lists___Search___Add.MRI.fMRI.Names = function(Search_2.list){
  fMRI.df = Search_2.list[[1]]
  MRI.df = Search_2.list[[2]]

  ### extract names
  names_fMRI = names(fMRI.df)
  names_MRI = names(MRI.df)


  ### intersect
  # cols_intersection = intersect(names_fMRI, names_MRI)


  ### adding FMRI/MRI
  selected_cols = c("MODALITY", "IMAGE.ID", "DESCRIPTION", "ARCHIVE.DATE")
  for(i in 1:length(selected_cols)){
    fMRI.df = change_colnames(data.df = fMRI.df, from = selected_cols[i], paste0("FMRI___", selected_cols[i]))
    MRI.df = change_colnames(data.df = MRI.df, from = selected_cols[i], paste0("MRI___", selected_cols[i]))
  }



  ### intersect
  # cols_intersection = intersect(names(fMRI.df), names(MRI.df))

  return(list(fMRI = fMRI.df, MRI = MRI.df))
}
