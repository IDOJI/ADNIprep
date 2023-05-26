RS.fMRI_4. = function(path_completed.preprocessing, path_save=NULL, atlas= NULL){
  # path_completed.preprocessing = "C:/Users/IDO/Dropbox/패밀리룸/데이터(Data)/RS-fMRI_AAL116"
  # path_save = "C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/Data"
  #==================================================================================================
  # 1) Extract Results path & Norm pictures path
  #==================================================================================================
  path_Results = RS.fMRI_4.1_Extract.Path(path_completed.preprocessing, "Results")
  path_Norm.Pictures = RS.fMRI_4.1_Extract.Path(path_completed.preprocessing, "Pictures")
  cat("\n", crayon::red("Step 4.1"), crayon::yellow("Extracting"),  crayon::red("'Results'"),crayon::yellow("path of each folder"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 2) Extracting Results
  #==================================================================================================
  Extracted_Results.list = RS.fMRI_4.2_Extracting.Results(path_Results, path_Norm.Pictures)
  cat("\n", crayon::red("Step 4.2"), crayon::yellow("Extracting"),  crayon::red("'Results'"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 3) Extracting Subjects' information
  #==================================================================================================
  Combined_Subjects_Info.list = RS.fMRI_4.3_Combining.with.Subjects.Information(Extracted_Results.list, path_Subjects = "/Volumes/Seagate/ADNI/ADNI_Subjects")
  cat("\n", crayon::red("Step 4.3."), crayon::yellow("Combining subjects information"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 4) combine regardless of manufacturers -> 각 그룹 별로 Manufacturer 나눠서 저장
  #==================================================================================================
  New_Combined_Subjects_Info.list = RS.fMRI_4.4_Combine.Regardless.Of.Manufacturers(Combined_Subjects_Info.list)
  cat("\n", crayon::red("Step 4.4."), crayon::yellow("Combining every manufacture"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 5) Split by Research.Groups
  #==================================================================================================
  Split_by_Research_Groups.list = RS.fMRI_4.5_Split.by.Research.Groups(New_Combined_Subjects_Info.list)
  cat("\n", crayon::red("Step 4.5."), crayon::yellow("Splitting by research groups"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 6) Except subjects with not defined ROIs
  #==================================================================================================
  Excluding_Not_Defined_ROIs.list = RS.fMRI_4.6_Exclude.Subjects.With.Not.Defined.ROIs(Split_by_Research_Groups.list)
  cat("\n", crayon::red("Step 4.6."), crayon::yellow("Excluding Not Defined ROIs"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 7) Combining Functional Connectivity
  #==================================================================================================
  Combining_Functional_Connectivity.list = RS.fMRI_4.7_Combining.Functional.Connectivity(Excluding_Not_Defined_ROIs.list)
  cat("\n", crayon::red("Step 4.7."), crayon::yellow("Combining Functional Connectivity"), crayon::blue("is done !!") ,"\n")


  #==================================================================================================
  # 8) Data saving
  #==================================================================================================
  RS.fMRI_4.8_Saving.Data(Combining_Functional_Connectivity.list, path_save, atlas)
  cat("\n", crayon::red("Step 4.8."), crayon::yellow("Saving data for each group"), crayon::blue("is done !!") ,"\n")


  cat("\n", crayon::bgRed("Step 4"), crayon::blue("is all done !!") ,"\n")
}

