RS.fMRI_5_Check.Results___Sub.Folders.Each.Manufacturer = function(path_Manufacture, path_Subjects.List, Manufacture, Band){
  #=============================================================================
  # Files list  & Extracting RID
  #=============================================================================
  Files_RID = sapply(path_Manufacture, function(y){
    list.files(y)
  }) %>% unlist %>% str_extract("(?<=RID_)\\d+") %>% as.numeric() %>% sort



  #=============================================================================
  # Extracting Matched RID from Subjects list
  #=============================================================================
  Subjects_List_RID = read.csv(path_Subjects.List) %>% filter(MANUFACTURER_NEW == paste0(Manufacturer, "_", Band.Type)) %>% select(RID) %>% unlist() %>% as.numeric() %>% unname() %>% sort()





  #=============================================================================
  # Intersect RID
  #=============================================================================
  RID_Intersection = intersect(Subjects_List_RID, Files_RID)
  Only_in_Subjects.List = setdiff(Subjects_List_RID, RID_Intersection)
  Only_in_Files = setdiff(Files_RID, RID_Intersection)

  Files_RID %in% RID_Intersection


  if(length(Subjects_List_RID)>length(Files_RID)){
    cat("\n", crayon::green(), "\n")
    cat("\n", crayon::blue("These are RIDs not in 'Files'"),"\n")
  }else if(length(Subjects_List_RID) < length(Files_RID)){
    cat("\n", crayon::green(setdiff(Files_RID, Subjects_List_RID)), "\n")
    cat("\n", crayon::blue("These are RIDs not in 'Subjects List'"),"\n")
  }else{
    if(sum(Files_RID %in% Subjects_List_RID) == length(Subjects_List_RID)){
      cat("\n",crayon::green("Congratulations! All RID is same"),"\n")
    }else{
      stop("")
    }
  }
}



















