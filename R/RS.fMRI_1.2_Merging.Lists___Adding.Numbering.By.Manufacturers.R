RS.fMRI_1.2_Merging.Lists___Adding.Numbering.By.Manufacturers = function(data.list){
  # data.list = Modifying_cols.list
  #=============================================================================
  # 1. split by EPB & MT1
  #=============================================================================
  EPB.df = data.list[[1]]
  MT1.df = data.list[[2]]



  #=============================================================================
  # 2.Arranging by Manufacturer and RID
  #=============================================================================
  EPB.df$RID = EPB.df$RID %>% as.numeric
  MT1.df$RID = MT1.df$RID %>% as.numeric

  EPB.df = EPB.df %>% arrange(Manufacturer_New, RID)
  MT1.df = MT1.df %>% arrange(Manufacturer_New, RID)




  #=============================================================================
  # 3.Adding Numbering A Col by Manufacturers
  #=============================================================================
  ############################################################################
  # EPI
  ############################################################################
  Manu = EPB.df$Manufacturer_New %>% unique
  New_EPB.list = lapply(Manu, FUN=function(ith_Manu, ...){
    # ith_Manu = Manu[5]
    ith_EPB.df = EPB.df %>% filter(Manufacturer_New == ith_Manu)
    Sub_Num = paste0("Sub_", fit_length(1:nrow(ith_EPB.df), 3))
    File_Names = paste0(ith_EPB.df$Manufacturer_New, "___", Sub_Num, "___", "RID_", fit_length(ith_EPB.df$RID, 4))
    cbind(Sub_Num, File_Names, ith_EPB.df) %>% as_tibble() %>% return()
  })
  New_EPB.df = do.call(rbind, New_EPB.list)
  ############################################################################
  # MT1
  ############################################################################
  New_MT1.list = lapply(Manu, function(ith_Manu, ...){
    ith_MT1.df = MT1.df %>% filter(Manufacturer_New == ith_Manu)
    Sub_Num = paste0("Sub_", fit_length(1:nrow(ith_MT1.df), 3))
    File_Names = paste0(ith_MT1.df$Manufacturer_New, "___", Sub_Num, "___", "RID_", fit_length(ith_MT1.df$RID, 4))
    ith_New_MT1.df = cbind(Sub_Num, File_Names, ith_MT1.df) %>% as_tibble() %>% return()
  })
  New_MT1.df = do.call(rbind, New_MT1.list)





  #=============================================================================
  # 4.Check the results
  #=============================================================================
  if(sum(New_EPB.df$RID==New_MT1.df$RID)!=nrow(New_MT1.df)){
    stop("RIDs are not consistent between EPB and MT1")
  }
  if(sum(New_EPB.df$Sub_Num==New_MT1.df$Sub_Num)!=nrow(New_MT1.df)){
    stop("Sub Nums are not consistent between EPB and MT1")
  }






  #=============================================================================
  # 4.Adding Cols : new files names with Image ID
  #=============================================================================
  # Image ID
  ImageID_EPB = New_EPB.df$IMAGE_ID
  ImageID_MT1 = New_MT1.df$IMAGE_ID
  ImageID_combined = sapply(seq_along(ImageID_EPB), function(k){
    paste0("EPI", "_", ImageID_EPB[k], "___", "MT1", "_", ImageID_MT1[k])
  })
  # EPB
  New_EPB.df$File_Names_New = paste0(New_EPB.df$File_Names, "___", ImageID_combined)
  New_EPB.df = New_EPB.df %>% relocate(File_Names_New, .after=File_Names)

  # MT1
  New_MT1.df$File_Names_New = paste0(New_MT1.df$File_Names, "___", ImageID_combined)
  New_MT1.df = New_MT1.df %>% relocate(File_Names_New, .after=File_Names)
  if(sum(New_MT1.df$File_Names_New==New_EPB.df$File_Names_New) != length(ImageID_combined)){
    stop("Not consistent ImageID File Names")
  }




  return(list(EPB = New_EPB.df, MT1 = MT1.df))
}
