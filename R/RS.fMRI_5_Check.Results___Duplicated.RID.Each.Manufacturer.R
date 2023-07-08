RS.fMRI_5_Check.Results___Duplicated.RID.Each.Manufacturer = function(path_Manufacture, path_Subjects.List, Manufacture, Band){
  #=============================================================================
  # Files list  & Extracting RID
  #=============================================================================
  path_Folders = sapply(path_Manufacture, function(y){
    list.files(y, full.names=T)
  }) %>% unlist %>% unname


  Folders = sapply(path_Manufacture, function(y){
    list.files(y, full.names=F)
  }) %>% unlist %>% unname

  Folders_RID = Folders %>% str_extract("(?<=RID_)\\d+") %>% as.numeric()


  #=============================================================================
  # Finding Duplicated RIDs
  #=============================================================================
  Duplicated_RID = table(Folders_RID)[which(table(Folders_RID)>1)] %>% names %>% as.numeric
  if(length(Duplicated_RID)>0){
    path_Duplicated_RID = lapply(Duplicated_RID, function(y, ...){
      path_Folders[Folders_RID == y]
    })
    names(path_Duplicated_RID) = Duplicated_RID
    cat("\n",crayon::red("Duplicated RID path are returned."),"\n")
    return(path_Duplicated_RID)
  }else{
    cat("\n",crayon::green("Congratulations! There's no duplicated RID!"),"\n")
  }





  # #=============================================================================
  # # Select Subjects from the list by manufacturer
  # #=============================================================================
  # Selected_Subjects.df = read.csv(path_Subjects.List) %>% filter(MANUFACTURER_NEW == paste0(Manufacturer, "_", Band.Type))
  #
  #
  #
  #
  #
  # #=============================================================================
  # # Intersect RID
  # #=============================================================================
  # RID_Intersection = intersect(Subjects_List_RID, Folders_RID)
  # Only_in_Subjects.List = setdiff(Subjects_List_RID, RID_Intersection)
  # Only_in_Files = setdiff(Folders_RID, RID_Intersection)
  #
  # Folders_RID %in% RID_Intersection
  #
  #
  # if(length(Subjects_List_RID)>length(Folders_RID)){
  #   cat("\n", crayon::green(), "\n")
  #   cat("\n", crayon::blue("These are RIDs not in 'Files'"),"\n")
  # }else if(length(Subjects_List_RID) < length(Folders_RID)){
  #   cat("\n", crayon::green(setdiff(Folders_RID, Subjects_List_RID)), "\n")
  #   cat("\n", crayon::blue("These are RIDs not in 'Subjects List'"),"\n")
  # }else{
  #   if(sum(Folders_RID %in% Subjects_List_RID) == length(Subjects_List_RID)){
  #     cat("\n",crayon::green("Congratulations! All RID is same"),"\n")
  #   }else{
  #     stop("")
  #   }
  # }
}
