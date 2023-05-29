RS.fMRI_3_Export.New.Subjects.Lists___Extract_RID = function(path){
  folders = list.files(path)
  RID = sapply(folders , function(y){
    y = strsplit(y, split = "___")[[1]][3] %>% strsplit("_")
    y[[1]][2] %>% as.numeric
  })
  names(RID) = NULL
  return(RID)
}
