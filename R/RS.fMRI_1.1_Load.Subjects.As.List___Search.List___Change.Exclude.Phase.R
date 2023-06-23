RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Change.Exclude.Phase = function(data.list){
  # data.list = Search_4.list
  data_new.list = lapply(data.list, function(data.df){
    #=============================================================================
    # Remove blank
    #=============================================================================
    data.df$PHASE = gsub(pattern = " ",  replacement = "", data.df$PHASE)


    #=============================================================================
    # Exclude blanks & ADNI1
    #=============================================================================
    data.df = data.df %>% filter(PHASE != "" & PHASE != "ADNI1")

    return(data.df)

  })
  data_new.list %>% return
}
