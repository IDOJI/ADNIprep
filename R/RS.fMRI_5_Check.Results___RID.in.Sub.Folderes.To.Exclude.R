RS.fMRI_5_Check.Results___RID.in.Sub.Folderes.To.Exclude = function(path_Subjects.List, path_Sub.Folder){
  RID_Sub.Folder = list.files(path_Sub.Folder) %>% str_extract("(?<=RID_)\\d+") %>% as.numeric
  RID_Subject.List = read.csv(path_Subjects.List) %>% select(RID) %>% unlist() %>% unname

  Selected_RID = RID_Sub.Folder[!RID_Sub.Folder %in% RID_Subject.List]
  if(length(Selected_RID)>0){
    cat("\n", crayon::red(Selected_RID),"\n")
    cat("\n", crayon::blue("These are RIDs not included in Subjects List!") ,"\n")
  }else{
    cat("\n", crayon::green("Congratulations! All RIDs are included in SUbjects List") ,"\n")
  }
}
