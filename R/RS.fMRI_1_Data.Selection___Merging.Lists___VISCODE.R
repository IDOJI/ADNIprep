RS.fMRI_1_Data.Selection___Merging.Lists___VISCODE = function(Merged_ImageID.list, Merged_VISCODE2.list){
  Merged_VISCODE.list = lapply(seq_along(Merged_ImageID.list), function(i, ...){
    ith_ImageID.df = Merged_ImageID.list[[i]]
    ith_VISCODE2.df = Merged_VISCODE2.list[[i]]
    ith_VISCODE2_Selected.df = ith_VISCODE2.df %>% filter(PHASE == ith_ImageID.df$PHASE & VISCODE == ith_ImageID.df$VISCODE)
    if(is.na(ith_ImageID.df$VISCODE2)){
      ith_ImageID.df$VISCODE2 = ith_VISCODE2_Selected.df$VISCODE2
    }
    intersect_colnames = intersect(names(ith_VISCODE2_Selected.df), names(ith_ImageID.df))
    ith_Merged.df = merge(ith_ImageID.df, ith_VISCODE2_Selected.df, by = intersect_colnames, all=T) %>% relocate(STUDY.DATE, .after = VISCODE2)
    ith_VISCODE2_Merged.df = merge(ith_Merged.df, ith_VISCODE2.df, by = intersect(names(ith_Merged.df), names(ith_VISCODE2.df)), all = T) %>% relocate(STUDY.DATE, .after = VISCODE2) %>% arrange(REGISTRY___USERDATE)
    cat("\n",crayon::green("Merging by VISCODE :"), crayon::red(paste0("RID_", ith_Merged.df$RID)),"\n")
    return(ith_VISCODE2_Merged.df)
  })
  return(Merged_VISCODE.list)
}


