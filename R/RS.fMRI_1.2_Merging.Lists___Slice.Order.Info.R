RS.fMRI_1.2_Merging.Lists___Slice.Order.Info = function(data.list=Combined_by_SeriesType.list){

  ### Data load
  EPB = data.list[[1]]
  MT1 = data.list[[2]]


  ### merge Manufacturer
  EPB$MANUFACTURER_NFQ = NULL
  EPB = EPB %>% dplyr::rename(MANUFACTURER = MANUFACTURER_SQ)

  ### variables
  MANU             = EPB$MANUFACTURER
  SLICE.ORDER.INFO = EPB$SLICE.TIMING_ORDER


  ### which scanner
  which_Philips = grep(pattern="Philips", x = MANU,  ignore.case = T)
  which_SIEMENS = grep(pattern="SIEMENS", x = MANU,  ignore.case = F)
  which_GE      = grep(pattern="GE",      x = MANU,  ignore.case = F)


  #===========================================================================
  # Slice Order Type
  #===========================================================================
  ### create variable
  EPB$SLICE.ORDER.TYPE = rep(NA, nrow(EPB))

  ### Adding slice order info : Philips & SIEMENS
  EPB[which_Philips,"SLICE.ORDER.TYPE"] = "IA"
  EPB[c(which_SIEMENS, which_GE),"SLICE.ORDER.TYPE"] = "No Need"

  return(list(EPB, MT1))

}
