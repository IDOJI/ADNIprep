RS.fMRI_1_Data.Selection___Merging.Lists = function(Loaded_Data.list){
  #============================================================================
  # Merge by Image ID
  #============================================================================
  Merged_ImageID.list = RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID(QC.list = Loaded_Data.list$QC,
                                                                            NFQ.list = Loaded_Data.list$NFQ,
                                                                            Search.list = Loaded_Data.list$Search)





  #============================================================================
  # Merging Lists Having complete VISCODE2
  #============================================================================
  Merged_VISCODE2.list = RS.fMRI_1_Data.Selection___Merging.Lists___VISCODE2(Registry.list = Loaded_Data.list$Registry,
                                                                             PTDEMO.list = Loaded_Data.list$PTDEMO,
                                                                             DXSUM.list = Loaded_Data.list$DXSUM)




  #============================================================================
  # Merging with ImageID by PHASE & VISCODE
  #============================================================================
  Merged_VISCODE.list = RS.fMRI_1_Data.Selection___Merging.Lists___VISCODE(Merged_ImageID.list, Merged_VISCODE2.list)




  #============================================================================
  # Merging with Other subjects lists
  #============================================================================
  Merged_Full.list = RS.fMRI_1_Data.Selection___Merging.Lists___Other.Subjects.Lists(Merged_VISCODE.list,
                                                                                     ADNIMERGE.list = Loaded_Data.list$ADNIMERGE,
                                                                                     CV.list = Loaded_Data.list$CLIELG,
                                                                                     BLCHANGE.list = Loaded_Data.list$BLCHANGE,
                                                                                     ADAS.list = Loaded_Data.list$ADAS,
                                                                                     MMSE.list = Loaded_Data.list$MMSE)








  #============================================================================
  # final
  #============================================================================
  return(Merged_Full.list)
}
