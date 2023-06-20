RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Diagnosis___Data.Exclusion = function(Data.list){
  # Data.list  = Merged_Data.list
  Excluded.list = lapply(seq_along(Data.list), function(i){
    # which(names(Merged_Data.list)=="6576")
    # ith_RID.df = Data.list[[588]]


    ith_RID.df = Data.list[[i]]
    ith_CENROLL = ith_RID.df$CLIELG___CENROLL %>% as.character

    # Character
    ith_which_Exclude_1 = grep("should be excluded", ith_CENROLL)
    ith_which_Exclude_2 = grep("not eligible", ith_CENROLL)
    ith_which_Exclude_3 = grep("ineligible", ith_CENROLL)
    ith_which_Exclude = c(ith_which_Exclude_1, ith_which_Exclude_2, ith_which_Exclude_3) %>% unique %>% sort

    # Numeric
    ith_CENROLL_Nemeric = ith_CENROLL %>% as.numeric() %>% suppressWarnings()
    ith_which_Exclude_Numeric = which(0 %in% ith_CENROLL_Nemeric)
    #=========================================================================
    # Character
    #=========================================================================
    if(ith_which_Exclude %>% length > 0 && length(ith_which_Exclude_Numeric)==0){
      ith_which_Row_study.date = which(!is.na(ith_RID.df$RESEARCH.GROUP))
      if(ith_which_Row_study.date %in% ith_which_Exclude){
        return(NULL)
      }else{
        return(ith_RID.df)
      }
      #=========================================================================
      # Numeric
      #=========================================================================
    }else if(length(ith_which_Exclude_Numeric) > 0 && ith_which_Exclude %>% length == 0){
      ith_which_Row_study.date = which(!is.na(ith_RID.df$RESEARCH.GROUP))
      if(ith_which_Row_study.date %in% ith_which_Exclude_Numeric){
        return(NULL)
      }else{
        return(ith_RID.df)
      }
    }else{
      return(ith_RID.df)
    }
  }) %>% rm_list_null# lapply
  return(Excluded.list)
}
