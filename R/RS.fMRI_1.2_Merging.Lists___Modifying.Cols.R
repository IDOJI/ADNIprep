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
  # protocol : manufacturer rename
  New_combined_EPB.df = New_combined_EPB.df %>% rename(PROTOCOL.FMRI___MANUFACTURER2 = MANUFACTURER)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(PROTOCOL.FMRI___MANUFACTURERSMODELNAME = MANUFACTURERSMODELNAME)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(PROTOCOL.FMRI___SOFTWAREVERSIONS = SOFTWAREVERSIONS)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(PROTOCOL.FMRI___SERIESTIME = SERIESTIME)
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROTOCOL"), .after = last_col())
  # relocate FMRI___
  # LONI
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___LONI.STUDY = LONI_STUDY)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___LONI.SERIES = LONI_SERIES)
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("FMRI___"), .after = last_col())
  # relocate QC
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_"), .after = last_col())
  # TR
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("PROTOCOL.FMRI___TR(SEARCH)"), .after = `PROTOCOL.FMRI___TR(QC)`)
  # Overall QC
  New_combined_EPB.df = New_combined_EPB.df %>% rename(QC_VAR_OVERALLQC=OVERALLQC)
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_VAR"), .after=last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_COMMENTS"), .after=last_col())

  # Visit
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(VISIT, .after=VISCODE2)
  # Date
  if(sum(New_combined_EPB.df$SERIES_DATE == New_combined_EPB.df$STUDY.DATE)==nrow(New_combined_EPB.df)){
    New_combined_EPB.df$SERIES_DATE = NULL
  }

  # Research Group
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(RESEARCH.GROUP, .after = PHASE)

  # ID
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(SUBJECT.ID, .after = RID)





  #=====================================================================================
  # Move cols : MT1
  #=====================================================================================
  combined_MT1.df = Band.Type.list[[2]]
  combined_MT1.df$FMRI_MEAN_SNR = NULL
  combined_MT1.df$FMRI_PHASE_DIRECTION = NULL
  New_combined_MT1.df = combined_MT1.df %>% relocate(ends_with("DESCRIPTION"), .after = last_col())

  # MRI
  New_combined_MT1.df = New_combined_MT1.df %>% rename(MRI___LONI.STUDY = LONI_STUDY)
  New_combined_MT1.df = New_combined_MT1.df %>% rename(MRI___LONI.SERIES = LONI_SERIES)
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("MRI___"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("MRI_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("QC_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("IMAGE"))
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(SUBJECT.ID, .after = RID)
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(ends_with("DATE"), .after = SUBJECT.ID)
  if(sum(New_combined_MT1.df$STUDY.DATE==New_combined_MT1.df$SERIES_DATE) == nrow(New_combined_MT1.df)){
    New_combined_MT1.df$SERIES_DATE = NULL
  }
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(VISIT, .after=ARCHIVE.DATE)
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(RESEARCH.GROUP, .after=IMAGE_ID)
  if(sum(New_combined_MT1.df$DESCRIPTION==New_combined_MT1.df$SERIES_DESCRIPTION) == nrow(New_combined_MT1.df)){
    New_combined_MT1.df$DESCRIPTION=NULL
  }
  New_combined_MT1.df = New_combined_MT1.df %>% rename(MRI___T1_ACCELERATED=T1_ACCELERATED)
  New_combined_MT1.df = New_combined_MT1.df %>% rename(MRI___MODALITY=MODALITY)
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("MRI_"), .after=last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("PROTOCOL.MRI_"), .after=last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("QC_Var_"), .after=last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("QC_COMMENTS_"), .after=last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(PHASE)
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(PROJECT)






  #=============================================================================
  # Moving  subject ID
  #=============================================================================
  EPB.df = New_combined_EPB.df
  MT1.df = New_combined_MT1.df



  #=============================================================================
  # Add New Manufactuers with Bandtype
  #=============================================================================
  Manufacturer_New = EPB.df$PROTOCOL.FMRI___MANUFACTURER
  Manufacturer_New[grep("Philips", Manufacturer_New, ignore.case = T)] = "Philips"
  Manufacturer_New = paste(Manufacturer_New, EPB.df$FMRI___SLICE.BAND.TYPE, sep="_")

  ### Add cols
  New_Subjects.list = list()
  New_Subjects.list[[1]] = cbind(Manufacturer_New, EPB.df) %>% as_tibble
  New_Subjects.list[[2]] = cbind(Manufacturer_New, MT1.df) %>% as_tibble

  return(New_Subjects.list)
}




























