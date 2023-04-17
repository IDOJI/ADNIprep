RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Band.Type = function(data.list){
  # data.list = Order_Extracted.list
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  ### Repetition Time
  EPB.df$PROTOCOL.FMRI___TR = EPB.df$PROTOCOL.FMRI___TR %>% as.numeric


  ### needed information
  MANU = EPB.df$PROTOCOL.FMRI___MANUFACTURER
  TR = EPB.df$PROTOCOL.FMRI___TR


  ### Band type
  BAND.TYPE = rep("SB", times = length(MANU))
  BAND.TYPE[which(MANU=="SIEMENS" & TR < 900)] = "MB"

  ### adding col
  EPB.df$BAND.TYPE = BAND.TYPE

  return(list(EPB = EPB.df, MT1 = MT1.df))
}
