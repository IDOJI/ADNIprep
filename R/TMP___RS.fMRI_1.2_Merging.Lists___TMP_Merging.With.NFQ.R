RS.fMRI_1_Merging.with.NFQ = function(selected_EPB_MT1.list, NFQ.df=subjects.list[[3]]){
  ### moving date variables
  NFQ.df = gather_col(subjects.list[[3]], col.words = "date", where = 1)
  text = "1.4 : Moving dates variables is done."
  cat("\n", crayon::green(text), "\n")

  ### as list by "RID" : arraging by 'Scan.date'
  NFQ_by_RID.list = as_list_by(NFQ.df, which.ID.col = "RID", arrange.by = "Scan.Date", is.date = T, desc = F)
  text = "1.4 : Making a list by 'RID' and rearraging by 'Scan.Date' are done."
  cat("\n", crayon::green(text), "\n")

  ### merging with NFQ
  results.list = list()
  for(i in 1:length(selected_EPB_MT1.list)){
    # i=1
    ith.list = selected_EPB_MT1.list[[i]]

    # ### create a list for saving results ; and naming by RID
    # ith_save.list = rep(NA, length(ith.list)) %>% as.list
    # names(ith_save.list) = names(ith.list)

    results.list[[i]] = lapply(ith.list, NFQ_by_RID.list, FUN=function(x, NFQ_by_RID.list=NFQ_by_RID.list){
      # x.df = ith.list[[1]]
      merging_with_NFQ.list = RS.fMRI_1_Merging.with.NFQ___Merging.with.NFQ(x, NFQ_by_RID.list)
      return(merging_with_NFQ.list)
    })

    ### changing list names
    ith_RID = sapply(results.list[[i]], FUN=function(x){
      # x = results.list[[i]][[1]]
      return(x[[1]]$RID %>% as.character)
    })
    names(results.list[[i]]) = ith_RID
  }# for
  names(results.list) = names(selected_EPB_MT1.list)
  text = "1.4 : Merging with NFQ file is done."
  cat("\n", crayon::green(text), "\n")

  ### returning results
  text = paste("\n","Step 1.4 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(results.list)
}
