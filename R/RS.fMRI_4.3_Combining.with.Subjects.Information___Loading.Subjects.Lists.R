RS.fMRI_4.3_Combining.with.Subjects.Information___Loading.Subjects.Lists = function(path_ADNI_Subjects, folders){
  ### path
  folders_in_subjects = filter_by(list.files(path_ADNI_Subjects), folders, any=T)
  path_ADNI_Subjects = path_ADNI_Subjects %>% path_tail_slash()
  path_folders_in_subjects = paste0(path_ADNI_Subjects, folders_in_subjects)



  ### loading list
  subjects.list = lapply(path_folders_in_subjects, FUN=function(path_ith_folder){
    # path_ith_folder = path_folders_in_subjects[1]
    ith_subjects_list = list.files(path_ith_folder, pattern = "EPB", full.names = T) %>% read.csv
    ith_subjects_list %>% dplyr::select("PHASE_SQ","PHASE_NFQ","RESEARCH.GROUP", "RID","SUBJECT.ID","IMAGE_ID", "AGE","SEX","WEIGHT","VISCODE","VISCODE2","STUDY.DATE","MANUFACTURER","SERIES_DESCRIPTION","NFQ")
  })



  ### adding `Sub`
  subjects_with_sub.list = lapply(subjects.list, FUN=function(ith_list){
    # ith_list = subjects.list[[1]]
    data.frame(Sub_folder = paste0("Sub_", fit_length(1:nrow(ith_list), 3)), ith_list)
  })
  names(subjects_with_sub.list) = folders_in_subjects


  return(subjects_with_sub.list)
}
