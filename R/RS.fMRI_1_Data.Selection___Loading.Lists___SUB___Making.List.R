RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List = function(Selected_RID, Data.df){
  # Data.df =NFQ_6.df
  Dummy.df = matrix(NA, ncol = ncol(Data.df)) %>% as.data.frame
  names(Dummy.df) = names(Data.df)

  which.RID = grep("RID", names(Data.df))

  if(length(which.RID)>1){
    stop("The selected RID cols are more than one")
  }

  Data.df[ ,which.RID] = Data.df[ ,which.RID] %>% unlist %>% as.numeric

  New_Data.list = lapply(Selected_RID, function(ith_RID, ...){
    ith_Data.df = Data.df[Data.df[,which.RID]==ith_RID, ]

    if(nrow(ith_Data.df)==0){
      ith_Data.df = Dummy.df
      ith_Data.df[ ,which.RID] = ith_RID
    }

    return(ith_Data.df)
  })

  # rename list
  names(New_Data.list) = Selected_RID

  # returning
  return(New_Data.list)
}
