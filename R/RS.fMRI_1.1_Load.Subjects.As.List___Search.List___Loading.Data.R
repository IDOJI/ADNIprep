RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Loading.Data = function(subjects_search, path_Subjects.Lists.Downloaded){
  if(grep("csv", subjects_search) %>% length  == 0){
    subjects_search = paste(subjects_search, ".csv", sep="")
  }
  ### 데이터 로드
  path_search = paste(path_Subjects.Lists.Downloaded, subjects_search, sep = "")
  search = read.csv(path_search) %>% as_tibble

  ### toupper
  names(search) = names(search) %>% toupper


  ### rm dup rows
  search = unique(search)


  ### select research group
  search = search %>% filter(RESEARCH.GROUP %in% c("AD", "CN", "EMCI", "LMCI", "MCI", "SMC"))


  return(search)
}

