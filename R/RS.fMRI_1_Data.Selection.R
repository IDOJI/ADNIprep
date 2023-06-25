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
                                    # Subjects_Study_Visits,
                                    Subjects_Registry,
                                    ############################################
                                    Subjects_PTDEMO,
                                    Subjects_DX_Summary,
                                    Subjects_BLCHANGE,
                                    Subjects_ADAS,
                                    Subjects_MMSE,
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
  path_Subjects.Lists_Downloaded = path_Subjects.Lists_Downloaded %>% path_tail_slash()
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
  # 2. Loading Subjects lists
  #============================================================================
  Loaded_Data.list = RS.fMRI_1_Data.Selection___Loading.Lists(Selected_Subjects_by_QC.list,
                                                              path_Subjects.Lists_Downloaded,
                                                              Subjects_NFQ,
                                                              Subjects_Search,
                                                              Subjects_Registry,
                                                              Subjects_CV_ADNI2GO,
                                                              Subjects_CV_ADNI3,
                                                              Subjects_BLCHANGE,
                                                              Subjects_DX_Summary,
                                                              Subjects_ADAS,
                                                              Subjects_MMSE)





  #=============================================================================
  # 3. Merging Subjects lists
  #=============================================================================
  Merged_Full.list = RS.fMRI_1_Data.Selection___Merging.Lists(Loaded_Data.list)




  #============================================================================
  # 4.Diagnosis
  #============================================================================
  Merged_Diagnosis.list = RS.fMRI_1_Data.Selection___Diagnosis(Merged_Full.list)

  Merged_Diagnosis.list[[316]]



  #===============================================================================
  # 5. Demographics
  #===============================================================================
  Demographics.df = RS.fMRI_1_Data.Selection___Demographics(Merged_Diagnosis.list, path_Subjects.Lists_Downloaded, Subjects_APOE)






  #===============================================================================
  # 6.Splitting Data
  #===============================================================================





  #=============================================================================
  # Adding numbering and Filenames by Manufacturer
  #=============================================================================
  Added_Numbering.list = RS.fMRI_1.3_Adding.Numbering.By.Manufacturers(Binded.list)



  #=============================================================================
  # Extract Demo variables
  #=============================================================================
  # Selected.list = RS.fMRI_1_Data.Selection___Demographics___Selecting.Variables(Demo.list)



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
















