RS.fMRI_3.1.Before.Preprocessing___Moving.Sub.Folders.For.Repreprocessing___Specific.Folders = function(from, specific){
  #===========================================================================
  # from path
  #===========================================================================
  from_slash = from %>% path_tail_slash(add_slash = T)
  from_no_slash = from %>% path_tail_slash(add_slash = F)


  #===========================================================================
  # specific
  #===========================================================================
  specific_fitted = fit_length(specific %>% as.character(), 3)
  specific_sub = paste0("Sub_", specific_fitted)


  #===========================================================================
  # Folders
  #===========================================================================
  from_path = c(paste0(from_slash, "FunRaw"), paste0(from_slash, "T1Raw"), paste0(from_slash, "FunImg"), paste0(from_slash, "T1Img"))

  lapply(specific_sub, FUN=function(ith_sub, ...){
    # ith_sub = specific_sub[1]
    from_path_ith_sub = paste0(from_path, "/", ith_sub)

    #---------------------------------------------------------------------------
    to_path = paste0(from_no_slash, "___", ith_sub, "/")
    to_path2 = c(paste0(to_path, "FunRaw/", ith_sub), paste0(to_path, "T1Raw/", ith_sub),
                paste0(to_path, "FunImg/", ith_sub), paste0(to_path, "T1Img/", ith_sub))

    for(i in 1:length(to_path2)){
      copy_files_fast(Source.Folder = from_path_ith_sub[i], Destination.Folder = to_path2[i], move = T)
    }
    # tif files ----------------------------------------------------------------
    from_tif_path = paste0(from_slash, ith_sub, ".tif")
    filesstrings::file.move(files = from_tif_path, destinations = to_path, overwrite = T)
    cat(crayon::red(ith_sub), crayon::green("is moved completely !"))
  })
  cat(crayon::yellow("All files are moved clearly !"))
}

























