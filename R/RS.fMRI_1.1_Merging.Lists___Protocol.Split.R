RS.fMRI_1.1_Merging.Lists___Protocol.Split = function(data.list){
  # data.list = Merging_Search.list
  #====================================================================================================
  # Defining function
  #====================================================================================================
  strsplit_by = function(x.vec, split_by_1st = ";", split_by_2nd = "="){
    ############################################################################
    # 1st
    ############################################################################
    split_1st.list = strsplit(x.vec, split_by_1st)
    col_names = sapply(strsplit(split_1st.list[[1]], split_by_2nd), FUN=function(ith_elements){
      ith_elements[1]
    })


    ############################################################################
    # 2nd
    ############################################################################
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

data.list[[1]][816,] %>% as.data.frame

  #====================================================================================================
  # split protocol
  #====================================================================================================
  EPB_protocol.df = strsplit_by(data.list$EPB$IMAGING.PROTOCOL) %>% as.tibble
  MT1_protocol.df = strsplit_by(x.vec = data.list[[2]]$IMAGING.PROTOCOL) %>% as.tibble
  # rm blank in colnames
  names(fMRI_protocol.df) = paste0("FMRI___", gsub(" ", ".", names(fMRI_protocol.df)) %>% toupper)
  names(MRI_protocol.df) = paste0("MRI___", gsub(" ", ".", names(MRI_protocol.df)) %>% toupper)




  #====================================================================================================
  ### Nullify
  #====================================================================================================
  data.list[[2]]$IMAGING.PROTOCOL=NULL
  data.list[[1]]$IMAGING.PROTOCOL=NULL



  #====================================================================================================
  ### combining
  #====================================================================================================
  fMRI_protocol_combined = cbind(data.list[[1]], fMRI_protocol.df) %>% as.tibble
  MRI_protocol_combined = cbind(data.list[[2]],  MRI_protocol.df) %>% as.tibble

  return(list(fMRI = fMRI_protocol_combined, MRI = MRI_protocol_combined))
}
