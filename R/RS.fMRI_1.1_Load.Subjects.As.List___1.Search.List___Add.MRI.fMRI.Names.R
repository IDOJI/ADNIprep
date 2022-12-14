RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Add.MRI.fMRI.Names = function(data.list){

  fMRI.df = data.list[[1]]
  MRI.df = data.list[[2]]

  ### extract names
  names_fMRI = names(fMRI.df)
  names_MRI = names(MRI.df)

  ### setdiff
  cols_only_in_fMRI = setdiff(names_fMRI, names_MRI)
  cols_only_in_MRI = setdiff(names_MRI, names_fMRI)

  ### combining data
  df = dplyr::bind_rows(fMRI.df, MRI.df)
  rownames(df) = NULL

  ### as tibble
  df = dplyr::as_tibble(df)

  ### changing names : fMRI
  for(i in 1:length(cols_only_in_fMRI)){
    df = df %>% dplyr::rename(!!paste("FMRI", cols_only_in_fMRI[i], sep="_"):=!!cols_only_in_fMRI[i])
  }


  ### changing names : MRI
  for(i in 1:length(cols_only_in_MRI)){
    df = df %>% dplyr::rename(!!paste("MRI", cols_only_in_MRI[i], sep="_"):=!!cols_only_in_MRI[i])
  }


  ### relocate cols
  df = df %>% dplyr::relocate(starts_with("FMRI_"), .after=last_col())
  df = df %>% dplyr::relocate(starts_with("MRI_"), .after=last_col())


  return(df)
}
