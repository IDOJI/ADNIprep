RS.fMRI_5_Voxelwise.Signals___Check.Zero.Signals = function(path_Extracted.Voxel.Wise.BOLD.Signals, file.name.pattern = "Voxelwise.BOLD.Signals.rds"){
  #=============================================================================
  # path for each data
  #=============================================================================
  path_Files = list.files(path_Extracted.Voxel.Wise.BOLD.Signals, pattern = file.name.pattern, full.names=T)


  #=============================================================================
  # check each file
  #=============================================================================
  Check_Zeros.list = lapply(path_Files, function(ith_path){
    ith_data.list = readRDS(ith_path)

    ith_which.region.have.zero = lapply(ith_data.list, function(jth_region){
      sum(jth_region == 0) > 1
    }) %>% unlist %>% unname

    cat("\n", crayon::red(basename(ith_path)), crayon::blue("is being checked"), "\n")

    if(sum(ith_which.region.have.zero)>0){
      return(ith_which.region.have.zero)
    }else{
      return(NA)
    }
  })





  #=============================================================================
  # which is NA
  #=============================================================================
  index = Check_Zeros.list %>% is.na %>% which
  if(length(index)==length(Check_Zeros.list)){


    cat("\n", crayon::green("Congratulations! There are no zeros on Voxelwise BOLD signals!"), "\n")


  }else if(length(Check_Zeros.list)>1){
    which_Region_have_zeros = Check_Zeros.list[-index]
    names(which_Region_have_zeros) = path_Files[-index]

    #=============================================================================
    # each brain regions signals
    #=============================================================================
    Only_Zero_Regions = lapply(seq_along(which_Region_have_zeros), function(k,...){
      kth_Subject = readRDS(names(which_Region_have_zeros)[k])
      kth_Subject_Zero = kth_Subject[which_Region_have_zeros[[k]]]
      return(kth_Subject_Zero)
    })
    names(Only_Zero_Regions) = path_Files[-index]

    return(Only_Zero_Regions)
  }else if(length(Check_Zeros.list)==1){
    which_Region_have_zeros = Check_Zeros.list
    names(which_Region_have_zeros) = path_Files

    #=============================================================================
    # each brain regions signals
    #=============================================================================
    Only_Zero_Regions = readRDS(path_Files)[which_Region_have_zeros[[1]]] %>% list
    names(Only_Zero_Regions) = path_Files

    return(Only_Zero_Regions)
  }
}




