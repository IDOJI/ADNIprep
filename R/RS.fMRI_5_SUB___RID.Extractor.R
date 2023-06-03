RS.fMRI_5_SUB___RID.Extractor = function(path_All.Subjects.EPB.List.File, path_Preprocessing.Completed, Manufacturer = c("Philips", "GE.MEDICAL.SYSTEMS", "SIEMENS"), Band.Type = c("SB", "MB")){
  EPB.df = read.csv(path_All.Subjects.EPB.List.File)
  Sub_Folders = list.files(paste0(path_Preprocessing.Completed %>% path_tail_slash(), "FunImgAR"), pattern="Sub_")
  Selected_EPB.df = EPB.df %>% filter(Manufacturer_New==paste(Manufacturer, Band.Type, sep="_") & Sub_Num %in% Sub_Folders)
  return(Selected_EPB.df$RID)

}
