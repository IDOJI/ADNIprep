RS.fMRI_1.3_Diagnosis = function(Merged_Lists.df,
                                 path_Subjects_BLCHANGE,
                                 path_Subjects_DX_Summary){
  #===============================================================================
  # Combining Data
  #===============================================================================
  Merged_Diagnosis.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames(Merged_Lists.df, path_Subjects_BLCHANGE, path_Subjects_DX_Summary)




  #===============================================================================
  # Calculating times till AD
  #===============================================================================
  Time_To_First_AD.list = RS.fMRI_1.3_Diagnosis___Time.To.First.AD(Merged_Diagnosis.list)




  #===============================================================================
  # Extracting Demographics & Data binding
  #===============================================================================
  Binded.list = RS.fMRI_1.3_Diagnosis___Extract.Demographics(Time_To_First_AD.list)





  cat("\n", crayon::bgMagenta("STEP 1.3"), crayon::green("Deciding Diagnosis is done!") ,"\n")
  return(Binded.list)
}










































