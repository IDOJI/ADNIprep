RS.fMRI_1_Data.Selection___Loading.Lists___Search___VISCODE = function(Search.df){
  Search.df$VISCODE = NA
  Search.df = Search.df %>% relocate(VISCODE, .before = SEARCH___VISIT)





  #===========================================================================
  # ADNIGO
  #===========================================================================
  Search_ADNIGO.df = Search.df %>% filter(PHASE=="ADNIGO")
  Visits = Search_ADNIGO.df$SEARCH___VISIT
  Search_ADNIGO.df$VISCODE = ifelse(Visits == "ADNIGO Screening MRI", "scmri",
                                    ifelse(Visits == "ADNIGO Month 3 MRI", "m06",
                                           ifelse(Visits == "ADNI1/GO Month 12", "m12",
                                                  ifelse(Visits == "ADNI1/GO Month 36", "m36",
                                                         ifelse(Visits == "ADNI1/GO Month 48", "m48",
                                                                ifelse(Visits == "ADNIGO Month 60", "m60",
                                                                       ifelse(Visits == "ADNIGO Month 72", "m72", NA)))))))







  #===========================================================================
  # ADNI2
  #===========================================================================
  Search_ADNI2.df = Search.df %>% filter(PHASE=="ADNI2")
  Visits = Search_ADNI2.df$SEARCH___VISIT
  Search_ADNI2.df$VISCODE = ifelse(Visits == "ADNI2 Screening MRI-New Pt", "v02",
                                   ifelse(Visits == "ADNI2 Month 3 MRI-New Pt", "v04",
                                          ifelse(Visits == "ADNI2 Month 6-New Pt", "v05",
                                                 ifelse(Visits == "ADNI2 Initial Visit-Cont Pt", "v06",
                                                        ifelse(Visits == "ADNI2 Year 1 Visit", "v11",
                                                               ifelse(Visits == "ADNI2 Year 2 Visit", "v21",
                                                                      ifelse(Visits == "ADNI2 Year 3 Visit", "v31",
                                                                             ifelse(Visits == "ADNI2 Year 4 Visit", "v41",
                                                                                    ifelse(Visits == "ADNI2 Year 5 Visit", "v51",
                                                                                           ifelse(Visits == "ADNI2 Tau-only visit", "tau", NA))))))))))




  #===========================================================================
  # ADNI3
  #===========================================================================
  Search_ADNI3.df = Search.df %>% filter(PHASE=="ADNI3")
  Visits = Search_ADNI3.df$SEARCH___VISIT
  # table(Visits) %>% names
  Search_ADNI3.df$VISCODE = ifelse(Visits == "ADNI Screening", "sc",
                                   ifelse(Visits == "ADNI3 Initial Visit-Cont Pt", "init",
                                          ifelse(Visits == "ADNI2 Month 6-New Pt", "v05",
                                                 ifelse(Visits == "ADNI3 Year 1 Visit", "y1",
                                                        ifelse(Visits == "ADNI3 Year 2 Visit", "y2",
                                                               ifelse(Visits == "ADNI3 Year 3 Visit", "y3",
                                                                      ifelse(Visits == "ADNI3 Year 4 Visit", "y4",
                                                                             ifelse(Visits == "ADNI3 Year 5 Visit", "y5", NA))))))))


  #===========================================================================
  # binding
  #===========================================================================
  Binded.df = rbind(rbind(Search_ADNIGO.df, Search_ADNI2.df), Search_ADNI3.df) %>% arrange(RID, STUDY.DATE)


  return(Binded.df)
}
