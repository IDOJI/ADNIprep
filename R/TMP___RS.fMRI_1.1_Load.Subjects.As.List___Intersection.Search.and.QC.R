RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC = function(subjects.list){
  # Image ID
  ImageID_subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Image.ID(subjects.list)


  # RID
  RID_subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Intersection.by.RID(ImageID_subjects.list)


  # Dates
  Date_subjects.list = RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Dates(RID_subjects.list)


  text = paste("\n","Step 1.1.3 is done !","\n")
  cat(crayon::bgMagenta(text))

  return(Date_subjects.list)
}
