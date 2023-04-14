RS.fMRI_1.2_Merging.Lists___Adding.Cols___Band.Type = function(data.list){
  # data.list = Slice.Order.Type_Extracted.list
  EPB = data.list[[1]]


  MANU = EPB$FMRI___MANUFACTURER
  TR = EPB$FMRI___TR %>% as.numeric
  BAND.TYPE = rep("SB", times = length(MANU))

  BAND.TYPE[which(MANU=="SIEMENS" & TR < 800)] = "MB"

  EPB$BAND.TYPE = BAND.TYPE

  data.list[[1]] = EPB
  return(data.list)

}
