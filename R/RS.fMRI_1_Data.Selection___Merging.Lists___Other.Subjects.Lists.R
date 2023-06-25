RS.fMRI_1_Data.Selection___Merging.Lists___Other.Subjects.Lists = function(Merged_VISCODE.list,
                                                                           ADNIMERGE.list,
                                                                           CV.list,
                                                                           BLCHANGE.list,
                                                                           ADAS.list,
                                                                           MMSE.list,
                                                                           APOE.list){
  Merged_Full.list = lapply(seq_along(Merged_VISCODE.list), function(i, ...){
    # ADNIMERGE
    ith_RID.df = Merged_VISCODE.list[[i]]
    ith_ADNIMERGE.df = ADNIMERGE.list[[i]]
    cols_intersection = intersect(names(ith_RID.df), names(ith_ADNIMERGE.df))
    ith_Merged_1.df = merge(ith_RID.df, ith_ADNIMERGE.df, by = cols_intersection, all = T)

    # CV
    ith_CV.df = CV.list[[i]]
    cols_intersection = intersect(names(ith_Merged_1.df), names(ith_CV.df))
    ith_Merged_2.df = merge(ith_Merged_1.df, ith_CV.df, by = cols_intersection, all = T)

    # BLCHANGE
    ith_BLCHANGE.df = BLCHANGE.list[[i]]
    cols_intersection = intersect(names(ith_Merged_2.df), names(ith_BLCHANGE.df))
    ith_Merged_3.df = merge(ith_Merged_2.df, ith_BLCHANGE.df, by = cols_intersection, all = T)

    # ADAS
    ith_ADAS.df = ADAS.list[[i]]
    cols_intersection = intersect(names(ith_Merged_3.df), names(ith_ADAS.df))
    ith_Merged_4.df = merge(ith_Merged_3.df, ith_ADAS.df, by = cols_intersection, all = T)


    # MMSE
    ith_MMSE.df = MMSE.list[[i]]
    cols_intersection = intersect(names(ith_Merged_4.df), names(ith_MMSE.df))
    ith_Merged_5.df = merge(ith_Merged_4.df, ith_MMSE.df, by = cols_intersection, all = T)


    # APOE
    ith_APOE.df = APOE.list[[i]]
    cols_intersection = intersect(names(ith_Merged_5.df), names(ith_APOE.df))
    ith_Merged_6.df = merge(ith_Merged_5.df, ith_APOE.df, by = cols_intersection, all = T) %>% arrange(REGISTRY___USERDATE)




    cat("\n",crayon::green("Merging the other subjects lists is done :"), crayon::red(paste0("RID ", unique(ith_RID.df$RID))),"\n")
    return(ith_Merged_6.df)
  })
  return(Merged_Full.list)
}
