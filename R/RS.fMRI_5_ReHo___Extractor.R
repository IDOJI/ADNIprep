RS.fMRI_5_ReHo___Extractor = function(path_Sub, path_Export, Pipeline){
  #=============================================================================
  # Exporting results
  #=============================================================================
  path_Sub_List = list.files(path_Sub, full.names=T)

  Results = sapply(seq_along(path_Sub_List), function(i, ...){
    # i=126
    y = path_Sub_List[i]
    ith_RID = basename(y) %>% str_extract("RID_\\d+")
    path_Results = list.files(y, full.names=T, pattern = "Results")
    path_ReHo_Folder = list.files(path_Results, full.names=T, pattern=paste0("ReHo", "_", Pipeline)) %>% filter_by(Pipeline)


    # path files
    path_Files = list.files(path_ReHo_Folder, full.names=T)
    Files = list.files(path_ReHo_Folder)


    # Renamed_files
    Sub_Num = str_extract(Files, "_Sub_\\d+")
    Renamed_Files = paste(ith_RID, "ReHo", Pipeline, str_replace(Files, Sub_Num, ""), sep = "___")



    # copying files
    # mReHo
    destination = c(paste0(path_Export, "/", paste0(Pipeline, "___", "mReHoMap")),
                    paste0(path_Export, "/", paste0(Pipeline, "___", "ReHoMap")),
                    paste0(path_Export, "/", paste0(Pipeline, "___", "zReHoMap")))
    copy_files(path = path_Files, destination = destination, rename_to = Renamed_Files, overwrite = F)

  })
  cat("\n",crayon::blue("Extracting ReHoMap is done!"),"\n")


}
