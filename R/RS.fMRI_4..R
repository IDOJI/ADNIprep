RS.fMRI_4. = function(path_completed.preprocessing, save.path=NULL, exclude.list=NULL){
  # path_completed.preprocessing = "D:/ADNI/ADNI_RS.fMRI/@완료_New_Template_unified_segmentation"
  #==================================================================================================
  # 1) Results path
  #==================================================================================================
  path_Results = RS.fMRI_4.1_Extract.Rusults.Path(path_completed.preprocessing)
  cat("\n", crayon::red("Step 4.1"), crayon::yellow("Extracting"),  crayon::red("'Results'"),crayon::yellow("path of each folder"), crayon::blue("is done !!") ,"\n")


  #==================================================================================================
  # 2) Extracting Results
  #==================================================================================================
  Extracted_Results.list = RS.fMRI_4.2_Extracting.Results(path_Results)



  #==================================================================================================
  # 3) Combining Results by Manufacturer
  #==================================================================================================
  RS.fMRI_4.3_Combine.Results.By.Manufacturer = function(Extracted_Results.list){
    folders = Extracted_Results.list[[1]] %>% names
  }









  Combined_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information(Extracted_Data.list, path_ADNI)
  cat("\n", crayon::red("Step 4.3."), crayon::yellow("Combining subjects information"), crayon::blue("is done !!") ,"\n")
  saving_data(rda.name = "ADNI___RS.fMRI___Group_All", rda = Combined_by_RID.list, path = save.path)



  #==================================================================================================
  # 4) Split by Research.Groups
  #==================================================================================================
  Split_by_Research_Groups.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Split.by.Research.Groups(Combined_by_RID.list)
  cat("\n", crayon::red("Step 4.4."), crayon::yellow("Splitting by research groups"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 5) Data saving
  #==================================================================================================
  if(!is.null(save.path)){
    group_names = names(Split_by_Research_Groups.list)
    filenames = paste0("ADNI___RS.fMRI___Group_", group_names)
    for(i in 1:length(filenames)){
      saving_data(rda.name = filenames[i], rda = Split_by_Research_Groups.list[[i]], path = save.path)
    }
    cat("\n", crayon::red("Step 4.5."), crayon::yellow("Saving data for each group"), crayon::blue("is done !!") ,"\n")
  }

  cat("\n", crayon::bgRed("Step 4"), crayon::blue("is all done !!") ,"\n")
}
