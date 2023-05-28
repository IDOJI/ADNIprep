RS.fMRI_1.2_Merging.Lists___Modifying.Cols = function(data.list){
  # data.list = Protocol_Splitted.list
  #=============================================================================
  # Data load
  #=============================================================================
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  #=============================================================================
  # names to upper
  #=============================================================================
  names(EPB.df) = names(EPB.df) %>% toupper
  names(MT1.df) = names(MT1.df) %>% toupper



  #=============================================================================
  # Manufacturer
  #=============================================================================
  MT1.df$PROTOCOL.MRI___MANUFACTURER = gsub(" ", ".", MT1.df$PROTOCOL.MRI___MANUFACTURER)
  EPB.df$PROTOCOL.FMRI___MANUFACTURER = gsub(" ", ".", EPB.df$PROTOCOL.FMRI___MANUFACTURER)
  if(sum(EPB.df$MANUFACTURER %in% EPB.df$PROTOCOL.FMRI___MANUFACTURER)==nrow(EPB.df)){
    EPB.df$MANUFACTURER = NULL
    EPB.df$`PROTOCOL.FMRI___MFG MODEL` = EPB.df$MANUFACTURERSMODELNAME
    EPB.df$MANUFACTURERSMODELNAME = NULL
  }
  data.list = list(EPB = EPB.df, MT1 = MT1.df)



  #===========================================================================
  # Slice Order Info
  #===========================================================================
  Order_Extracted.list = RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Slice.Order.Info(data.list)
  Order_Extracted.list[[1]]$SLICE.ORDER.TYPE



  #===========================================================================
  # Bandtype
  #===========================================================================
  Band.Type.list = RS.fMRI_1.2_Merging.Lists___Modifying.Cols___Band.Type(Order_Extracted.list)





  #=====================================================================================
  # Move cols : EPB
  #=====================================================================================
  combined_EPB.df = Band.Type.list[[1]]
  combined_EPB.df$T1_ACCELERATED = NULL
  New_combined_EPB.df = combined_EPB.df %>% relocate(ends_with("DESCRIPTION"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("FMRI_"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("IMAGE"))
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___MEAN_SNR = FMRI_MEAN_SNR)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___PHASE_DIRECTION = FMRI_PHASE_DIRECTION)
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(contains("FMRI___"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROTOCOL"), .after = last_col())
  # Phase
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PHASE"))
  New_combined_EPB.df$PHASE_NFQ = NULL
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROJECT"))
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(ends_with("DATE"), .after = VISCODE2)
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("SLICE"), .before = BAND.TYPE)
  # filed strength
  New_combined_EPB.df$FIELD_STRENGTH = as.numeric(New_combined_EPB.df$FIELD_STRENGTH)
  New_combined_EPB.df$`PROTOCOL.FMRI___FIELD STRENGTH` = as.numeric(New_combined_EPB.df$`PROTOCOL.FMRI___FIELD STRENGTH`)
  if(sum(New_combined_EPB.df$FIELD_STRENGTH == New_combined_EPB.df$`PROTOCOL.FMRI___FIELD STRENGTH`) == nrow(New_combined_EPB.df)){
    New_combined_EPB.df$FIELD_STRENGTH = NULL
  }
  # TR
  New_combined_EPB.df = New_combined_EPB.df %>% rename(`PROTOCOL.FMRI___TR(SEARCH)` = PROTOCOL.FMRI___TR)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(`PROTOCOL.FMRI___TR(QC)` = REPETITIONTIME)
  # slice
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___SLICE.TIMING = SLICE.TIMING)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___SLICE.ORDER = SLICE.ORDER)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___SLICE.ORDER.TYPE = SLICE.ORDER.TYPE)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___SLICE.BAND.TYPE = BAND.TYPE)
  # relocate FMRI___
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("FMRI___"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROTOCOL"), .after = last_col())
  # relocate QC
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_"), .after = last_col())
  # TR
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROTOCOL.FMRI___TR(SEARCH)"), .after = `PROTOCOL.FMRI___TR(QC)`)





  #=====================================================================================
  # Move cols : MT1
  #=====================================================================================
  combined_MT1.df = MT1.df
  combined_MT1.df$FMRI_MEAN_SNR = NULL
  combined_MT1.df$FMRI_PHASE_DIRECTION = NULL
  New_combined_MT1.df = combined_MT1.df %>% relocate(ends_with("DESCRIPTION"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("MRI_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("QC_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("IMAGE"))

  New_Subjects.list = list(EPB = New_combined_EPB.df, MT1 = New_combined_MT1.df)







  #=============================================================================
  # Add New Manufactuers with Bandtype
  #=============================================================================
  EPB.df = New_Subjects.list[[1]]
  MT1.df = New_Subjects.list[[2]]

  Manufacturer_New = EPB.df$PROTOCOL.FMRI___MANUFACTURER

  ### Changing Philips
  Manufacturer_New[grep("Philips", Manufacturer_New, ignore.case = T)] = "Philips"
  Manufacturer_New = paste(Manufacturer_New, EPB.df$FMRI___SLICE.BAND.TYPE, sep="_")

  ### Add cols
  New_Subjects.list[[1]] = cbind(Manufacturer_New, EPB.df) %>% as_tibble
  New_Subjects.list[[2]] = cbind(Manufacturer_New, MT1.df) %>% as_tibble



  return(New_Subjects.list)
}



























