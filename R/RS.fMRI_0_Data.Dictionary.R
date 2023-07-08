# Clipboard_to_path()
RS.fMRI_0_Data.Dictionary = function(colname, path_Data.Dic =  "C:/Users/lleii/Dropbox/Github/Papers___Data/Papers___Data___ADNI___RS.fMRI___Subjects.Lists/___Subjects_Lists_Downloaded/ADNI_data_dictionary.csv"){

  # install_package("Hmisc")
  # install.packages("C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/ADNIMERGE/ADNIMERGE_0.0.1.tar.gz", repose = NULL, type="source")
  # install.packages("/Users/Ido/Library/CloudStorage/Dropbox/Github/Rpkgs/ADNIprep/ADNIMERGE/ADNIMERGE_0.0.1.tar.gz")
  # require(ADNIMERGE)
  dic = read.csv(path_Data.Dic)

  colname = toupper(colname)

  selected_col = dic %>% filter(FLDNAME == colname)
  if(nrow(selected_col)>0){
    return(selected_col)
  }else{
    cat("\n", crayon::red("There is no such colname!"),"\n")
  }
}
