RS.fMRI_1_Data.Selection___Merging.Lists___VISCODE2 = function(Registry.list, PTDEMO.list, DXSUM.list){
  Merged_VISCODE2.list = lapply(seq_along(QC_EPI.list), function(i, ...){
    # i=482
    # i=469
    # Data
    cat("\n", crayon::green("Merging Lists by VISCODE2 :"), crayon::red(paste0("RID_", names(QC_EPI.list)[i])), "\n")
    ith_Registry = Registry.list[[i]]
    ith_PTDEMO = PTDEMO.list[[i]]
    ith_DXSUM = DXSUM.list[[i]]


    ith_Merged.list = lapply(seq_along(Selected_PHASE), function(k, ...){
      kth_ith_Registry = ith_Registry %>% filter(PHASE == Selected_PHASE[k])
      kth_ith_DXSUM = ith_DXSUM %>% filter(PHASE %in% Selected_PHASE[k])
      kth_ith_PTDEMO = ith_PTDEMO %>% filter(PHASE %in% Selected_PHASE[k])

      kth_Merged_1.df = merge(kth_ith_Registry, kth_ith_DXSUM, by = intersect(names(kth_ith_Registry), names(kth_ith_DXSUM)), all=T)
      kth_Merged_2.df = merge(kth_Merged_1.df, kth_ith_PTDEMO, by = intersect(names(kth_Merged_1.df), names(kth_ith_PTDEMO)), all=T)
      return(kth_Merged_2.df)
    })
    ith_Merged.df = do.call(rbind, ith_Merged.list)
    return(ith_Merged.df)
  })
  return(Merged_VISCODE2.list)
}
