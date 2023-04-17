RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Slice.Order.Info = function(data.list){
  #=============================================================================
  # Data load
  #=============================================================================
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  #=============================================================================
  # Which scanner
  #=============================================================================
  MANU = EPB.df$PROTOCOL.FMRI___MANUFACTURER
  which_Philips = grep(pattern="Philips", x = MANU,  ignore.case = T)
  which_SIEMENS = grep(pattern="SIEMENS", x = MANU,  ignore.case = F)
  which_GE      = grep(pattern="GE",      x = MANU,  ignore.case = F)


  #===========================================================================
  # Slice Order Type
  #===========================================================================
  ### create variable
  EPB.df$SLICE.ORDER.TYPE = rep(NA, nrow(EPB.df))

  ### Adding slice order info : Philips & SIEMENS
  EPB.df[which_Philips,"SLICE.ORDER.TYPE"] = "IA"
  EPB.df[-which_Philips,"SLICE.ORDER.TYPE"] = "No Need"

  data.list[[1]] = EPB.df

  return(data.list)

}
