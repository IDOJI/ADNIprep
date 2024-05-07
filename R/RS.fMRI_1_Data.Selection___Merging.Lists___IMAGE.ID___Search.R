RS.fMRI_1_Data.Selection___Merging.Lists___IMAGE.ID___Search = function(Merged_1.list, Search.list){
  Merged_2.list = lapply(seq_along(Merged_1.list), function(i, ...){
    ith_RID.df = Merged_1.list[[i]]
    ith_Search_EPI.df = Search.list[[i]] %>% filter(IMAGE_ID  %in% ith_RID.df$EPI___IMAGE_ID)
    ith_Search_MT1.df = Search.list[[i]] %>% filter(IMAGE_ID  %in% ith_RID.df$MT1___IMAGE_ID)

    if(nrow(ith_Search_EPI.df)==0 | nrow(ith_Search_MT1.df)==0){
      stop("No selected Search")
    }


    selected_cols = c("IMAGE_ID", "ARCHIVE.DATE", "SEARCH___MODALITY", "SEARCH___DESCRIPTION", "SEARCH___IMAGING.PROTOCOL")
    ith_Search_EPI.df = change_colnames(ith_Search_EPI.df, from = selected_cols, to = paste0("EPI___", selected_cols))
    ith_Search_MT1.df = change_colnames(ith_Search_MT1.df, from = selected_cols, to = paste0("MT1___", selected_cols))
    ith_Search_Merged.df = merge(ith_Search_EPI.df, ith_Search_MT1.df, by = intersect(names(ith_Search_EPI.df), names(ith_Search_MT1.df)), all  = T)


    # VISCODE
    if(!is.na(ith_RID.df$VISCODE)){
      if(ith_RID.df$VISCODE != ith_Search_Merged.df$VISCODE){
        ith_Search_Merged.df$VISCODE = ith_RID.df$VISCODE
      }
    }else{
      if(!is.na(ith_Search_Merged.df$VISCODE)){
        ith_RID.df$VISCODE = ith_Search_Merged.df$VISCODE
      }
    }

    # PHASE
    if(!is.na(ith_RID.df$PHASE)){
      if(is.na(ith_Search_Merged.df$PHASE)){
        ith_Search_Merged.df$PHASE = ith_RID.df$PHASE
      }else{
        if(ith_Search_Merged.df$PHASE != ith_RID.df$PHASE){
         stop(i)
        }
      }
    }else{
      if(!is.na(ith_Search_Merged.df$PHASE)){
        ith_RID.df$PHASE = ith_Search_Merged.df$PHASE
      }
    }

    ith_Merged.df = merge(ith_Search_Merged.df, ith_RID.df , by = intersect(names(ith_RID.df), names(ith_Search_Merged.df)), all=T) %>% relocate(starts_with("VISCODE"), .after = PHASE)
    cat("\n", crayon::green("Merging with Search : "), crayon::red(paste0("RID_", ith_RID.df$RID %>% unique)) ,"\n")
    return(ith_Merged.df)
  })
  return(Merged_2.list)
}
