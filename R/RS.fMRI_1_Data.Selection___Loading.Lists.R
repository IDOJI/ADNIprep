RS.fMRI_1_Data.Selection___Loading.Lists = function(Selected_Subjects_by_QC.list,
                                                    path_Subjects.Lists_Downloaded,
                                                    #
                                                    Subjects_NFQ,
                                                    Subjects_Search,
                                                    Subjects_Registry,
                                                    # CV
                                                    Subjects_CV_ADNI2GO,
                                                    Subjects_CV_ADNI3,
                                                    #
                                                    Subjects_DX_Summary,
                                                    Subjects_BLCHANGE,
                                                    Subjects_APOE,){
  #=============================================================================
  # 0.Selected RIDs
  #=============================================================================
  Selected_RID = names(Selected_Subjects_by_QC.list[[1]]) %>% as.numeric





  #=============================================================================
  # Data Load : NFQ
  #=============================================================================
  NFQ.list = RS.fMRI_1_Data.Selection___Loading.Lists___NFQ(Selected_RID, Subjects_NFQ, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("NFQ"),"\n")



  #=============================================================================
  # Data Load : Search
  #=============================================================================
  Search.list = RS.fMRI_1_Data.Selection___Loading.Lists___Search(Selected_RID, Subjects_Search, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("SEARCH"),"\n")


  #=============================================================================
  # Data Load : ADNIMERGE - ADNIMERGE
  #=============================================================================
  ADNIMERGE.list = RS.fMRI_1_Data.Selection___Loading.Lists___ADNIMERGE(Selected_RID)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::blue("ADNIMERGE package"), crayon::red("ADNIMERGE"),"\n")




  #===============================================================================
  # Data Load : CLIELG
  #===============================================================================
  CLIELG.list = RS.fMRI_1_Data.Selection___Loading.Lists___CLIELG(Selected_RID, Subjects_CV_ADNI2GO, Subjects_CV_ADNI3, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("Clinical Verification"),"\n")




  #=============================================================================
  # Data Load : Registry
  #=============================================================================
  Registry.list = RS.fMRI_1_Data.Selection___Loading.Lists___Registry(Selected_RID, Subjects_Registry, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("Registry"),"\n")




  #=============================================================================
  # Data Load : BLCHANGE
  #=============================================================================
  BLCHANGE.list = RS.fMRI_1_Data.Selection___Loading.Lists___BLCHANGE(Selected_RID, Subjects_BLCHANGE, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("BLCHANGE"),"\n")




  #=============================================================================
  # Data Load : DXSUMMARY
  #=============================================================================
  DXSUM.list = RS.fMRI_1_Data.Selection___Loading.Lists___DXSUM(Selected_RID, Subjects_DX_Summary, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("DXSUMMARY"),"\n")



  #=============================================================================
  # Data Load : PTDEMO
  #=============================================================================
  path_Subjects_PTDEMO = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_PTDEMO)





  #=============================================================================
  # Data Load : APOE
  #=============================================================================
  path_Subjects_APOE = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_APOE)



  ith_Search.df = Search.df %>% filter(RID==4216)
  cbind(ith_Search.df$VISIT %>% unique, ith_Search.df$STUDY.DATE %>% unique) %>% as.data.frame

  Registry.df %>% filter(RID==4216) %>% select(PHASE, VISCODE, VISCODE2, USERDATE, EXAMDATE)
  BLCHANGE.df %>% filter(RID==4216) %>% select(Phase, VISCODE, VISCODE2, USERDATE, EXAMDATE)
  DXSUM.df %>% filter(RID==4216) %>% select(Phase, VISCODE, VISCODE2, USERDATE, EXAMDATE)
  PTDEMO.df %>% filter(RID==4216) %>% select(Phase, VISCODE, VISCODE2, USERDATE)
  ADNIMERGE %>% filter(RID==4216) %>% select(COLPROT, VISCODE, EXAMDATE, Years.bl, Month.bl)
  CLIELG.df %>% filter(RID==4216) %>% select(COLPROT, VISCODE, USERDATE)





  #=============================================================================
  # 3.VISCODE
  #=============================================================================
  QC_Visit.list = lapply(Merging_Search.list, function(ith_RID.list){
    ith_EPI.df = ith_RID.list[[1]]
    ith_EPI.df %>% select(RID, SCANDATE, VISCODE, VISCODE2, VISIT, PHASE)
  })
  QC_Visit.df = do.call(rbind, QC_Visit.list)

  Selected_QC_Visit.df = do.call(rbind, Selected_QC_Visit.list)


  Selected_RID = Merged_QC_NFQ.list[[1]] %>% names %>% as.numeric
  Registry_Selected.df = Registry.df %>% filter(RID %in% Selected_RID)
  Search_Selected.df = Merged_QC_NFQ.list[[3]]



  Search_Selected.df %>% select(RID, PHASE, STUDY.DATE, VISIT)
  View(Search_Selected.df)
  i=1
  ith_Registry.df = Registry_Selected.df %>% filter(RID == Selected_RID[i])
  ith_Search.df =




  #=============================================================================
  # 3. Protocol Split
  #=============================================================================
  Protocol_Splitted.list = RS.fMRI_1_Data.Selection___Loading.Lists___Protocol.Split(Merging_Search.list)
  cat("\n", crayon::green("1.2.3 : Splitting protocol is done."), "\n")





  #=============================================================================
  # 4.Combining each RID by EPI, MT1
  #=============================================================================
  EPI.list = lapply(Protocol_Splitted.list, function(x){x[[1]]})
  MT1.list = lapply(Protocol_Splitted.list, function(x){x[[2]]})
  Combined.list = list(EPI = do.call(rbind, EPI.list), MT1 = do.call(rbind, MT1.list))
  cat("\n", crayon::green("1.2.4 : Combining by each RID is done!."), "\n")




  #=============================================================================
  # 5. Modifying Cols
  #=============================================================================
  Modifying_cols.list = RS.fMRI_1_Data.Selection___Loading.Lists___Modifying.Cols(Combined.list)
  text = "1.2.5 : Modifying cols is done!"
  cat("\n", crayon::green(text), "\n")





  #=============================================================================
  # 6.Merging EPB & MT1
  #=============================================================================
  EPI.df = Modifying_cols.list[[1]]
  MT1.df = Modifying_cols.list[[2]]
  Merged.df = merge(EPI.df, MT1.df, by = intersect(names(EPI.df), names(MT1.df)), all.x = T)
  Merged.df = Merged.df %>% relocate(starts_with("DATES_"), .after = PHASE)
  Merged.df = Merged.df %>% relocate(ends_with("IMAGE_ID"), .after = PHASE)



  #=============================================================================
  # 6.Returning results
  #=============================================================================
  final.df = Merged.df
  text = "1.2 : Merging.Lists is done!"
  cat("\n", crayon::bgMagenta(text), "\n")
  return(final.df)

}



# Merged.df = RS.fMRI_1_Data.Selection___Loading.Lists___Merging.EPI.and.MT1(Modifying_cols.list)
#
# #=============================================================================
# # 1. Selecting data by RID & Dates & ImageID
# #=============================================================================
# Intersection.list = RS.fMRI_1_Data.Selection___Loading.Lists___Intersect.By.RID.and.Dates.and.ImageID(Subjects.list)
# text = "1.2 : Extracting by RID & Dates is done!"
# cat("\n", crayon::green(text), "\n")

