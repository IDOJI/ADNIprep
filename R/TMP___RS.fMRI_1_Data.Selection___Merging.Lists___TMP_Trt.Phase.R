RS.fMRI_1.2_Merging.Lists___Trt.Phase = function(unique_imageID.list, not_unique_imageID.list_new){
  # rm null
  unique_imageID.list_2 = rm_list_null(unique_imageID.list)
  not_unique_imageID.list_2 = rm_list_null(not_unique_imageID.list_new)

  # extract ncol
  unique_ncol.vec = sapply(unique_imageID.list_2, FUN=function(x){
    return(ncol(x))
  })
  not_unique_ncol.vec = sapply(not_unique_imageID.list_2, FUN=function(x){
    return(ncol(x))
  })

  # extract data by ncol
  col_36.list = c(unique_imageID.list_2[unique_ncol.vec==36], not_unique_imageID.list_2[not_unique_ncol.vec==36])
  col_37.list = c(unique_imageID.list_2[unique_ncol.vec==37], not_unique_imageID.list_2[not_unique_ncol.vec==37])

  # length(col_36.list);length(col_37.list)


  # add columns
  if(length(col_37.list)>0 && length(col_36.list)>0){
    added_col_36.list = lapply(col_36.list, FUN=function(x){
      # x = col_36.list[[1]]
      x2 = change_colnames(x, from = "Phase", to = "Phase_Search")
      x3 = cbind(Phase_QC="-", x2)
      x4 = gather_col(data.df = x3, col.words="Phase_QC", exact=T, where = 2)
      cat("\n", "Adding columns on", crayon::cyan(x$ImageID), "is done!", "\n")
      return(x4)
    })# lapply
    combined.df = do.call(rbind, c(added_col_36.list, col_37.list))
  }else{
    combined.df = do.call(rbind, col_36.list)
  }
  return(combined.df)
}
