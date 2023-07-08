RS.fMRI_5_Check.Results___Not.Extracted.Subjects.Lists = function(path_Extracted.Results.Folder,
                                                                  path_Subjects.List,
                                                                  Band.Type = NULL){
  #=============================================================================
  # RDS list
  #=============================================================================
  Extracted_RID = list.files(path_Extracted.Results.Folder) %>% str_extract("(?<=RID_)\\d+") %>% as.numeric()



  #=============================================================================
  # Subjects list
  #=============================================================================
  Subjects_List.df = read.csv(path_Subjects.List)
  if(!is.null(Band.Type)){
    Subjects_List_RID = Subjects_List.df %>% filter(NFQ___BAND.TYPE == Band.Type) %>% select(RID) %>% unlist() %>% unname() %>% sort()
  }else{
    Subjects_List_RID = Subjects_List.df %>% select(RID) %>% unlist() %>% unname() %>% sort()
  }
  # sum(Subjects_List_RID %in% Extracted_RID)
  # sum(Extracted_RID %in% Subjects_List_RID)

  #=============================================================================
  # Find RID not yet included
  #=============================================================================
  Selected_RID = setdiff(Subjects_List_RID, Extracted_RID)


  if(length(Selected_RID)==0){
    cat("\n", crayon::green("Congratulations! All RID in the Subject List are included!"),"\n")
  }else if(length(Selected_RID)>0){
    cat(Selected_RID)
    stop("There are RIDs not included! Check!")
  }else{
    cat(setdiff(Extracted_RID, Subjects_List_RID))
    stop("There are more RIDs not in Subjects List")
  }
}
