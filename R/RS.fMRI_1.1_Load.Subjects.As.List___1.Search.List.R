RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List = function(subjects_search_fMRI, subjects_search_MRI, path_Subjects_Downloaded, path_Rda){
  ### 1.Loading data ======================================================================
  Search_1.list = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Loading.Data(subjects_search_fMRI, subjects_search_MRI, path_Subjects_Downloaded)
  cat("\n", crayon::green("1.1.1 : Loading data is done."), "\n")


  ### 2.Protocol split ====================================================================
  Search_2.list = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Protocol.Split(Search_1.list)
  cat("\n", crayon::green("1.1.1 : Splitting the protocol is done."), "\n")



  ### 3.MRI_, fMRI_ 이름 추가 & 데이터 병합 ====================================================================
  Search_3.df = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Add.MRI.fMRI.Names(Search_2.list)
  cat("\n", crayon::green("1.1.1 : Combining & Adding variable names is done."), "\n")



  ### 4.RID 추가, 정렬, NA 제거 ===================================================
  Search_4.df = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Extract.Arrange.RID(Search_3.df)
  cat("\n", crayon::green("1.1.1 : Extracting & arranging RID is done."), "\n")



  ### 5.Date 정렬 =================================================================
  Search_5.df = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Rearrange.Date(Search_4.df)
  cat("\n", crayon::green("1.1.1 : Rerranging dates is done."), "\n")


  ### 6.image ID ==================================================================
  Search_6.df = RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___ImageID(Search_5.df)
  cat("\n", crayon::green("1.1.1 : Removing NA & Adding 'I' in ImageID is done."), "\n")



  ### 7.changing Phase ================================================================
  Search_7.df = Search_6.df
  Search_7.df$PHASE = gsub(pattern = " ", replacement = "", Search_7.df$PHASE)
  text = "1.1.1 : Changing Phase is done."
  cat("\n", crayon::green(text), "\n")



  ### saving data ===================================================================
  ADNI_Subjects_1.Search =  Search_7.df
  # if(is.null(path_Rda)){
  #   setwd(path_Rda)
  #   usethis::use_data(ADNI_Subjects_1.Search, overwrite=T)
  # }
  # text = "1.1.1 : Saving rda is done."
  # cat("\n", crayon::green(text), "\n")



  ### returning results
  text = paste("\n","Step 1.1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_1.Search)
}














