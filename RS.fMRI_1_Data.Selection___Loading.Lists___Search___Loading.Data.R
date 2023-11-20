RS.fMRI_1_Data.Selection___Loading.Lists___Search___Loading.Data = function(Subjects_Search,
                                                                          path_Subjects.Lists_Downloaded){
  if(grep("csv", Subjects_Search) %>% length  == 0){
    Subjects_Search = paste(Subjects_Search, ".csv", sep="")
  }

  ### 데이터 로드
  path_Search = paste(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Search, sep = "")
  Search.df = read.csv(path_Search) %>% as_tibble


  ### toupper
  names(Search.df) = names(Search.df) %>% toupper


  ### rm dup rows
  Search.df = Search.df %>% unique



  ### select research group
  Search.df = Search.df %>% filter(RESEARCH.GROUP %in% c("AD", "CN", "EMCI", "LMCI", "MCI", "SMC"))


  return(Search.df)
}



