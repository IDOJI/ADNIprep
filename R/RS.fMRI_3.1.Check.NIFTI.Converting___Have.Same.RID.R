Have.Same.RID = function(Fun_path, MT1_path){
  Fun_path = path_tail_slash(Fun_path)
  MT1_path = path_tail_slash(MT1_path)

  SB_Fun = list.files(Fun_path)
  RID_Fun = sapply(SB_Fun, FUN=function(x,...){
    # x= SB_Fun[1]
    ith_files = list.files(paste0(Fun_path, x))[1]
    return(substr(ith_files, 12, 15))
  })
  SB_Fun.df = data.frame(Sub_folder=SB_Fun,RID=RID_Fun)


  SB_MT1 = list.files(MT1_path)
  RID_MT1 = sapply(SB_MT1, FUN=function(x){
    # x= SB_Fun[1]
    ith_files = list.files(paste0(MT1_path, x))[1]
    return(substr(ith_files, 12, 15))
  })
  SB_MT1.df = data.frame(Sub_folder=SB_MT1, RID=RID_MT1)


  if(length(SB_MT1)==length(SB_Fun)){
    binded = cbind(SB_Fun.df, SB_MT1.df)
    have_same_RID = sum(SB_Fun.df$RID==SB_MT1.df$RID)==nrow(SB_Fun.df)
    have_same_folders = sum(SB_Fun.df$Sub_folder==SB_MT1.df$Sub_folder)==nrow(SB_Fun.df)

    return(list(binded, have_same_folders=have_same_folders, have_same_RID=have_same_RID))
  }else{
    return(list(Only_in_Fun=setdiff(SB_Fun, SB_MT1), Only_in_MT1=setdiff(SB_MT1, SB_Fun)))
  }
}
