RS.fMRI_1.2_Merging.Lists___Protocol.Split___Extracting.Data.Frame = function(ith_Protocol, suffix=NULL){
  # ith_Protocol = ith_EPI_Protocol
  # Split the string by ";"
  ith_Protocol_Splitted = strsplit(ith_Protocol, ";")[[1]]

  # Split each element of the list by "="
  ith_Protocol_Splitted.list = lapply(ith_Protocol_Splitted, function(x) strsplit(x, "="))

  # Extract column names and values
  ith_Protocol_Colnames = sapply(ith_Protocol_Splitted.list, function(x) x[[1]][1])
  ith_Protocol_Values = sapply(ith_Protocol_Splitted.list, function(x) x[[1]][2])


  # names suffix
  if(!is.null(suffix)){
    ith_Protocol_Colnames = paste0(suffix, ith_Protocol_Colnames)
  }



  # Create data frame
  ith_Protocol.df = t(ith_Protocol_Values) %>% as.data.frame()
  colnames(ith_Protocol.df) = ith_Protocol_Colnames

  return(ith_Protocol.df)
}
