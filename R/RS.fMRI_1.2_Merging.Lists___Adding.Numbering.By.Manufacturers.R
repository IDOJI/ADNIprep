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
  # 3.Adding cols
  #=============================================================================
  Manu = EPB.df$Manufacturer_New %>% unique
  EPB.list = lapply(Manu, FUN=function(ith_Manu, ...){
    # ith_Manu = Manu[5]
    ith_EPB.df = EPB.df %>% filter(Manufacturer_New == ith_Manu)
    Sub_Num = paste0("Sub_", fit_length(1:nrow(ith_EPB.df), 3))
    File_Names = paste0(ith_EPB.df$Manufacturer_New, "___", Sub_Num, "___", "RID_", fit_length(ith_EPB.df$RID, 4))
    cbind(Sub_Num, File_Names, ith_EPB.df) %>% as_tibble
  })
  New_EPB.df = do.call(rbind, EPB.list)
  return(list(EPB = New_EPB.df, MT1 = MT1.df))
}
