RS.fMRI_5_BOLD.Signals___Voxelwise___Error.Handling___Remove.FC.Related.Files = function(path_Sub.Folders, result.folder.name){
  # path_Sub.Folders = Error_path_GE
  Results = sapply(path_Sub.Folders, function(y){
    RID = basename(y) %>% str_extract("RID_\\d+")
    path_FCROI.Mask = list.files(y, full.names=T, pattern = "Masks") %>% list.files(full.names=T, pattern = "FCROI_")
    path_ROI.Signals = list.files(y, full.names=T, pattern = "Results") %>% list.files(full.names=T,pattern = result.folder.name) %>% filter_by(c("ROISignals_", ".nii"), any_include = T)
    path_FCMap = list.files(y, full.names=T, pattern = "Results") %>% list.files(full.names=T,pattern = result.folder.name) %>% filter_by(c("FC_", ".nii"), any_include = T)
    path_TRInfo = list.files(y, full.names=T, pattern = "TRInfo.tsv")
    path_AutoSave = list.files(y, full.names=T, pattern = "DPARSFA_AutoSave_")





    try(fs::file_delete(path_AutoSave), silent = T)
    cat("\n", crayon::yellow("Removing AutoSave file is done :"), crayon::red(RID) ,"\n")



    try(fs::file_delete(path_TRInfo), silent = T)
    cat("\n", crayon::yellow("Removing TRInfo file is done :"), crayon::red(RID) ,"\n")


    try(fs::file_delete(path_FCROI.Mask), silent = T)
    cat("\n", crayon::yellow("Removing FCROI.nii file is done :"), crayon::red(RID) ,"\n")

    try(fs::dir_delete(path_ROI.Signals), silent = T)
    cat("\n", crayon::yellow("Removing ROISignals folder is done :"), crayon::red(RID) ,"\n")


    try(fs::dir_delete(path_FCMap), silent = T)
    cat("\n", crayon::yellow("Removing FCMap folder is done :"), crayon::red(RID) ,"\n")
  })


  cat("\n",crayon::blue("Removing FC-related files is done!"),"\n")
}
