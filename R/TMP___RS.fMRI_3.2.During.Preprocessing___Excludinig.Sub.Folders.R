RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders = function(manu_path, suffix = "Exclude", which.sub.num){
  which.sub.num = RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Transform.Numbers.2.Sub(which.sub.num)


  ### folder list
  manu_path = manu_path %>% path_tail_slash()
  folders = list.files(manu_path)
  path_folders = list.files(manu_path, full.names = T)


  ### create folder
  path_destination = RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Dir.Create.By.Manu.Name(manu_path, suffix)


  ### moving files
  lapply(which.sub.num, FUN=function(ith.sub.num, ...){
    RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Moving.ith.Sub(path_destination, path_folders, folders, ith.sub.num)
  })

}
























