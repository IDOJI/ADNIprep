RS.fMRI_4.6_Saving.Data = function(Split_by_Research_Groups.list, path_save, atlas){
  if(!is.null(path_save)){
    group_names = names(Split_by_Research_Groups.list)
    filenames = paste0("ADNI___RS.fMRI___", atlas, "_____", group_names)
    for(i in 1:length(filenames)){
      saving_data(rda.name = filenames[i], rda = Split_by_Research_Groups.list[[i]], path = path_save)
    }
  }
}
