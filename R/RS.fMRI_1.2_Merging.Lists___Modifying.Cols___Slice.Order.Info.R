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



  #=============================================================================
  # Which MB
  #=============================================================================
  which_MB = grep(pattern = " MB ", EPB.df$SERIES_DESCRIPTION)
  which_SB = which(EPB.df$RID %in% as.numeric(unlist(EPB.df[-which_MB,"RID"])))



  #===========================================================================
  # Slice Order Type
  #===========================================================================
  ### create variable
  EPB.df$SLICE.ORDER.TYPE = rep(NA, nrow(EPB.df))


  ### Multi Band (MB)
  if(length(which_MB)>0){
    EPB.df[which_MB,"SLICE.ORDER.TYPE"] = "No Need (MB)"
    SB_Slice.Order = EPB.df$SLICE.ORDER[-which_MB]
  }else{
    SB_Slice.Order = EPB.df$SLICE.ORDER
  }



  ### SB Slice order Type
  SB_Slice.Order.Type = sapply(SB_Slice.Order, function(k){
    if(!is.na(k)){
      k_splitted_order = strsplit(k, split = "    ")[[1]] %>% as.numeric

      is.IA = unique(k_splitted_order[1:3] == c(1,3,5))
      is.IA2 = unique(k_splitted_order[1:3] == c(2,4,6))


      if(is.IA){
        return("IA")
      }else if(is.IA2){
        return("IA2")
      }else{
        return("DUNNO")
      }
    }else{
      return(NA)
    }
  })


  if(length(which_MB)>0){
    EPB.df[-which_MB, "SLICE.ORDER.TYPE"] = SB_Slice.Order.Type
  }else{
    EPB.df[, "SLICE.ORDER.TYPE"] = SB_Slice.Order.Type
  }




  #===========================================================================
  # Return
  #===========================================================================
  data.list[[1]] = EPB.df

  return(data.list)

}
