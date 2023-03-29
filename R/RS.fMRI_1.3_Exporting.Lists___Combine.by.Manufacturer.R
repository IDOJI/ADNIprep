RS.fMRI_1.3_Exporting.Lists___Combine.by.Manufacturer = function(data.list){
  #===============================================================================
  # Data load
  #===============================================================================
  EPB = data.list[[1]]
  MT1 = data.list[[2]]


  #===============================================================================
  # EPB
  #===============================================================================
  ### create a list for saving
  EPB_by_each_MANU.list = list()
  MANU_names_new = list()

  ### Classifying variable : MB, SB
  which_rows_MB  =  grep(" MB ", EPB$SERIES_DESCRIPTION, ignore.case=F)
  which_RIDs_MB   =  EPB$RID[which_rows_MB]
  EPB_2          =  EPB %>% dplyr::mutate(SERIES_BAND.TYPE = case_when(RID %in% which_RIDs_MB  ~   "MB",
                                                                       TRUE                   ~   "SB"))
  MANU      =  EPB_2$MANUFACTURER %>% unique


  ### Extracting Manufacture : 1. SIEMENS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if(grep("SIEMENS", MANU) %>% length > 0){

    SIEMENS = EPB_2 %>% dplyr::filter(MANUFACTURER=="SIEMENS")
    MANU_names_new[[1]]  =  c(paste("SIEMENS", "MB", sep="_"), paste("SIEMENS", "SB", sep="_"))

    if(SIEMENS$SERIES_BAND.TYPE %>% unique %>% length == 2){
      MB = SIEMENS %>% dplyr::filter(SERIES_BAND.TYPE == "MB")
    }else{
      MB = NULL
    }
    SB = SIEMENS %>% dplyr::filter(SERIES_BAND.TYPE == "SB")

    EPB_by_each_MANU.list[[1]] = MB
    EPB_by_each_MANU.list[[2]] = SB
  }



  ### Extracting Manufacture : 2. GE  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  if(grep("GE MEDICAL SYSTEMS", MANU) %>% length > 0){

    GE = EPB_2 %>% dplyr::filter(MANUFACTURER=="GE MEDICAL SYSTEMS")
    MANU_names_new[[2]]  =  c(paste("GE.MEDICAL.SYSTEMS", "MB", sep="_"), paste("GE.MEDICAL.SYSTEMS", "SB", sep="_"))

    if(GE$SERIES_BAND.TYPE %>% unique %>% length == 2){
      MB = GE %>% dplyr::filter(SERIES_BAND.TYPE == "MB")
    }else{
      MB = NULL
    }
    SB = GE %>% dplyr::filter(SERIES_BAND.TYPE == "SB")

    EPB_by_each_MANU.list[[3]] = MB
    EPB_by_each_MANU.list[[4]] = SB
  }



  ### Extracting Manufacture : 2. GE  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  which_Philips = grep("Philips", EPB_2$MANUFACTURER, ignore.case = T)
  if(which_Philips %>% length > 0){
    Philips = EPB_2[which_Philips,]
    MANU_names_new[[3]]  =  c(paste("Philips", "MB", sep="_"), paste("Philips", "SB", sep="_"))

    if(Philips$SERIES_BAND.TYPE %>% unique %>% length == 2){
      MB = Philips %>% dplyr::filter(SERIES_BAND.TYPE == "MB")
    }else{
      MB = NULL
    }
    SB = Philips %>% dplyr::filter(SERIES_BAND.TYPE == "SB")

    EPB_by_each_MANU.list[[5]] = MB
    EPB_by_each_MANU.list[[6]] = SB
  }



  ### Remove NULL in Manufacturer
  names(EPB_by_each_MANU.list) = MANU_names_new %>% unlist
  EPB_by_each_MANU.list = rm_list_null(EPB_by_each_MANU.list)



  ### Extract each RID
  RID.list = lapply(EPB_by_each_MANU.list, FUN=function(y){
    return(y$RID)
  })



  #===============================================================================
  # MT1
  #===============================================================================
  ### EXtracting MT1 by each Manufacturer
  MT1_by_each_MANU.list = lapply(RID.list, FUN=function(ith_RID,...){
    MT1 %>% dplyr::filter(RID %in% ith_RID) %>% return
  })
  names(MT1_by_each_MANU.list) = names(EPB_by_each_MANU.list)


  ### check
  EPB_nrow = sapply(EPB_by_each_MANU.list, FUN=function(ith_df){
    return(ith_df %>% nrow)
  })
  MT1_nrow = sapply(MT1_by_each_MANU.list, FUN=function(ith_df){
    return(ith_df %>% nrow)
  })
  if((EPB_nrow==MT1_nrow) %>% sum  != length(EPB_nrow)){
    stop("Different rows")
  }


  #===============================================================================
  # Combining
  #===============================================================================
  combined.list = list()
  for(i in 1:length(EPB_by_each_MANU.list)){
    combined.list[[i]] = list(EPB_by_each_MANU.list[[i]], MT1_by_each_MANU.list[[i]])
  }
  names(combined.list) = names(EPB_by_each_MANU.list)

  return(combined.list)

}
