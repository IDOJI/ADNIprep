RS.fMRI_1_Data.Selection___Demographics = function(Merged_Diagnosis.list, path_Subjects.Lists_Downloaded, Subjects_APOE){
  #=============================================================================
  # Handedness
  #=============================================================================
  Handedness.list = RS.fMRI_1_Data.Selection___Demographics___Handedness(Merged_Diagnosis.list)




  #=============================================================================
  # Gender
  #=============================================================================
  Gender.list = RS.fMRI_1_Data.Selection___Demographics___Gender(Handedness.list)




  #=============================================================================
  # Retirement
  #=============================================================================
  Retire.list = RS.fMRI_1_Data.Selection___Demographics___Retirement(Gender.list)





  #=============================================================================
  # Education
  #=============================================================================
  Education.list = RS.fMRI_1_Data.Selection___Demographics___Education(Retire.list)





  #=============================================================================
  # Marital status
  #=============================================================================
  Marriage.list = RS.fMRI_1_Data.Selection___Demographics___Marriage(Education.list)





  #=============================================================================
  # APOE
  #=============================================================================
  APOE.list = RS.fMRI_1_Data.Selection___Demographics___APOE(Marriage.list, path_Subejcts_APOE, Subjects_APOE)





  #=============================================================================
  # Binding
  #=============================================================================
  Binded.df = RS.fMRI_1_Data.Selection___Demographics___Combining.Data(APOE.list)




  #=============================================================================
  # Selecting demographic variable
  #=============================================================================
  Demo.df = RS.fMRI_1_Data.Selection___Demographics___Demographic.Variables(Binded.df)




  #=============================================================================
  # Split
  #=============================================================================
  Selected_Subjects.df = Demo.df[!is.na(Demo.df$STUDY.DATE),]
  Selected_Subjects.df = Selected_Subjects.df[-which(Selected_Subjects.df$CLIELG___CENROLL==0), ]



  #=============================================================================
  # Adding numbering and Filenames by Manufacturer
  #=============================================================================
  Added_Numbering.list = RS.fMRI_1_Data.Selection___Demographics___Adding.Numbering.By.Manufacturers(Binded.list)



  Combined.list = list(Selected_Subjects.df, Demo.df)







  cat("\n", crayon::green("Extracting Demographics is done!") ,"\n")
  return(Demo.df)
}




