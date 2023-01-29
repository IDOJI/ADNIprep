RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Moving.ith.Sub = function(path_destination, path_folders, folders, which.sub.num){
  lapply(folders, FUN=function(jth_folder, ...){
    # create destination
    jth_destination = paste0(path_destination, "/", jth_folder)
    dir.create(jth_destination, showWarnings = F)

    # path for moving
    index = which(folders == jth_folder)
    jth_path = path_folders[index]


    jth_path_files = list.files(jth_path, pattern = which.sub.num)
    jth_path_files_path = list.files(jth_path, full.names = T, pattern = which.sub.num)


    # is.results
    is.Results = grep(pattern = "Results", x = jth_folder) %>% length > 0


    #########################################################################
    # Sub_xxx를 포함한 파일이 존재할 때
    #########################################################################
    if(length(jth_path_files)>0){
      # 그 파일이 폴더인 경우
      if(which.sub.num %in% jth_path_files){
        copy_files_fast(paste0(jth_path, "/", which.sub.num), paste0(jth_destination, "/", which.sub.num), move = T, overwrite = T)
        # 파일들 이름에  Sub_xxx를 포함하는 경우
      }else{
        move_files(jth_path_files_path, jth_destination)
      }
      #########################################################################
      # Sub_xxx를 포함한 파일이 존재하지 않을 때
      #########################################################################
    }else{
      if(jth_folder=="Masks"){
        path_AutoMasks = list.files(paste0(jth_path, "/AutoMasks"), pattern = which.sub.num, full.names = T)
        path_SegmentationMasks = list.files(paste0(jth_path, "/SegmentationMasks"), pattern = which.sub.num, full.names = T)
        path_WarpedMasks = list.files(paste0(jth_path, "/WarpedMasks"), pattern = which.sub.num, full.names = T)

        move_files(path_AutoMasks, paste0(jth_destination, "/AutoMasks"))
        move_files(path_SegmentationMasks, paste0(jth_destination, "/SegmentationMasks"))
        move_files(path_WarpedMasks, paste0(jth_destination, "/WarpedMasks"))
      }else if(is.Results){
        results_folders = list.files(jth_path)
        lapply(results_folders, FUN=function(kth_results_folder){
          move_files(list.files(paste0(jth_path, "/", kth_results_folder), full.names = T, pattern = which.sub.num), paste0(jth_destination, "/", kth_results_folder))
        })
      }
    }

  })
}
