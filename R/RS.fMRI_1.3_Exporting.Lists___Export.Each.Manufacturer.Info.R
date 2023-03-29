RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info = function(data.list=Combine_by_manufacturer.list, path_Subjects, path_Rda){

  Manu = names(data.list)
  for(i in 1:length(Manu)){
    RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info___Export.Divided.List(data.list[[i]], i, Manu[i], path_Subjects, path_Rda)
  }
  return(data.list)
}



