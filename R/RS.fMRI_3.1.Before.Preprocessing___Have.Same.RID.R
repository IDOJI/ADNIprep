RS.fMRI_3.1.Before.Preprocessing___Have.Same.RID = function(manu_path){
  ##############################################################################
  # path
  ##############################################################################
  manu_path = manu_path %>% path_tail_slash
  path_Fun_Folders = list.files(manu_path, "Fun", full.names = T)
  path_MT1_Folders = list.files(manu_path, "T1", full.names = T)
  path_Folders = c(path_Fun_Folders, path_MT1_Folders)

  ##############################################################################
  # Folders
  ##############################################################################
  Fun_Folders = list.files(manu_path, "Fun")
  MT1_Folders = list.files(manu_path, "T1")
  Folders = c(Fun_Folders, MT1_Folders)


  ##############################################################################
  # The number of Sub folders
  ##############################################################################
  Each_Sub_Folders.list = lapply(path_Folders, FUN=function(ith_folder_path){
    list.files(ith_folder_path)
  })
  names(Each_Sub_Folders.list) = Folders



  ##############################################################################
  # Check the number of sub_folders of each folder pair
  ##############################################################################
  Folders

  all_combination = function(x, unique=T){
    comb = tidyr::crossing(x, x)

    if(unique){
      comb_unique = comb[comb[,1]!=comb[,2] %>% unlist,]
      ?crossing
    }


  }


  fruits <- tibble(
    type   = c("apple", "orange", "apple", "orange", "orange", "orange"),
    year   = c(2010, 2010, 2012, 2010, 2011, 2012),
    size  =  factor(
      c("XS", "S",  "M", "S", "S", "M"),
      levels = c("XS", "S", "M", "L")
    ),
    weights = rnorm(6, as.numeric(size) + 2)
  )
  fruits %>% expand(nesting(type))
  fruits %>% expand(nesting(type, size))
  fruits %>% expand(nesting(type, size, year))


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
