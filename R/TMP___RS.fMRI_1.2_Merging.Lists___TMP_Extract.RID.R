RS.fMRI_1.2_Merging.Search.with.QC___Extract.RID = function(data.df){
  PTID = data.df$PTID
  RID = data.df$RID

  # 둘다 NA인 경우 제거
  df1 = data.df[which((is.na(PTID)+is.na(RID))!=2),]

  which_RID_na = is.na(df1$RID) %>% which

  new_RID = sapply(which_RID_na, df1, FUN=function(x,...){
    # x= which_RID_na[1]
    return(strsplit(df1[x,"PTID"], "_")[[1]][3])
  })


  df1[which_RID_na,"RID"] = new_RID
  return(df1)
}
