RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC = function(Subjects_QC_ADNI2GO,
                                                           Subjects_QC_ADNI3,
                                                           path_Subjects.Lists_Downloaded,
                                                           what.date,
                                                           Include_RID = NULL,
                                                           Include_ImageID=NULL,
                                                           Exclude_RID = NULL,
                                                           Exclude_ImageID = NULL,
                                                           Exclude_Comments = NULL){
  ##############################################################################
  # Loading the datasets
  ##############################################################################
  path_Subjects.Lists_Downloaded = path_Subjects.Lists_Downloaded %>% path_tail_slash()
  QC_1.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Loading.Data(Subjects_QC_ADNI2GO, Subjects_QC_ADNI3, path_Subjects.Lists_Downloaded)
  text = "1.1 : Loading data is done."
  cat("\n", crayon::green(text), "\n")





  ##############################################################################
  # Selecting & Changing Series Type : MT1, T1, EPB, fMRI
  ##############################################################################
  QC_2.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Selecting.Changing.Series.Type(QC_1.list)
  text = "1.1 : Selecting Series Type is done."
  cat("\n", crayon::green(text), "\n")






  ##############################################################################
  # Selecting and Changing colnames
  ##############################################################################
  QC_3.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Selecting.Cols(QC_2.list)
  text = "1.1 : Selecting columns is done."
  cat("\n", crayon::green(text), "\n")





  ##############################################################################
  # Changing Each Descriptions
  ##############################################################################
  QC_4.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Changing.Description(QC_3.list)
  text = "1.1 : Changing Description is done."
  cat("\n", crayon::green(text), "\n")





  ##############################################################################
  # Binding ADNI2GO, ADNI3 QC
  ##############################################################################
  QC_5.df = dplyr::bind_rows(QC_4.list[[1]], QC_4.list[[2]])
  text = "1.1 : Binding the datasets is done."
  cat("\n", crayon::green(text), "\n")






  ##############################################################################
  # Excluding RID & Image ID
  ##############################################################################
  QC_6.df = QC_5.df
  QC_6.df$RID = as.character(QC_6.df$RID)
  QC_6.df = QC_6.df %>% filter(!RID %in% as.character(Exclude_RID)) %>% filter(!IMAGE_ID %in% as.character(Exclude_ImageID))


  Include_RID = Include_RID %>% as.character
  if(length(Include_RID)>0){
    QC_6.df = QC_6.df %>% filter(RID %in% Include_RID)
  }

  if(length(Include_ImageID)>0){
    QC_6.df = QC_6.df %>% filter(IMAGE_ID %in% Include_ImageID)
  }
  text = "1.1 : Excluding RID & ImageID is done."
  cat("\n", crayon::green(text), "\n")






  ##############################################################################
  # Filtering Data by QC & Excluding NA
  ##############################################################################
  QC_7.df = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Filtering.Data(QC_6.df, Exclude_Comments)
  text = "1.1 : Filtering good data is done."
  cat("\n", crayon::green(text), "\n")



  ##############################################################################
  # arrange by RID & DATE
  ##############################################################################
  QC_8.df = QC_7.df
  QC_8.df$RID = QC_8.df$RID %>% as.numeric
  QC_8.df = QC_8.df %>% arrange(RID, SERIES_DATE)
  QC_8.df$RID = QC_8.df$RID %>% as.character
  text = "1.1 : Arraging by RID and SERIES_DATE is done."
  cat("\n", crayon::green(text), "\n")




  ##############################################################################
  # Changing names
  ##############################################################################
  selected_cols = c("LONI_STUDY", "LONI_SERIES", "FMRI_PHASE_DIRECTION", "SERIES_DESCRIPTION", "SERIES_TYPE", "FIELD_STRENGTH", "FMRI_MEAN_SNR", "T1_ACCELERATED")
  names(QC_8.df)[which(names(QC_8.df) %in% selected_cols)] = paste0("IMAGING.PROTOCOL___", selected_cols)
  QC_8.df = QC_8.df %>% relocate(starts_with("IMAGING.PROTOCOL"), .after=SERIES_DATE)



  ##############################################################################
  # Select RID having by dates having both EPB & MT1
  ##############################################################################
  QC_9.list = RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Select.RID.Have.Both.Types(QC_8.df, what.date)



  #=============================================================================
  # final
  #=============================================================================
  ADNI_Subjects_QC = QC_9.list



  ##############################################################################
  # Returning reslts
  ##############################################################################
  text = paste("\n","Step 1.1 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(ADNI_Subjects_QC)
}
  # # blank or Not applicable (-1), Non Accelerated (0) Accelerated (1)
  # # The scan acceleration permits higher spatial resolution,
  # # increased temporal resolution, shorter scan duration, or a combination of these benefits.
  # # Along with the exciting developments is a dizzying proliferation of acronyms and variations of the techniques.
  # "T1_ACCELERATED",
  #





















#
#
#
# ##############################################################################
# # Exporting Description
# ##############################################################################
# RS.fMRI_1_Data.Selection___Select.RID.by.Image.QC___Exporting.Description = function(QC.df, ...){
#   ### Export : RS-fMRI, MPRAGE
#   ## path
#   path_Subjects_Description = paste(path_Subjects, "Selected Description of EPB & MT1", sep="")
#   dir.create(path_Subjects_Description, showWarnings = F)
#   ## select
#   series_description_EPB = data_series_type[have_this(data_series_type$SERIES_TYPE, this="EPB", exact=T, as.ind = T),]
#   series_description_MT1 = data_series_type[have_this(data_series_type$SERIES_TYPE, this="MT1", exact=T, as.ind = T),]
#   ## writing
#   write.table(series_description_EPB$SERIES_DESCRIPTION %>% unique,
#               paste(path_Subjects_Description, "[Description] RS-fMRI.csv", sep = "/"),
#               row.names=F,
#               col.names=F);series_description_EPB=NULL
#   write.table(series_description_MT1$SERIES_DESCRIPTION %>% unique,
#               paste(path_Subjects_Description, "[Description] MT1.csv", sep = "/"),
#               row.names=F,
#               col.names=F);series_description_MT1=NULL
#   text = "1.1 : Exporting 'Description' of EPB, MT1 as csv files is done."
#   cat("\n", crayon::green(text), "\n")
# }
#
#
#
#
#
# #=============================================================================
# # RID
# #=============================================================================
# # Extract RID from PTID
# data_RID.NA = RS.fMRI_1.1_Merging.Search.with.QC___Extract.RID(data_ImageID)
# text = "1.1 : Removing NA in RID & PTID is done."
# cat("\n", crayon::green(text), "\n")
#
#







