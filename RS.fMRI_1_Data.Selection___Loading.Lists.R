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
                                                    Subjects_BLCHANGE,
                                                    Subjects_DX_Summary,
                                                    #
                                                    Subjects_ADAS,
                                                    Subjects_MMSE){
  #=============================================================================
  # 0.Selected RIDs
  #=============================================================================
  Selected_RID = names(Selected_Subjects_by_QC.list) %>% as.numeric


  #=============================================================================
  # Data Load : ADNIMERGE - ADNIMERGE
  #=============================================================================
  ADNIMERGE.list = RS.fMRI_1_Data.Selection___Loading.Lists___ADNIMERGE(Selected_RID)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::blue("ADNIMERGE package"), crayon::red("ADNIMERGE"),"\n")





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




  # #=============================================================================
  # # Data Load : Study Visits
  # #=============================================================================
  # Study_Vists_Summary.list = RS.fMRI_1_Data.Selection___Loading.Lists___Study.Visits.Summary(Selected_RID, Subjects_Study.Visits.Summary, path_Subjects.Lists_Downloaded)
  # cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("SEARCH"),"\n")




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
  PTDEMO.list = RS.fMRI_1_Data.Selection___Loading.Lists___PTDEMO(Selected_RID, Subjects_PTDEMO, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("PTDEMO"),"\n")




  #=============================================================================
  # Data Load : ADAS
  #=============================================================================
  ADAS.list = RS.fMRI_1_Data.Selection___Loading.Lists___ADAS(Selected_RID, Subjects_ADAS, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("ADAS"),"\n")





  #=============================================================================
  # Data Load : MMSE
  #=============================================================================
  MMSE.list = RS.fMRI_1_Data.Selection___Loading.Lists___MMSE(Selected_RID, Subjects_MMSE, path_Subjects.Lists_Downloaded)
  cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("MMSE"),"\n")






  #=============================================================================
  # Data Load : APOE
  #=============================================================================
  # APOE.list = RS.fMRI_1_Data.Selection___Loading.Lists___APOE(Selected_RID, Subjects_APOE, path_Subjects.Lists_Downloaded)
  # cat("\n", crayon::bgMagenta("Step 1.2"),crayon::green("Loading data is done :"), crayon::red("APOE"),"\n")





  #=============================================================================
  # 6.Returning results
  #=============================================================================
  Loaded_Data.list = list(QC = Selected_Subjects_by_QC.list, ADNIMERGE = ADNIMERGE.list, NFQ = NFQ.list,
                          Search = Search.list, CLIELG = CLIELG.list,
                          Registry = Registry.list,
                          BLCHANGE = BLCHANGE.list,
                          DXSUM = DXSUM.list,
                          PTDEMO = PTDEMO.list,
                          ADAS = ADAS.list,
                          MMSE = MMSE.list)
                          # APOE = APOE.list)
  cat("\n", crayon::bgMagenta("STEP 1.2"), crayon::blue("Loading data is done!"), "\n")
  return(Loaded_Data.list)

}



# Merged.df = RS.fMRI_1_Data.Selection___Loading.Lists___Merging.EPI.and.MT1(Modifying_cols.list)
#
# #=============================================================================
# # 1. Selecting data by RID & Dates & ImageID
# #=============================================================================
# Intersection.list = RS.fMRI_1_Data.Selection___Loading.Lists___Intersect.By.RID.and.Dates.and.ImageID(Subjects.list)
# text = "1.2 : Extracting by RID & Dates is done!"
# cat("\n", crayon::green(text), "\n")

