RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer = function(data.list){
  ### Each Scanner
  scanners = c("SIEMENS", "Philips", "GE.MEDICAL.SYSTEMS")
  scanners_band.type = sapply(scanners, FUN=function(ith){
    c(paste0(ith, "_", "MB"), paste0(ith, "_", "SB")) %>% return
  })


  ### Find having same scanner_band.type
  list_names = names(data.list)
  which_scanner_is_selected = c()
  combined_by_scanner_type.list = lapply(scanners_band.type, FUN=function(jth_scanner_band.type, ...){
    which_ind = filter_by(list_names, jth_scanner_band.type, ignore.case = F, as.ind = T)

    if(length(which_ind)>0){
      which_scanner_is_selected <<- c(which_scanner_is_selected, jth_scanner_band.type)
      kth.list = c()
      for(k in 1:length(which_ind)){
        kth.list = c(kth.list, data.list[[which_ind[k]]])
      }
      return(kth.list)
    }else{
      return(NULL)
    }
  }) %>% rm_list_null
  names(combined_by_scanner_type.list) = which_scanner_is_selected
  return(combined_by_scanner_type.list)
}
