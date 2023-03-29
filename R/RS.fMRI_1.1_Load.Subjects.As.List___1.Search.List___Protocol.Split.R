RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Protocol.Split = function(data.list){
  ### Defining function
  strsplit_by = function(x.vec, split_by_1st = ";", split_by_2nd = "="){
    split_1st.list = strsplit(x.vec, split_by_1st)

    col_names = sapply(strsplit(split_1st.list[[1]], split_by_2nd), FUN=function(ith_elements){
      ith_elements[1]
    })

    split_2nd.list = lapply(split_1st.list, FUN = function(ith_element, ...){
      # ith_element = split_1st.list[[1]]
      strsplit(ith_element, split = split_by_2nd) %>% unlist
    })
    split_2nd.df = do.call(rbind, split_2nd.list) %>% suppressWarnings() %>% as.data.frame

    # Check elements
    which_is_cols = split_2nd.df[1, ] %in% col_names
    New_split_2nd.df = split_2nd.df[, !which_is_cols]
    names(New_split_2nd.df) = col_names
    return(New_split_2nd.df)
  }

  ### split protocol
  fMRI_protocol.df = strsplit_by(x.vec = data.list[[1]]$IMAGING.PROTOCOL)
  MRI_protocol.df  = strsplit_by(x.vec = data.list[[2]]$IMAGING.PROTOCOL)


  ### Nullify
  data.list[[2]]$IMAGING.PROTOCOL=NULL
  data.list[[1]]$IMAGING.PROTOCOL=NULL


  ### Changing names
  names(fMRI_protocol.df) = names(fMRI_protocol.df) %>% toupper
  names(MRI_protocol.df) = names(MRI_protocol.df) %>% toupper


  ### combining
  fMRI_protocol_combined = cbind(data.list[[1]], fMRI_protocol.df)
  MRI_protocol_combined = cbind(data.list[[2]],  MRI_protocol.df)

  return(list(fMRI_protocol_combined, MRI_protocol_combined))
}
