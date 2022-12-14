RS.fMRI_4. = function(path_ADNI, exclude.list, save.path=NULL){
  #==================================================================================================
  # 0) path
  #==================================================================================================
  path_ADNI_RS.fMRI = paste0(path_ADNI, "/", "ADNI_RS.fMRI")



  #==================================================================================================
  # 1) Pre Steps
  #==================================================================================================
  # 1-1) Moving Bad Raw files
  RS.fMRI_4.1_Pre.Steps___Moving.Bad.Subjects.Raw.Files(path_ADNI_RS.fMRI, exclude.list)
  # 1-2) Extracting Folders Path
  Excluding_List_with_Path.list = RS.fMRI_4.1_Pre.Steps___Extracting.Each.Folders.Path(path_ADNI_RS.fMRI, exclude.list)
  cat("\n", crayon::red("Step 4.1"), crayon::yellow("Extracting each folders' path"), crayon::blue("is done !!") ,"\n")




  #==================================================================================================
  # 2) Extracting Results
  #==================================================================================================
  Extracted_Data.list = list()
  # 2-1) ROI Signals
  Extracted_Data.list[[1]] = ROI_Signals.list = RS.fMRI_4.2_Extracting.Results___ROI.Signals(Excluding_List_with_Path.list, save.path = "C:/Users/IDO/Dropbox/Github/Rpkgs/Papers/data")
  names(Extracted_Data.list)[1] = "ROI.Signals"
  cat("\n", crayon::red("Step 4.2.1."), crayon::yellow("Extracting ROI Signals"), crayon::blue("is done !!") ,"\n")
  # 2-2) Functional Connectivity
  Extracted_Data.list[[2]] = Functional_Connectivity.list = RS.fMRI_4.2_Extracting.Results___Functional.Connectivity(Excluding_List_with_Path.list, save.path = "C:/Users/IDO/Dropbox/Github/Rpkgs/Papers/data")
  names(Extracted_Data.list)[2] = "Functional.Connectivity"
  cat("\n", crayon::red("Step 4.2.2."), crayon::yellow("Extracting Functional Connectivity"), crayon::blue("is done !!") ,"\n")
  # 2-3) Extracating VMHC
  cat("\n", crayon::red("Step 4.2.3."), crayon::yellow("Extracting VMHC"), crayon::blue("is done !!") ,"\n")



  #==================================================================================================
  # 3) Combining Results
  #==================================================================================================
  Combined_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information(Extracted_Data.list, path_ADNI)
  cat("\n", crayon::red("Step 4.3."), crayon::yellow("Combining subjects information"), crayon::blue("is done !!") ,"\n")



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
