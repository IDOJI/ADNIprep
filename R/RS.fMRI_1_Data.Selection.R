RS.fMRI_1_Data.Selection = function(path_Subjects.Lists_Downloaded,
                                    path_Export_Subjects.Lists =NULL,
                                    path_Export_Rda      = NULL,
                                    Subjects_QC_ADNI2GO,
                                    Subjects_QC_ADNI3,
                                    Subjects_NFQ,
                                    Subjects_search,
                                    Subjects_DX_Summary,
                                    Subjects_BL_CHANGE,
                                    what.date            = 1,
                                    Include_RID        = NULL,
                                    Include_ImageID    = NULL,
                                    Exclude_RID          = NULL,
                                    Exclude_ImageID = NULL,
                                    Exclude_Comments = NULL){
  # Only.This.RID : 지정된 RID에 해당하는 개체들에 대해서만 데이터 선택
  #============================================================================
  # 0.path
  #============================================================================
  path_Subjects.Lists_Downloaded = path_tail_slash(path_Subjects.Lists_Downloaded)
  dir.create(path_Subjects.Lists_Downloaded, showWarnings = F)
  if(!is.null(path_Export_Subjects.Lists)){
    path_Export_Subjects.Lists = path_tail_slash(path_Export_Subjects.Lists)
    dir.create(path_Export_Subjects.Lists, showWarnings = F)
  }




  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects.Lists_Downloaded,
                                                    Subjects_QC_ADNI2GO,
                                                    Subjects_QC_ADNI3,
                                                    Subjects_NFQ,
                                                    Subjects_search,
                                                    what.date,
                                                    Include_RID,
                                                    Include_ImageID,
                                                    Exclude_RID,
                                                    Exclude_ImageID,
                                                    Exclude_Comments)





  #============================================================================
  # 2. Merging lists
  #============================================================================
  Merged_Lists.list = RS.fMRI_1.2_Merging.Lists(Subjects.list)






  #============================================================================
  # 3.Exporting Results
  #============================================================================
  if(is.null(path_Export_Subjects.Lists)){
    ### returning results
    text = paste("\n","Step 1 is all done !","\n")
    cat(crayon::bgRed(text))

    if(Merged_Lists.list[[1]] %>% length == 0 & Merged_Lists.list[[2]] %>% length == 0){
      cat("\n",crayon::red("There's no selected subjects"),"\n")
    }
    return(Merged_Lists.list)
  }else{
    RS.fMRI_1.3_Exporting.Lists(Merged_Lists.list,
                                path_Subjects.Lists_Downloaded,
                                path_Export_Subjects.Lists,
                                path_Export_Rda)
    ### returning results
    text = paste("\n","Step 1 is all done !","\n")
    cat(crayon::bgRed(text))
  }

}
















