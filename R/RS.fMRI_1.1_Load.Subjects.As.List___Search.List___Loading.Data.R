RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Loading.Data = function(Subjects_Search_FMRI,
                                                                          Subjects_Search_MRI,
                                                                          path_Subjects.Lists_Downloaded){
  if(grep("csv", Subjects_Search_FMRI) %>% length  == 0){
    Subjects_Search_FMRI = paste(Subjects_Search_FMRI, ".csv", sep="")
  }
  if(grep("csv", Subjects_Search_MRI) %>% length  == 0){
    Subjects_Search_MRI = paste(Subjects_Search_MRI, ".csv", sep="")
  }


  ### 데이터 로드
  path_Search_FMRI = paste(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Search_FMRI, sep = "")
  path_Search_MRI = paste(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Search_MRI, sep = "")
  Search_FMRI.df = read.csv(path_Search_FMRI) %>% as_tibble
  Search_MRI.df = read.csv(path_Search_MRI) %>% as_tibble



  ### toupper
  names(Search_FMRI.df) = names(Search_FMRI.df) %>% toupper
  names(Search_MRI.df) = names(Search_MRI.df) %>% toupper


  ### rm dup rows
  Search_FMRI.df = Search_FMRI.df %>% unique
  Search_MRI.df = Search_MRI.df %>% unique


  ### select research group
  Search_FMRI.df = Search_FMRI.df %>% filter(RESEARCH.GROUP %in% c("AD", "CN", "EMCI", "LMCI", "MCI", "SMC"))
  Search_MRI.df = Search_MRI.df %>% filter(RESEARCH.GROUP %in% c("AD", "CN", "EMCI", "LMCI", "MCI", "SMC"))


  return(list(Search_FMRI.df, Search_MRI.df))
}



