RS.fMRI_1.3_Exporting.Lists___Combine.by.Manufacturer = function(data.list){
  #===============================================================================
  # Data load
  #===============================================================================
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  #===============================================================================
  # Split EPB by Manufacturer
  #===============================================================================
  EPB.list = list()
  EPB.list[[1]] = EPB_Manu_SIEMENS.SB.df = EPB.df %>% filter(PROTOCOL.FMRI___MANUFACTURER == "SIEMENS" & FMRI___SLICE.BAND.TYPE == "SB")
  EPB.list[[2]] = EPB_Manu_SIEMENS.MB.df = EPB.df %>% filter(PROTOCOL.FMRI___MANUFACTURER == "SIEMENS" & FMRI___SLICE.BAND.TYPE == "MB")
  EPB.list[[3]] = EPB_Manu_Philips.df    = EPB.df[grep("Philips", EPB.df$PROTOCOL.FMRI___MANUFACTURER), ]
  EPB.list[[4]] = EPB_Manu_GE.MEDICAL.df = EPB.df[grep("GE.MEDICAL", EPB.df$PROTOCOL.FMRI___MANUFACTURER), ]
  EPB.list[[5]] = EPB_Manu_Non.df        = EPB.df %>% filter(PROTOCOL.FMRI___MANUFACTURER %>% is.na)





  #===============================================================================
  # Select MT1
  #===============================================================================
  MT1.list = list()
  MT1.list[[1]] = MT1_Manu_SIEMENS.SB.df = MT1.df %>% filter(RID %in% EPB_Manu_SIEMENS.SB.df$RID)
  MT1.list[[2]] = MT1_Manu_SIEMENS.MB.df = MT1.df %>% filter(RID %in% EPB_Manu_SIEMENS.MB.df$RID)
  MT1.list[[3]] = MT1_Manu_Philips.df    = MT1.df %>% filter(RID %in% EPB_Manu_Philips.df$RID)
  MT1.list[[4]] = MT1_Manu_GE.MEDICAL.df = MT1.df %>% filter(RID %in% EPB_Manu_GE.MEDICAL.df$RID)
  MT1.list[[5]] = MT1_Manu_Non.df        = MT1.df %>% filter(RID %in% EPB_Manu_Non.df$RID)






  #===============================================================================
  # Numbering
  #===============================================================================
  for(i in 1:length(EPB.list)){
    data.df = EPB.list[[i]]
    Sub_Num = paste0("Sub_", fit_length(1:nrow(data.df), 3))
    File_Names = paste0(data.df$PROTOCOL.FMRI___MANUFACTURER,"_", data.df$FMRI___SLICE.BAND.TYPE,  "___", "RID_", fit_length(data.df$RID, 4), "___", Sub_Num)
    EPB.list[[i]] = cbind(Sub_Num, File_Names, data.df) %>% as_tibble
  }




  #===============================================================================
  # Combining
  #===============================================================================
  combined.list = list()
  for(i in 1:length(EPB.list)){
    combined.list[[i]] = list(EPB = EPB.list[[i]], MT1 = MT1.list[[i]])
  }
  names(combined.list) = c("SIEMENS_SB", "SIEMENS_MB", "Philips", "GE.MEDICAL.SYSTEMS", "Non")

  return(combined.list)
}
