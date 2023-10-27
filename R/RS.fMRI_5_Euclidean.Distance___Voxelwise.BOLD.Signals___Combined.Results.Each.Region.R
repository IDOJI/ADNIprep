RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Combined.Results.Each.Region = function(Median_FC_Coordinates){
  FC_coordinates.list = lapply(Median_FC_Coordinates, function(jth_Region){
    # jth_Region = Median_FC_Coordinates[[j]]
    #===========================================================================
    # FC
    #===========================================================================
    jth_FC = sapply(jth_Region, function(x){
      x[[1]]
    }) %>% matrix(nrow=1) %>% as.data.frame() %>% setNames(names(jth_Region))



    #===========================================================================
    # Row
    #===========================================================================
    jth_row = sapply(jth_Region, function(x){
      x[[2]]
    }) %>% matrix(nrow=1) %>% as.data.frame() %>% setNames(names(jth_Region))




    #===========================================================================
    # Col
    #===========================================================================
    jth_col = sapply(jth_Region, function(x){
      x[[3]]
    }) %>% matrix(nrow=1) %>% as.data.frame() %>% setNames(names(jth_Region))


    list(FC = jth_FC, row = jth_row, col = jth_col)
  })

  return(FC_coordinates.list)
}
