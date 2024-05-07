RS.fMRI_1_Data.Selection___Imaging.Protocol___Adding.Numbering.By.Manufacturers___Band.Type = function(Data.df){
  # MB description
  which_MB = grep(pattern = " MB ", x = Data.df$EPI___SEARCH___DESCRIPTION)
  if(length(which_MB)>0){
    which_SB = (1:nrow(Data.df))[-which_MB]
  }else{
    which_SB = 1:nrow(Data.df)
  }



  ### Band type

  if(length(which_MB)>0){
    Data.df$NFQ___BAND.TYPE[which_MB] = rep("MB", times=length(which_MB))
  }
  if(length(which_SB)>0){
    Data.df$NFQ___BAND.TYPE[which_SB] = rep("SB", times=length(which_SB))
  }

  return(Data.df)
}
