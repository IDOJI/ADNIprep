RS.fMRI_1.3_Exporting.Lists___Combine.by.Manufacturer = function(data.list){
  # data.list = Export_all_subjects.list
  #===============================================================================
  # Data load
  #===============================================================================
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]


  #===============================================================================
  # Split EPB by Manufacturer
  #===============================================================================
  Manu = EPB.df$Manufacturer_New %>% unique
  EPB.list = lapply(Manu, FUN=function(ith_Manu, ...){
    EPB.df %>% filter(Manufacturer_New == ith_Manu)
  })
  names(EPB.list) = Manu



  #===============================================================================
  # Select MT1
  #===============================================================================
  MT1.list = lapply(Manu, FUN=function(ith_Manu, ...){
    MT1.df %>% filter(Manufacturer_New == ith_Manu)
  })
  names(MT1.list) = Manu




  #===============================================================================
  # Combining
  #===============================================================================
  combined.list = list()
  for(i in 1:length(EPB.list)){
    combined.list[[i]] = list(EPB = EPB.list[[i]], MT1 = MT1.list[[i]])
  }
  names(combined.list) = Manu

  return(combined.list)
}
