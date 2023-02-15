RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer = function(data.list){
  ##############################################################################
  # Each Scanner list
  ##############################################################################
  scanners = c("SIEMENS", "Philips", "GE.MEDICAL.SYSTEMS")
  scanners_band.type = sapply(scanners, FUN=function(ith){
    c(paste0(ith, "_", "MB"), paste0(ith, "_", "SB")) %>% return
  })



  ##############################################################################
  # create a list to save results
  ##############################################################################
  selected.list = rep(NA, length(scanners_band.type)) %>% as.list
  names(selected.list) = scanners_band.type



  ##############################################################################
  # Each Scanner list
  ##############################################################################
  preprocessed.folders = names(data.list)
  for(i in 1:length(scanners_band.type)){
    which_selected_folders = grep(pattern = scanners_band.type[i], preprocessed.folders)
    if(length(which_selected_folders)>0){
      selected.list[[i]] = combine_lists_as_list(data.list[which_selected_folders])
    }
  }



  ##############################################################################
  # Remove NA
  ##############################################################################
  selected.list = selected.list[!is.na(selected.list)]
  
  
  
  
  ##############################################################################
  ### Ordering by "Sub"
  ##############################################################################
  Ordered_by_Sub.list = lapply(selected.list, FUN=function(ith_manu.list){
    ith_manu.list[order(names(ith_manu.list))]
  })
  
  return(Ordered_by_Sub.list)
}




