RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Loading.Data = function(subjects_search_fMRI, subjects_search_MRI, path_Subjects_Downloaded){
  if(grep("csv", subjects_search_fMRI) %>% length  == 0){
    subjects_search_fMRI = paste(subjects_search_fMRI, ".csv", sep="")
  }
  if(grep("csv", subjects_search_MRI) %>% length  == 0){
    subjects_search_MRI = paste(subjects_search_MRI, ".csv", sep="")
  }

  ### 데이터 로드
  path_search_fMRI = paste(path_Subjects_Downloaded, subjects_search_fMRI, sep = "")
  path_search_MRI = paste(path_Subjects_Downloaded, subjects_search_MRI, sep = "")
  fMRI = read.csv(path_search_fMRI)
  MRI = read.csv(path_search_MRI)


  ### toupper
  names(fMRI) = names(fMRI) %>% toupper
  names(MRI) = names(MRI) %>% toupper


  ### tibble
  fMRI = dplyr::as_tibble(fMRI)
  MRI = dplyr::as_tibble(MRI)


  ### rm dup rows
  fMRI = unique(fMRI)
  MRI = unique(MRI)

  return(list(fMRI, MRI))
}

