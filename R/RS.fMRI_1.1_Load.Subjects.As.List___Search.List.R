RS.fMRI_1.1_Load.Subjects.As.List___Search.List = function(subjects_search,
                                                           path_Subjects.Lists.Downloaded,
                                                           Exclude_RID = NULL){
  ### 1.Loading data ======================================================================
  Search_1.df = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Loading.Data(subjects_search, path_Subjects.Lists.Downloaded)
  cat("\n", crayon::green("1.1.1 : Loading data is done."), "\n")


  ### 2.RID 생성, 제외, 정렬 ===================================================
  Search_2.df = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Extract.Arrange.RID(Search_1.df, Exclude_RID)
  cat("\n", crayon::green("1.1.1 : Extracting & arranging RID is done."), "\n")


  ### 3.Date 정렬 =================================================================
  Search_3.df = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Rearrange.Date(Search_2.df)
  cat("\n", crayon::green("1.1.1 : Rerranging dates is done."), "\n")


  ### 4.image ID ==================================================================
  Search_4.df = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___ImageID(Search_3.df)
  cat("\n", crayon::green("1.1.1 : Removing NA & Adding 'I' in ImageID is done."), "\n")



  ### 5.changing & Exclude Phase ================================================================
  Search_5.df = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Change.Exclude.Phase(Search_4.df)
  cat("\n", crayon::green("1.1.1 : Changing & Excluding Phase is done."), "\n")



  # ### 8.Selecting having both fMRI and MRI ===============================================================
  # Search_8.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Selecting.Data.Having.Both(Search_7.list)
  # cat("\n", crayon::green("1.1.1 : Selecting having both fMRI and MRI"), "\n")




  ### Exporting ===============================================================
  ADNI_Subjects_Search = Search_5.df



  ### returning results
  text = paste("\n","Step 1.1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_Search)
}














