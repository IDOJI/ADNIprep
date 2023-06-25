RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Loading.Data = function(subjects_QC_ADNI2GO, subjects_QC_ADNI3, path_Subjects_Downloaded){
  if(grep("csv", subjects_QC_ADNI2GO) %>% length  == 0){
    subjects_QC_ADNI2GO = paste(subjects_QC_ADNI2GO, ".csv", sep="")
  }
  if(grep("csv", subjects_QC_ADNI3) %>% length  == 0){
    subjects_QC_ADNI3 = paste(subjects_QC_ADNI3, ".csv", sep="")
  }
  QC_ADNI2 = read.csv(file = paste(path_Subjects_Downloaded, subjects_QC_ADNI2GO, sep = ""))
  QC_ADNI3 = read.csv(file = paste(path_Subjects_Downloaded, subjects_QC_ADNI3, sep = ""))


  ### as_tibble
  QC_ADNI2 = dplyr::as_tibble(QC_ADNI2)
  QC_ADNI3 = dplyr::as_tibble(QC_ADNI3)

  ### names to upper
  names(QC_ADNI2) = names(QC_ADNI2) %>% toupper
  names(QC_ADNI3) = names(QC_ADNI3) %>% toupper


  ### rm dup rows
  QC_ADNI2 = QC_ADNI2 %>% unique
  QC_ADNI3 = QC_ADNI3 %>% unique

  return(list(QC_ADNI2, QC_ADNI3))
}

