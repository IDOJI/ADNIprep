RS.fMRI_1_Data.Selection___Demographics___APOE = function(Data.list, path_Subejcts_APOE, Subjects_APOE){
  # Data.list = Marriage.list
  path_Subjects_APOE = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_APOE)
  if(grep('\\.csv', path_Subjects_APOE) %>% length > 0){
    APOE.df = read.csv(path_Subjects_APOE)
  }else{
    APOE.df = read.csv(paste0(path_Subjects_APOE, ".csv"))
  }



  # Data.list = Marriage.list
  Returned.list = lapply(seq_along(Data.list), function(i,...){
    # print(i)
    # i=297
    ith_RID.df = Data.list[[i]]
    ith_RID = ith_RID.df$RID %>% na.omit %>% unique
    ith_RID.df$APOE4 = NA
    ith_RID.df = ith_RID.df %>% relocate(APOE4)

    # Extract APOE
    ith_APOE_1 = ith_RID.df$APOE.A1 %>% na.omit() %>% as.numeric() %>% unique()
    ith_APOE_2 = ith_RID.df$APOE.A2 %>% na.omit() %>% as.numeric() %>% unique()
    if(length(ith_APOE_1)==1 || length(ith_APOE_2)==1){
      ith_Selected_APOE = APOE.df %>% filter(RID == ith_RID )
      if(nrow(ith_Selected_APOE)>0){
        ith_APOE_1 = ith_Selected_APOE$APGEN1 %>% na.omit %>% unique %>% as.numeric
        ith_APOE_2 = ith_Selected_APOE$APGEN2 %>% na.omit %>% unique %>% as.numeric
      }
    }


    # Decide
    if(length(ith_APOE_1)==1 && length(ith_APOE_2)==1){
      ith_RID.df$APOE.A1 = ith_APOE_1
      ith_RID.df$APOE.A2 = ith_APOE_2

      ith_APOE4 = ifelse(ith_APOE_1 != 4 && ith_APOE_2 != 4, 0,
                         ifelse(ith_APOE_1 == 4 && ith_APOE_2 == 4, 2, 1))

      if(unique(ith_RID.df$ADNIMERGE___APOE4 %>% na.omit)==ith_APOE4){
        ith_RID.df$APOE4 = ith_APOE4
        ith_RID.df$ADNIMERGE___APOE4 = NULL
      }else{
        stop("Check APOE4")
      }
    }else{
      ith_RID.df$APOE.A1 = NA
      ith_RID.df$APOE.A2 = NA
      ith_RID.df$ADNIMERGE___APOE4 = NULL
    }
    return(ith_RID.df)
  })
  cat("\n",crayon::green("Checking"), crayon::red("APOE4"), crayon::green("is done!"),"\n")
  return(Returned.list)
}











