RS.fMRI_4.8_Saving.Data = function(Combining_Functional_Connectivity.list, path_save, atlas=NULL){
  if(!is.null(path_save)){
    group_names = names(Combining_Functional_Connectivity.list)
    if(is.null(atlas)){
      filenames = paste0("ADNI___RS.fMRI___", group_names)
    }else{
      filenames = paste0("ADNI___RS.fMRI___", atlas, "___", group_names)
    }
    for(i in 1:length(filenames)){
      path_save = path_save %>% path_tail_slash()
      setwd(path_save)
      gth_group = Combining_Functional_Connectivity.list[[i]]
      save(gth_group, file = paste0(filenames[i], ".rda"))
    }
  }
}
