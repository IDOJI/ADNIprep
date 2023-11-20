RS.fMRI_1_Data.Selection___RID = function(input){











  #=============================================================================
  # Intersection RID
  #=============================================================================
  Intersection_RID = function(df, RID_Intersect){
    df %>% dplyr::filter(RID %in% RID_Intersect)
  }
  Results = lapply(Data_List_Index, function(k){
    input[[k]] <<- lapply(input[[k]], Intersection_RID, RID_Intersect)
  })






  #=============================================================================
  # Return
  #=============================================================================
  cat("\n", crayon::bgMagenta("Intersecting RID"), crayon::green("is done!"), "\n")
  return(input)

}
