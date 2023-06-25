RS.fMRI_1_Data.Selection___Diagnosis___Add.Dates = function(Merged_Diagnosis.list){

  Added_Dates.list = lapply(seq_along(Merged_Diagnosis.list), function(i){
    ith_RID.df = Merged_Diagnosis.list[[i]]


    ith_Date_1 = ith_RID.df$ADNIMERGE___EXAMDATE %>% as.character
    ith_Date_2 = ith_RID.df$REGISTRY___EXAMDATE %>% as.character
    ith_Date_3 = ith_RID.df$BLCHANGE___EXAMDATE %>% as.character
    ith_Date_4 = ith_RID.df$REGISTRY___USERDATE %>% as.character

    ith_Date_1[which(ith_Date_1=="")] = NA
    ith_Date_2[which(ith_Date_2=="")] = NA
    ith_Date_3[which(ith_Date_3=="")] = NA
    ith_Date_4[which(ith_Date_4=="")] = NA

    ith_New_Date = sapply(seq_along(ith_Date_1), function(k, ...){
      if(!is.na(ith_Date_1[k])){
        return(ith_Date_1[k])
      }else if(!is.na(ith_Date_2[k])){
        return(ith_Date_2[k])
      }else if(!is.na(ith_Date_3[k])){
        return(ith_Date_3[k])
      }else if(!is.na(ith_Date_4[k])){
        return(ith_Date_4[k])
      }else{
        if(is.na(ith_RID.df[k,-c(1:3)]) %>% sum == ncol(ith_RID.df[k,-c(1:3)])){
          ith_RID.df <<- ith_RID.df[-k, ]
          return(NULL)
        }
      }
    }) %>% unlist
    binded.df = cbind(EXAMDATE_NEW = ith_New_Date, ith_RID.df) %>% arrange(EXAMDATE_NEW)
    binded.df$EXAMDATE_NEW = binded.df$EXAMDATE_NEW %>% as.Date()
    return(binded.df)
  })

  return(Added_Dates.list)
}
