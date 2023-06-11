RS.fMRI_1.2_Merging.Lists = function(Subjects.list){
  #=============================================================================
  # 1. QC & NFQ
  #=============================================================================
  Merged_QC_NFQ.list = RS.fMRI_1.2_Merging.Lists___QC.and.NFQ(Subjects.list)
  text = "1.2.1 : Merging QC & NFQ is done!"
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # 2. Merging Search & QC by date having MT1 & EPB
  #=============================================================================
  Merging_Search.list = RS.fMRI_1.2_Merging.Lists___Search(Merged_QC_NFQ.list)
  text = "1.2.2 : Merging Search & QC is done!"
  cat("\n", crayon::green(text), "\n")





  #=============================================================================
  # 3. Protocol Split
  #=============================================================================
  Protocol_Splitted.list = RS.fMRI_1.2_Merging.Lists___Protocol.Split(Merging_Search.list)
  cat("\n", crayon::green("1.2.3 : Splitting protocol is done."), "\n")




  # if there is no selected subject
  if(Protocol_Splitted.list[[1]] %>% length == 0 & Protocol_Splitted.list[[2]] %>% length ==0){
    text = "1.2 : Merging.Lists is done!"
    cat("\n", crayon::bgMagenta(text), "\n")
    return(Protocol_Splitted.list)
  }else{
    #=============================================================================
    # 4. Modifying Cols
    #=============================================================================
    Modifying_cols.list = RS.fMRI_1.2_Merging.Lists___Modifying.Cols(Protocol_Splitted.list)
    text = "1.2.4 : Modifying cols is done!"
    cat("\n", crayon::green(text), "\n")





    #=============================================================================
    # 5. Adding numbering and Filenames by Manufacturer
    #=============================================================================
    Added_Numbering.list = RS.fMRI_1.2_Merging.Lists___Adding.Numbering.By.Manufacturers(Modifying_cols.list)
    text = "1.2.5 : Adding Numbering and Filenames is done!"
    cat("\n", crayon::green(text), "\n")






    #=============================================================================
    # 6.Returning results
    #=============================================================================
    final.list = Added_Numbering.list
    text = "1.2 : Merging.Lists is done!"
    cat("\n", crayon::bgMagenta(text), "\n")
    return(final.list)
  }

}


#
# #=============================================================================
# # 1. Selecting data by RID & Dates & ImageID
# #=============================================================================
# Intersection.list = RS.fMRI_1.2_Merging.Lists___Intersect.By.RID.and.Dates.and.ImageID(Subjects.list)
# text = "1.2 : Extracting by RID & Dates is done!"
# cat("\n", crayon::green(text), "\n")

