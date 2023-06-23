RS.fMRI_1.1_Load.Subjects.As.List___Search.List = function(Subjects_Search_FMRI,
                                                           Subjects_Search_MRI,
                                                           path_Subjects.Lists_Downloaded){
  ### 1.Loading data ======================================================================
  Search_1.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Loading.Data(Subjects_Search_FMRI,
                                                                                 Subjects_Search_MRI,
                                                                                 path_Subjects.Lists_Downloaded)
  cat("\n", crayon::green("1.1.1 : Loading data is done."), "\n")




  ### 2.RID 생성, 제외, 정렬 ===================================================
  Search_2.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Extract.Arrange.RID(Search_1.list)
  cat("\n", crayon::green("1.1.1 : Extracting & arranging RID is done."), "\n")




  ### 3.Date 정렬 =================================================================
  Search_3.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Rearrange.Date(Search_2.list)
  cat("\n", crayon::green("1.1.1 : Rerranging dates is done."), "\n")



  ### 4.image ID ==================================================================
  Search_4.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___ImageID(Search_3.list)
  cat("\n", crayon::green("1.1.1 : Removing NA & Adding 'I' in ImageID is done."), "\n")



  ### 5.changing & Exclude ADNI1 Phase ================================================================
  Search_5.list = RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Change.Exclude.Phase(Search_4.list)
  cat("\n", crayon::green("1.1.1 : Changing & Excluding Phase is done."), "\n")




  ### Exporting ===============================================================
  ADNI_Subjects_Search = Search_5.list



  ### returning results
  text = paste("\n","Step 1.1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_Search)
}














