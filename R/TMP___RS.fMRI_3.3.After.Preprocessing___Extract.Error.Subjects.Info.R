RS.fMRI_3.2.During.Preprocessing___Check.NIFTI.Converting___Moving.Redownloaded.NIFTI = function(manu_path, manu_redownloaed_path){
  ### loading lists
  EPB.df = read.csv(list.files(manu_path, pattern = "EPB", full.names=T)[2])[-1]
  MT1.df = read.csv(list.files(manu_path, pattern = "MT1", full.names=T)[2])[-1]


  ### moving EPB NIFTI files
  EPB_LONI = EPB.df$LONI_SERIES
  EPB_SUB  = EPB.df$Sub_folders
  lapply(EPB_LONI, FUN=function(ith_EPB_ID, ...){
    #ith_EPB_ID = EPB_LONI[1]
    ind = which(EPB_LONI == ith_EPB_ID)

    from_path = path_until_pattern(path = manu_redownloaed_path, until_pattern = ith_EPB_ID)
    to_path = paste0(manu_path, "FunImg/", EPB_SUB[ind])
    copy_files_fast(Source.Folder = from_path,
                    Destination.Folder = to_path,
                    move = T,
                    overwrite = F)

  })
  cat("\n", crayon::blue("Moving all the "), crayon::red("EPB NIFTI"), crayon::blue("files are done !"),"\n")



  ### moving MT1 NIFTI files
  MT1_LONI = MT1.df$LONI_SERIES
  MT1_SUB  = MT1.df$Sub_folders
  lapply(MT1_LONI, FUN=function(ith_MT1_ID, ...){
    #ith_MT1_ID = MT1_LONI[1]
    ind = which(MT1_LONI == ith_MT1_ID)

    from_path = path_until_pattern(path = manu_redownloaed_path, until_pattern = ith_MT1_ID)
    to_path = paste0(manu_path, "T1Img/", MT1_SUB[ind])
    copy_files_fast(Source.Folder = from_path,
                    Destination.Folder = to_path,
                    move = T,
                    overwrite = F)

  })
  cat("\n", crayon::blue("Moving all the "), crayon::red("MT1 NIFTI"), crayon::blue("files are done !"),"\n")

}


