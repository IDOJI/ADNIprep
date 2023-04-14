RS.fMRI_1.2_Merging.Lists___Adding.Cols = function(data.list){
  # data.list = Merging_Search_and_QC.list
  #===========================================================================
  # Slice Order Info
  #===========================================================================
  Slice.Order.Type_Extracted.list = RS.fMRI_1.2_Merging.Lists___Adding.Cols___Slice.Order.Info(data.list)
  text = "1.2.1 : Extracing Slice.Order.Info is done!"
  cat("\n", crayon::green(text), "\n")



  #===========================================================================
  # Bandtype
  #===========================================================================
  Band.type.list = RS.fMRI_1.2_Merging.Lists___Adding.Cols___Band.Type(Slice.Order.Type_Extracted.list)
  text = "1.2.2 : Extracting BAND.TYPE is done!"
  cat("\n", crayon::green(text), "\n")


  return(Band.type.list)
}
