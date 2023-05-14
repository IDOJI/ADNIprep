RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info___Export.Divided.List = function(data.list,
                                                                                             index=NULL,
                                                                                             Manufacturer,
                                                                                             path_Subjects.Lists.Exported){
  # data.list = data.list[[1]]
  EPB = data.list$EPB
  MT1 = data.list$MT1
  list_names = Manufacturer

  ### Creating directory ===============================================================
  if(!is.null(index)){
    folder.name = paste(index, list_names, sep=".")
  }else{
    folder.name = list_names
  }
  dir.create(paste(path_Subjects.Lists.Exported, folder.name, sep=""), showWarnings = F)
  sub_path = paste(path_Subjects.Lists.Exported, folder.name, sep="")


  ## Image ID ==========================================================================
  ID = c(EPB$IMAGE_ID, MT1$IMAGE_ID)
  filename = paste0("[Final_Selected]_ImageID_(",list_names,")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Image.ID(ID, filename, sub_path)


  ### csv file ==========================================================================
  EPB.csv = paste0("[Final_Selected]_Subjects_list_EPB_(",list_names, ")")
  MT1.csv = paste0("[Final_Selected]_Subjects_list_MT1_(",list_names, ")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Subjects.List.CSV(EPB, sub_path, EPB.csv)
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Subjects.List.CSV(MT1, sub_path, MT1.csv)


  ### Exporting SliceOrderInfo ==========================================================================
  filename = paste0("SliceOrderInfo(",list_names, ")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Export.SliceOrderInfo(path = sub_path, EPB = EPB, filename = filename)


  ### Exporting subjects for SNP ==========================================================================
  filename = paste0("[Final_Selected]_keep_RID_for_SNP", "_(", list_names,")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.RID.for.SNP(EPB, sub_path, filename)


  # ### Exporting rdata ==========================================================================
  # EPB_filename = paste("RS.fMRI", "EPB", list_names, sep="_")
  # MT1_filename = paste("RS.fMRI", "MT1", list_names, sep="_")
  # saving_data(EPB_filename, df = EPB, path = path_Rda)
  # saving_data(MT1_filename, df = EPB, path = path_Rda)

  ### ======================================================================================================
  text1 = crayon::yellow("Exporting Subjects' Information of")
  text2 = crayon::red(paste0(EPB$PROTOCOL.FMRI___MANUFACTURER[1], "_", EPB$FMRI___SLICE.BAND.TYPE[1]))
  text3 = crayon::yellow("is done!")
  cat("\n", text1, text2, text3,"\n")
}
