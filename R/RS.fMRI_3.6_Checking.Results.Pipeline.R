RS.fMRI_3.6_Checking.Results.Pipeline = function(path_Preprocessing.Completed, Template.Name = "@Original_EPI"){
  #=============================================================================
  # folders
  #=============================================================================
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)




  #=============================================================================
  # each template folder
  #=============================================================================




  #=============================================================================
  # Set results folder name
  #=============================================================================
  if(Template.Name == "@Original_EPI"){
    results_folders_path = sapply(folders_path, FUN=function(y, ...){
      ith_results_folders = list.files(y, pattern = Template.Name, full.names = T) %>% list.files(pattern = "Results", full.names=F)
      ith_results_folders_path = list.files(y, pattern = Template.Name, full.names = T) %>% list.files(pattern = "Results", full.names=T)

      list.files(ith_results_folders_path[ith_results_folders=="Results"], pattern = "ROISignals_", full.names = T)
    })

    results_folders_path = sapply(folders_path, FUN=function(y, ...){list.files(y, pattern = Template.Name, full.names = T) %>% list.files(full.names=T)})
  }




}
