RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Changing.Description = function(QC.list, ...){

  QC_1 = QC.list[[1]]
  QC_2 = QC.list[[2]]

  ##############################################################################
  # ADNI2GO
  ##############################################################################
  QC_1$RID = QC_1$RID %>% as.character
  QC_1$SERIES_DATE = lubridate::ymd(QC_1$SERIES_DATE) %>% as.character



  ##############################################################################
  # ADNI3
  ##############################################################################
  # adding head
  QC_2$RID = QC_2$RID %>% as.character
  QC_2$LONI_SERIES = paste0("S", QC_2$LONI_SERIES)
  QC_2$IMAGE_ID =  paste0("I", QC_2$IMAGE_ID)
  QC_2$SERIES_DATE = substr(QC_2$SERIES_DATE, 1, 10)

  return(list(QC_1, QC_2))
}
