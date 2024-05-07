RS.fMRI_1_Data.Selection___Imaging.Protocol = function(Demographics.df){
  #=============================================================================
  # Select Protocol satisfying subjects
  #=============================================================================
  Selected_Subjects.df = Demographics.df[!is.na(Demographics.df$STUDY.DATE),]
  Selected_Subjects.df = Selected_Subjects.df[-which(Selected_Subjects.df$CLIELG___CENROLL==0), ]



  #=============================================================================
  # Imaging protocol split
  #=============================================================================
  Combined.df = RS.fMRI_1_Data.Selection___Imaging.Protocol___Protocol.Split(Selected_Subjects.df)



  #=============================================================================
  # Adding numbering and Filenames by Manufacturer
  #=============================================================================
  Added_Numbering.df = RS.fMRI_1_Data.Selection___Imaging.Protocol___Adding.Numbering.By.Manufacturers(Combined.df)


  return(Added_Numbering.df)
}
