RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Combine.as.Matrix = function(Combined_Each_Region){
  # FC
  FC.list = lapply(Combined_Each_Region, function(x){
    x[[1]]
  })
  FC.df = do.call(rbind, FC.list)
  rownames(FC.df) = colnames(FC.df)
  # making symmetric
  symmetric_FC.df = FC.df
  symmetric_FC.df[lower.tri(symmetric_FC.df)] = t(symmetric_FC.df)[lower.tri(symmetric_FC.df)]




  # Rows
  row.list = lapply(Combined_Each_Region, function(x){
    x[[2]]
  })
  row.df = do.call(rbind, row.list)
  rownames(row.df) = colnames(row.df)
  symmetric_row.df = row.df
  symmetric_row.df[lower.tri(symmetric_row.df)] = t(symmetric_row.df)[lower.tri(symmetric_row.df)]



  # Cols
  col.list = lapply(Combined_Each_Region, function(x){
    x[[3]]
  })
  col.df = do.call(rbind, col.list)
  rownames(col.df) = colnames(col.df)
  symmetric_col.df = col.df
  symmetric_col.df[lower.tri(symmetric_col.df)] = t(symmetric_col.df)[lower.tri(symmetric_col.df)]


  list(Median_FC = symmetric_FC.df,
       row_Coordiantes = symmetric_row.df,
       col_Coordiantes = symmetric_col.df) %>% return
}
