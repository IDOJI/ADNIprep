RS.fMRI_1_Data.Selection___Loading.Lists___Search = function(  Selected_RID ,
                                                              Subjects_Search,
                                                              path_Subjects.Lists_Downloaded){
  ### 1.Loading data ======================================================================
  Search_1.df = RS.fMRI_1_Data.Selection___Loading.Lists___Search___Loading.Data(Subjects_Search,
                                                                               path_Subjects.Lists_Downloaded)
  cat("\n", crayon::green("1.1.1 : Loading data is done."), "\n")




  ### 2.RID 생성, 제외, 정렬 ===================================================
  Search_2.df = RS.fMRI_1_Data.Selection___Loading.Lists___Search___Extract.Arrange.RID(Search_1.df, Selected_RID)
  cat("\n", crayon::green("1.1.1 : Extracting & arranging RID is done."), "\n")




  ### 3.Date 정렬 =================================================================
  Search_3.df = RS.fMRI_1_Data.Selection___Loading.Lists___Search___Rearrange.Date(Search_2.df)
  cat("\n", crayon::green("1.1.1 : Rerranging dates is done."), "\n")



  ### 4.image ID ==================================================================
  Search_4.df = RS.fMRI_1_Data.Selection___Loading.Lists___Search___ImageID(Search_3.df)
  cat("\n", crayon::green("1.1.1 : Removing NA & Adding 'I' in ImageID is done."), "\n")



  ### 5.changing & Exclude ADNI1 Phase ================================================================
  Search_5.df = RS.fMRI_1_Data.Selection___Loading.Lists___Search___Change.Exclude.Phase(Search_4.df)
  names(Search_5.df) = paste0("SEARCH___", names(Search_5.df))
  cat("\n", crayon::green("1.1.1 : Changing & Excluding Phase is done."), "\n")



  ### 6. as list ===============================================================
  Search.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Data.df = Search_5.df)



  ### Exporting ===============================================================
  ADNI_Subjects_Search = Search.list


  ### returning results
  text = paste("\n","Step 1.1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_Search)
}














