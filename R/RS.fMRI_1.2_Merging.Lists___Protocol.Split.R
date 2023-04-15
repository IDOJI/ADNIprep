RS.fMRI_1.2_Merging.Lists___Protocol.Split = function(data.list){
  # data.list = Merging_Search.list
  #====================================================================================================
  # Defining function
  #====================================================================================================
  strsplit_by = function(x, split_by_1st = ";", split_by_2nd = "="){
    ############################################################################
    # 1st
    ############################################################################
    split_1st.list = strsplit(x, split_by_1st)
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




  #====================================================================================================
  # split protocol
  #====================================================================================================
  EPB.df = do.call(rbind, data.list[[1]])
  MT1.df = do.call(rbind, data.list[[2]])
  EPB_protocol.list = lapply(EPB.df$IMAGING.PROTOCOL, strsplit_by)
  MT1_protocol.list = lapply(MT1.df$IMAGING.PROTOCOL, strsplit_by)




  #====================================================================================================
  # extracting colnames
  #====================================================================================================
  EPB_cols = c("Manufacturer", "Mfg Model", "TE", "TR", "Slice Thickness", "Field Strength")
  MT1_cols = c("Acquisition Plane", "Matrix Z", "Acquisition Type", "Weighting")
  union_cols = union(EPB_cols, MT1_cols)




  #====================================================================================================
  # renaming protocol : EPB
  #====================================================================================================
  Renamed_EPB_protocol.list = lapply(EPB_protocol.list, FUN=function(ith_protocol,...){
    # ith_protocol = EPB_protocol.list[[1]]
    ith_cols_dont_have = union_cols[!union_cols %in% names(ith_protocol)]
    if(length(ith_cols_dont_have) > 0){
      for(j in 1:length(ith_cols_dont_have)){
        ith_protocol[,ith_cols_dont_have[j]] = NA
      }
    }
    ith_names = names(ith_protocol)

    names(ith_protocol)[ith_names %in% EPB_cols] =  paste0("Protocol.FMRI___", ith_names[ith_names %in% EPB_cols])
    # names(ith_protocol)[ith_names %in% MT1_cols] =  paste0("Protocol.MRI___", ith_names[ith_names %in% MT1_cols])
    names(ith_protocol)[ith_names %in% MT1_cols] =  paste0("Protocol.FMRI___", ith_names[ith_names %in% MT1_cols])



    # relocate
    for(k in length(MT1_cols):1){
      ith_protocol = ith_protocol %>% relocate(ends_with(MT1_cols[k]))
    }
    for(k in length(EPB_cols):1){
      ith_protocol = ith_protocol %>% relocate(ends_with(EPB_cols[k]))
    }

    return(ith_protocol)
  })
  Renamed_EPB_protocol.df = do.call(rbind, Renamed_EPB_protocol.list)





  #====================================================================================================
  # renaming protocol : MT1
  #====================================================================================================
  # MT1_protocol_ncol = sapply(MT1_protocol.list, ncol)
  MT1_cols_names = c("Slice Thickness", "Field Strength", "Manufacturer", "Mfg Model", "Acquisition Plane", "Matrix Z", "Acquisition Type", "Weighting")
  Renamed_MT1_protocol.list = lapply(MT1_protocol.list, FUN=function(ith_protocol, ...){
    # ith_protocol = MT1_protocol.list[[1]]
    ith_cols_dont_have = MT1_cols_names[!MT1_cols_names %in% names(ith_protocol)]
    if(length(ith_cols_dont_have) > 0){
      for(j in 1:length(ith_cols_dont_have)){
        ith_protocol[, ith_cols_dont_have[j]] = "NA"
      }
    }
    ith_names = names(ith_protocol)
    names(ith_protocol) = paste0("Protocol.MRI___", ith_names)
    for(k in length(MT1_cols_names):1){
      ith_protocol = ith_protocol %>% relocate(ends_with(MT1_cols_names[k]))
    }
    return(ith_protocol)
  })
  Renamed_MT1_protocol.df = do.call(rbind, Renamed_MT1_protocol.list)




  #====================================================================================================
  # Combine
  #====================================================================================================
  EPB.df = do.call(rbind, data.list[[1]])
  MT1.df = do.call(rbind, data.list[[2]])
  EPB.df$IMAGING.PROTOCOL = NULL
  MT1.df$IMAGING.PROTOCOL = NULL
  Combined_EPB.df = cbind(EPB.df, Renamed_EPB_protocol.df) %>% as_tibble
  Combined_MT1.df = cbind(MT1.df, Renamed_MT1_protocol.df) %>% as_tibble


  return(list(fMRI = Combined_EPB.df, MRI = Combined_MT1.df))
}





















