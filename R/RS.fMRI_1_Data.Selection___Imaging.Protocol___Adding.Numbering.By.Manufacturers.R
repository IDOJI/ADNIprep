RS.fMRI_1_Data.Selection___Imaging.Protocol___Adding.Numbering.By.Manufacturers = function(Combined.df){
  #=============================================================================
  # Arranging by Manufacturer and RID
  #=============================================================================
  Combined.df$RID = Combined.df$RID %>% as.numeric
  Combined.df$EPI___IMAGING.PROTOCOL___Manufacturer = ifelse(Combined.df$EPI___IMAGING.PROTOCOL___Manufacturer == "SIEMENS", "SIEMENS",
                                                             ifelse(Combined.df$EPI___IMAGING.PROTOCOL___Manufacturer == "GE MEDICAL SYSTEMS", "GE.MEDICAL.SYSTEMS", "Philips"))


  #=============================================================================
  # Bandtype
  #=============================================================================
  Combined.df = RS.fMRI_1_Data.Selection___Imaging.Protocol___Adding.Numbering.By.Manufacturers___Band.Type(Data.df = Combined.df)
  Combined.df$MANUFACTURER_NEW = paste0(Combined.df$EPI___IMAGING.PROTOCOL___Manufacturer, "_", Combined.df$NFQ___BAND.TYPE)



  #=============================================================================
  # 3.Adding Numbering A Col by Manufacturers
  #=============================================================================
  Manu = Combined.df$MANUFACTURER_NEW %>% unique
  New_Merged.list = lapply(Manu, FUN=function(ith_Manu, ...){
    ith_Combined.df = Combined.df %>% filter(MANUFACTURER_NEW == ith_Manu)
    ith_Sub_Num = paste0("Sub_", fit_length(1:nrow(ith_Combined.df), 3))
    ith_MT1_ID = ith_Combined.df$MT1___IMAGE_ID
    ith_EPI_ID = ith_Combined.df$EPI___IMAGE_ID

    File_Names = paste0(ith_Combined.df$MANUFACTURER_NEW, "___", ith_Sub_Num, "___", "RID_", fit_length(ith_Combined.df$RID, 4), "___", "EPI_", ith_EPI_ID, "___", "MT1", "_", ith_MT1_ID)
    cbind(File_Names, ith_Combined.df) %>% as_tibble() %>% return()
  })
  New_Combined.df = do.call(rbind, New_Merged.list)



  cat("\n", crayon::bgMagenta("STEP 1.4"), crayon::green("Adding Numbering and Filenames is done!"), "\n")
  return(New_Combined.df)
}




#
# #===========================================================================
# # Bandtype
# #===========================================================================
# Band.Type.list = RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Band.Type(Order_Extracted.list)




#===========================================================================
# Slice Order Info
#===========================================================================
# Order_Extracted.list = RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Slice.Order.Info(data.list)

