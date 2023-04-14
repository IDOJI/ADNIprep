RS.fMRI_1.1_Load.Subjects.As.List___Intersection.Search.and.QC___Intersection.by.RID = function(data.list){
  # data.list = subjects.list

  # Extract RID
  RID_Search = data.list[[1]]$fMRI$RID %>% unique %>% as.numeric %>% as.character
  RID_QC = names(data.list[[2]]) %>% as.numeric %>% as.character

  # RID_QC[!RID_QC %in% RID_Search]
  #
  # "I1058031" %in% data.list[[1]]$MRI$IMAGE.ID

  # data.list[[2]][RID_QC == "734"]
  # NFQ %>% filter(RID == "734") %>% View
  # NFQ =
  #   # intersection RID
  #   New_Search.list = lapply(data.list[[1]], FUN=function(ith_Search_list, ...){
  #     ith_Search_list %>% filter(RID %in% RID_QC)
  #   })
  #
  #
  Search_RID = data.list[[1]]$fMRI$RID
  QC_RID = data.list[[2]]$RID
  intersect_RID = intersect(Search_RID, QC_RID)


  # filtering by intersection RID
  data.list[[1]]$fMRI = data.list[[1]]$fMRI %>% filter(RID %in% intersect_RID)
  data.list[[1]]$MRI = data.list[[1]]$MRI %>% filter(RID %in% intersect_RID)
  data.list[[2]] = data.list[[2]] %>% filter(RID %in% intersect_RID)


  text = "1.1 : Subsetting by intersection RID is done."
  cat("\n", crayon::green(text), "\n")
  return(data.list)
}
