RS.fMRI_4_Generate.Slice.Order.Info = function(destination){
  #=============================================================================
  # Extract Sub num
  #=============================================================================
  path_FunImgAR = list.files(destination, full.names=T)[list.files(destination)=="FunImgAR"]
  Sub_Num = list.files(path_FunImgAR)


  #=============================================================================
  # Export Slice Order tsv
  #=============================================================================
  RS.fMRI_1.3_Exporting.Lists___SUB_Export.SliceOrderInfo(path = destination, Sub_Num = Sub_Num)
}
