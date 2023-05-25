RS.fMRI_3.2_Moving.Subjects.with.Abnormal.Normalization.Pictures = function(path_Preprocessing.Completed,
                                                                               path_Normalization.Pictures_Excluding,
                                                                               Sub.Num_GE.MEDICAL.SYSTEMS_SB = NULL,
                                                                               Sub.Num_Philips_SB = NULL,
                                                                               Sub.Num_SIEMENS_SB = NULL,
                                                                               Sub.Num_SIEMENS_MB = NULL){
  # Sub.Num은 숫자 형태로 입력 해서 sub 형태로 변환
  #=============================================================================
  # create destination
  #=============================================================================
  dir.create(path_Normalization.Pictures_Excluding, F)



  #=============================================================================
  # Moving files by manufacture
  #=============================================================================
  Manufacturers.list = list(Sub.Num_GE.MEDICAL.SYSTEMS_SB, Sub.Num_Philips_SB, Sub.Num_SIEMENS_SB, Sub.Num_SIEMENS_MB)
  Manufacturers = c("GE.MEDICAL.SYSTEMS_SB", "Philips_SB", "SIEMENS_SB", "SIEMENS_MB")
  for(i in 1:length(Manufacturers.list)){
    if(!is.null(Manufacturers.list[[i]])){
      # Adding "Sub" before numbers
      ith_Sub.Num = paste0("Sub_", fit_length(Manufacturers.list[[i]], fit.num = 3))

      sapply(ith_Sub.Num, FUN=function(kth_Sub.Num, ...){
        kth_folder_path = list.files(path_Preprocessing.Completed, pattern = paste0(Manufacturers[i], "___", kth_Sub.Num), full.names = T)
        kth_folder      = list.files(path_Preprocessing.Completed, pattern = paste0(Manufacturers[i], "___", kth_Sub.Num), full.names = F)
        fs::file_move(path = kth_folder_path, new_path = paste0(path_Normalization.Pictures_Excluding, "/", kth_folder))

        cat("\n", crayon::green("Folder is moved : "), crayon::red(kth_folder),"\n")
      })
    }

  }
  cat("\n", crayon::bgMagenta("Step 3.3"), crayon::red("Excluding Subjects with Abnormal Normalizatoin Pictures"), crayon::blue("is done!"),"\n")
}
