RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Band.Type = function(data.list){
  # data.list = Order_Extracted.list
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  # MB description
  which_MB = grep(pattern = " MB ", x = EPB.df$DESCRIPTION)
  which_SB = (1:nrow(EPB.df))[-which_MB]


  ### Band type
  EPB.df$BAND.TYPE = NA
  EPB.df[which_MB, "BAND.TYPE"] = rep("MB", times=length(which_MB))
  EPB.df[which_SB, "BAND.TYPE"] = rep("MB", times=length(which_SB))


  return(list(EPB = EPB.df, MT1 = MT1.df))
}
