RS.fMRI_4.8_Saving.Data = function(Combining_Functional_Connectivity.list, path_save, atlas=NULL){
  if(!is.null(path_save)){
    group_names = names(Combining_Functional_Connectivity.list)
    if(is.null(atlas)){
      filenames = paste0("ADNI___RS.fMRI___", group_names)
    }else{
      filenames = paste0("ADNI___RS.fMRI___", atlas, "___", group_names)
    }
    for(i in 1:length(filenames)){
      saving_data(rda.name = filenames[i], rda = ith_data, path = path_save)
    }
  }
}
