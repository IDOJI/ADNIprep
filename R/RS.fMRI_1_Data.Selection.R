# what.date            = 1
# Include_RID        = NULL
# Include_ImageID    = NULL
# Exclude_RID          = NULL
# Exclude_ImageID = NULL
# Exclude_Comments = NULL
# Error_ImageID_0 = c("I952527", "I952530","I1173062", "I971099", "I1021034", "I1606245", "I1329385", "I1557905", "I1567175", "I1628478", "I1173060", "I971096", "I1021033", "I1606240", "I1329390", "I1557901", "I1567174", "I1628474")
# Error_ImageID_1 = c("I1051713","I1051710","I928485","I928482","I882170","I882167","I1020140","I1020137","I996381","I996377","I1158788","I1158785","I1010737","I1010734","I1604231","I1604220","I879211","I879209","I1116736","I1116728","I994534","I994530","I1516267","I1516264","I1444304","I1444291","I992637","I992628","I1003966","I1003961","I1170567","I1170562","I1157074","I1157071","I998811","I998806")
# Exclude_ImageID = c(Error_ImageID_0, Error_ImageID_1)
RS.fMRI_1_Data.Selection = function(path_Subjects.Lists_Downloaded,
                                    path_Export_Subjects.Lists =NULL,
                                    ############################################ QC
                                    Subjects_QC_ADNI2GO,
                                    Subjects_QC_ADNI3,
                                    ############################################
                                    Subjects_NFQ,
                                    Subjects_Search,
                                    Subjects_Registry,
                                    ############################################
                                    Subjects_PTDEMO,
                                    Subjects_DX_Summary,
                                    Subjects_BLCHANGE,
                                    Subjects_APOE,
                                    ############################################
                                    what.date            = 1,
                                    Include_RID        = NULL,
                                    Include_ImageID    = NULL,
                                    Exclude_RID          = NULL,
                                    Exclude_ImageID = NULL,
                                    Exclude_Comments = NULL){
  #=============================================================================
  # 1. Selecting Data by QC
  #=============================================================================
  Selected_Subjects_by_QC.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC(Subjects_QC_ADNI2GO,
                                                                                   Subjects_QC_ADNI3,
                                                                                   path_Subjects.Lists_Downloaded,
                                                                                   what.date,
                                                                                   Include_RID,
                                                                                   Include_ImageID,
                                                                                   Exclude_RID,
                                                                                   Exclude_ImageID,
                                                                                   Exclude_Comments)





  #============================================================================
  # 2. Merging Subjects lists
  #============================================================================
  Merged_Lists.list = RS.fMRI_1_Data.Selection___Loading.Lists()


  Subjects_PTDEMO

  PHASE가 동일하고, 날짜가 가장 가까운 경우
  ADNIMERGE의 bl을 기준으로 날짜 계산해서 VISCODE를 부여


  path_Subjects.Lists_Downloaded = path_tail_slash(path_Subjects.Lists_Downloaded)
  dir.create(path_Subjects.Lists_Downloaded, showWarnings = F)
  if(!is.null(path_Export_Subjects.Lists)){
    path_Export_Subjects.Lists = path_tail_slash(path_Export_Subjects.Lists)
    dir.create(path_Export_Subjects.Lists, showWarnings = F)
  }
  path_Subjects_BLCHANGE = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_BLCHANGE)
  path_Subjects_DX_Summary = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_DX_Summary)
  path_Subjects_PTDEMO = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_PTDEMO)
  path_Subjects_APOE = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_APOE)


  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects.Lists_Downloaded,
                                                    # QC
                                                    Subjects_QC_ADNI2GO,
                                                    Subjects_QC_ADNI3,
                                                    # NFQ
                                                    Subjects_NFQ,
                                                    # Search
                                                    Subjects_Search,
                                                    # Registry
                                                    Subjects_Registry,
                                                    # Others
                                                    what.date,
                                                    Include_RID,
                                                    Include_ImageID,
                                                    Exclude_RID,
                                                    Exclude_ImageID,
                                                    Exclude_Comments)













  #============================================================================
  # 3.Diagnosis
  #============================================================================
  Merged_Diagnosis.list = RS.fMRI_1.3_Diagnosis(Merged_Lists.df,
                                                path_Subjects_BLCHANGE,
                                                path_Subjects_DX_Summary)








  #===============================================================================
  # Extracting Demographics & Data binding
  #===============================================================================
  Binded.list = RS.fMRI_1.4_Demographics(Merged_Diagnosis.list, path_Subjects_APOE)
  # • About EXAMDATE in Clinical data files
  # – Clinical data acquired in ADNIGO/2 do not include ‘EXAMDATE’ (the date of the exam), although this
  # information was included for ADNI1 visits.
  # – The variable ’USERDATE’ is the data entry (or modification) date, and may be very different from EXAMDATE.
  # – Use the variable ‘EXAMDATE’ in the registry table (REGISTRY.csv) as the date of exam for all clinical
  # data (merge by RID and VISCODE or VISCODE2)
  Clipboard_to_path()
  registry.df = read.csv("C:/Users/lleii/Dropbox/Github/Rpkgs/Papers___Data/Data___ADNI___RS.fMRI___Subjects.Lists/Subjects_Lists_Downloaded/REGISTRY_23Jun2023.csv")

  dregistry.df %>% filter(RID==5277)






  #=============================================================================
  # Adding numbering and Filenames by Manufacturer
  #=============================================================================
  Added_Numbering.list = RS.fMRI_1.3_Adding.Numbering.By.Manufacturers(Binded.list)





  #============================================================================
  # 4.Exporting Results
  #============================================================================
  if(is.null(path_Export_Subjects.Lists)){
    ### returning results
    text = paste("\n","Step 1 is all done !","\n")
    cat(crayon::bgRed(text))

    if(Merged_Diagnosis.list[[1]] %>% length == 0){
      cat("\n",crayon::red("There's no selected subjects"),"\n")
    }
    return(Merged_Diagnosis.list)
  }else{

    Final.list = RS.fMRI_1.5_Exporting.Lists(Merged_Diagnosis.list,
                                             path_Subjects.Lists_Downloaded,
                                             path_Export_Subjects.Lists)


    ### returning results
    text = paste("\n","Step 1 is all done !","\n")
    cat(crayon::bgRed(text))
    return(Final.list)
  }

}
















