RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info = function(data.list, path_Subjects.Lists.Exported){
  # data.list = Combine_by_manufacturer.list

  Manu_Names = names(data.list)
  for(i in 1:length(Manu_Names)){
    RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info___Export.Divided.List(data.list = data.list[[i]],
                                                                                      index = i,
                                                                                      Manufacturer = Manu_Names[i],
                                                                                      path_Subjects.Lists.Exported  = path_Subjects.Lists.Exported)
  }
  return(data.list)
}



