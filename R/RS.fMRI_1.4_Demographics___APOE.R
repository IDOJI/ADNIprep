RS.fMRI_1.4_Demographics___APOE = function(Data.list, path_Subejcts_APOE){
  if(grep('\\.csv', path_Subjects_APOE) %>% length > 0){
    APOE = read.csv(path_Subjects_APOE)
  }else{
    APOE = read.csv(paste0(path_Subjects_APOE, ".csv"))
  }



  # Data.list = Marriage.list
  Returned.list = lapply(seq_along(Data.list), function(i,...){
    ith_RID.df = Data.list[[i]]
    ith_RID = ith_RID.df$RID %>% na.omit %>% as.numeric %>% unique

    # APOE
    ith_APOE = ith_RID.df$ADNIMERGE___APOE4

    # only one?
    ith_Unique_APOE = ith_APOE %>% na.omit %>% as.numeric %>% unique


    if(length(ith_Unique_APOE)==1){
      ith_RID.df$ADNIMERGE___APOE4 = ith_Unique_APOE

      #=========================================================================
      # 아예 정보가 없는 경우
      #=========================================================================
    }else if(length(ith_Unique_APOE)==0){
      if(ith_RID %in% APOE$RID){

        ith_APOE.df = APOE %>% filter(RID == ith_RID)

        if(ith_APOE.df$APGEN1 == 4 && ith_APOE.df$APGEN2==4){
          ith_Unique_APOE = 2
        }else if(ith_APOE.df$APGEN1 == 4 || ith_APOE.df$APGEN2==4){
          ith_Unique_APOE = 1
        }else{
          ith_Unique_APOE = 0
        }
        ith_RID.df$ADNIMERGE___APOE4 = ith_Unique_APOE
      }
    }


    return(ith_RID.df)
  })
  cat("\n",crayon::green("Checking"), crayon::red("APOE4"), crayon::green("is done!"),"\n")
  return(Returned.list)
}
