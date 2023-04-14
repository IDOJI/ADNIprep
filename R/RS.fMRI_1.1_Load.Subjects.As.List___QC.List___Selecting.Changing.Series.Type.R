RS.fMRI_1.1_Load.Subjects.As.List___QC.List___Selecting.Changing.Series.Type = function(QC.list, ...){
  QC_1 = QC.list[[1]]
  QC_2 = QC.list[[2]]

  QC_1 = QC_1[union(which(QC_1$SERIES_TYPE == "fMRI"), which(QC_1$SERIES_TYPE == "T1")), ]
  QC_2 = QC_2[union(which(QC_2$SERIES_TYPE == "EPB"), which(QC_2$SERIES_TYPE == "MT1")), ]

  ### 통일
  QC_1 = change_description(QC_1, which.col = "SERIES_TYPE", from = "fMRI", to = "EPB")
  QC_1 = change_description(QC_1, which.col = "SERIES_TYPE", from = "T1", to = "MT1")

  return(list(QC_1, QC_2))
}

