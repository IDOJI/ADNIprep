RS.fMRI_1.3_Exporting.Lists___Export.All.Subjects.Info = function(data.list, path_Subjects, path_Rda){
  ### loading data =====================================================================
  EPB = data.list[[1]]
  MT1 = data.list[[2]]


  ### Creating directory ===============================================================
  list_names = "0.All_Subjects"
  dir.create(paste(path_Subjects, list_names, sep=""), showWarnings = F)
  sub_path = paste(path_Subjects, list_names, sep="")


  ## Image ID ==========================================================================
  All_ImageID = c(EPB$IMAGE_ID, MT1$IMAGE_ID)
  filename = paste0("[Final_Selected]_ImageID_(",list_names,")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Image.ID(All_ImageID, filename, sub_path)


  ### csv file ==========================================================================
  EPB.csv = paste0("[Final_Selected]_Subjects_list_EPB_(",list_names, ")")
  MT1.csv = paste0("[Final_Selected]_Subjects_list_MT1_(",list_names, ")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Subjects.List.CSV(EPB, sub_path, EPB.csv)
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.Subjects.List.CSV(MT1, sub_path, MT1.csv)


  ### Exporting subjects for SNP ==========================================================================
  filename = paste0("[Final_Selected]_keep_RID_for_SNP", "_(", list_names,")")
  RS.fMRI_1.3_Exporting.Lists___SUB_Exporting.RID.for.SNP(EPB, sub_path, filename)



  ### Exporting comments ==========================================================================





  ### Exporting TSV ==========================================================================



  return(data.list)
}
