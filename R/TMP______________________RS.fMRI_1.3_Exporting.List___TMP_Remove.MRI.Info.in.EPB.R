RS.fMRI_1.3_Exporting.List___Remove.MRI.Info.in.EPB = function(data.list=data_split_by_series_type.list){
  EPB.list = data.list[[1]]

  for(i in 1:length(EPB.list)){
    # i=1
    ith_EPB.df = EPB.list[[i]]

    ### remove MRI info
    which_col_fMRI = which_col(ith_EPB.df, which.col = "fMRI_", as.col.names = F)
    which_col_MRI = which_col(ith_EPB.df, which.col = "MRI_", as.col.names = F)
    setdiff_MRI = setdiff(which_col_MRI, which_col_fMRI)
    ith_EPB.df[setdiff_MRI] = NULL
    names(ith_EPB.df)

    ### remove fMRI character
    which_col_fMRI = which_col(ith_EPB.df, which.col = "fMRI_", as.col.names = T)
    ind_fMRI = which_col(ith_EPB.df, which.col = "fMRI_", as.col.names = F)
    for(k in 1:length(ind_fMRI)){
      ith_EPB.df = change_colnames(ith_EPB.df, from = which_col_fMRI[k], strsplit(which_col_fMRI[k], "_")[[1]][2], exact.from = T)
    }

    EPB.list[[i]] = ith_EPB.df
  }# for
  data.list[[1]] = EPB.list
  return(data.list)
}# function
