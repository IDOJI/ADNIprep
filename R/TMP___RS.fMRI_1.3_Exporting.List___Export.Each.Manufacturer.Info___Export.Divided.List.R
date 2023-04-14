RS.fMRI_1.3_Exporting.List___Export.Each.Manufacturer.Info___Export.Divided.List = function(data.list, list_names, path_Subjects){
  EPB = data.list[[1]]
  MT1 = data.list[[1]]

  ### Creating directory ===============================================================
  dir.create(paste(path_Subjects, list_names, sep=""), showWarnings = F)
  sub_path = paste(path_Subjects, list_names, sep="")


  ## Image ID ==========================================================================
  ID = c(EPB$IMAGE_ID, MT1$IMAGE_ID)
  filename = paste0("[Final_Selected]_ImageID_(",list_names,")")
  RS.fMRI_1.3_Exporting.List___SUB_Exporting.Image.ID(ID, filename, sub_path)


  ### csv file ==========================================================================
  EPB.csv = paste0("[Final_Selected]_Subjects_list_EPB_(",list_names, ")")
  MT1.csv = paste0("[Final_Selected]_Subjects_list_MT1_(",list_names, ")")
  RS.fMRI_1.3_Exporting.List___SUB_Exporting.Subjects.List.CSV(EPB, sub_path, EPB.csv)
  RS.fMRI_1.3_Exporting.List___SUB_Exporting.Subjects.List.CSV(MT1, sub_path, MT1.csv)


  ### Exporting SliceOrderInfo ==========================================================================
  filename = paste0("SliceOrderInfo(",list_names, ")")
  RS.fMRI_1.3_Exporting.List___SUB_Export.SliceOrderInfo(EPB, sub_path, filename)


  ### Exporting subjects for SNP ==========================================================================
  filename = paste0("[Final_Selected]_keep_RID_for_SNP", "_(", list_names,")")
  RS.fMRI_1.3_Exporting.List___SUB_Exporting.RID.for.SNP(EPB, sub_path, filename)


  ### Exporting rdata ==========================================================================
  EPB_filename = paste("RS.fMRI", "EPB", EPB$MANUFACTURER[1], sep="_")
  MT1_filename = paste("RS.fMRI", "MT1", MT1$MANUFACTURER[1], sep="_")
  saving_data(EPB_filename, df = EPB, path = path_Rda)
  saving_data(MT1_filename, df = EPB, path = path_Rda)

  ### ======================================================================================================
  text1 = crayon::yellow("Exporting Subjects' Information of")
  text2 = crayon::red(EPB$MANUFACTURER[1])
  text3 = crayon::yellow("is done!")
  cat("\n", text1, text2, text3,"\n")
}


