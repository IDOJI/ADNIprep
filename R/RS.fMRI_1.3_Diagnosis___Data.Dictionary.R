RS.fMRI_1.3_Diagnosis___Data.Dictionary = function(colname){
  colname = toupper(colname)
  require(ADNIMERGE)
  selected_col = datadic %>% filter(FLDNAME == colname)
  if(nrow(selected_col)>0){
    return(selected_col)
  }else{
    cat("\n", crayon::red("There is no such colname!"),"\n")
  }
}
