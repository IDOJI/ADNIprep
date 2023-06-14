RS.fMRI_5_Check.Not.Calculated.Results = function(path_Sub, what.folders = c("ALFF_FunImgARCWS", "ALFF_FunImgARglobalCWS", "DegreeCentrality_FunImgARCWSF", "DegreeCentrality_FunImgARglobalCWSF", "fALFF_FunImgARCWS", "fALFF_FunImgARglobalCWS", "FC_FunImgARCWSF", "FC_FunImgARglobalCWSF", "ReHo_FunImgARCWSF", "ReHo_FunImgARglobalCWSF", "ROISignals_FunImgARCWSF", "ROISignals_FunImgARglobalCWSF")){
  #===========================================================================
  # load sub path & Results folders
  #===========================================================================
  path_Sub_Folders = fs::dir_ls(path_Sub, type = "dir")
  path_Results = paste0(path_Sub_Folders, "/Results")



  #===========================================================================
  # Load Results for each Sub
  #===========================================================================
  Not_Yet_Results.list = lapply(path_Results, function(ith_path, ...){
    ith_Results = list.files(ith_path)
    ith_Not_Yet_Results = what.folders[!what.folders %in% ith_Results]
    return(ith_Not_Yet_Results)
  })
  names(Not_Yet_Results.list) = path_Sub_Folders


  Not_Yet_Results_Rm_Null.list = lapply(Not_Yet_Results.list, function(y){
    if(length(y)>0){
      return(y)
    }
  }) %>% rm_list_null()

  if(length(Not_Yet_Results_Rm_Null.list)>0){
    cat("\n", crayon::red("There are statistic to calculate further!"),"\n")
    return(Not_Yet_Results_Rm_Null.list)
  }else{
    cat("\n", crayon::green("Congratulation! All the statistics are calculated!") ,"\n")
  }
}
