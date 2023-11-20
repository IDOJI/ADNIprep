RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID = function(QC.list, NFQ.list, Search.list){
  #============================================================================
  # Merging QC & NFQ
  #============================================================================
  Merged_1.list = RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID___NFQ(QC.list, NFQ.list)


  #============================================================================
  # Merging with Search by RID & VISCODE
  #============================================================================
  Merged_2.list = RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID___Search(Merged_1.list, Search.list)

  return(Merged_2.list)
}
