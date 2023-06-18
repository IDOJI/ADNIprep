RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID___Extract.Data.by.RID = function(EPB_Selected.df, Data.list, Data_Name){
  # Data.list =BLCHANGE.list

  # EPB RID
  RID = EPB_Selected.df$RID %>% sort

  # Data RID
  RID_Data = Data.list %>% names %>% as.numeric

  # Combine datas
  warning_indices = c()
  New_Data.list = lapply(seq_along(RID), function(i, ...){
    tryCatch({
      ith_RID = RID[i]
      ith_EPB_Selected.df = EPB_Selected.df %>% filter(RID == ith_RID)


      if(ith_RID %in% RID_Data){
        ith_Data.df = Data.list[[which(RID_Data %in% ith_RID)]]
      }else{
        ith_Data.df = matrix(NA, 1, ncol(Data.list[[1]])) %>% as.data.frame

        names(ith_Data.df) = Data.list[[1]] %>% names


        # # # VISCODE2
        # # colname = "VISCODE"
        # # ith_ind_Data_VISCODE = names(ith_Data.df) %>% filter_by("VISCODE", any_include = T, exact_include = F, exclude = "VISCODE2", any_exclude = T, exact_exclude = F, as.ind = T)
        # #
        # # if(length(ith_ind_Data_VISCODE)>0){
        # #   ith_Data.df[1, grep(colname, names(ith_Data.df))] = ith_EPB_Selected.df[1, "VISCODE2"]
        # # }else{
        # #   ith_Data.df[1, grep(colname, names(ith_Data.df))] = ith_EPB_Selected.df[1, grep("VISCODE2", names(ith_EPB_Selected.df))]
        # # }
        #
        # # RID
        # colname = "RID"
        # ith_Data.df[1, grep(colname, names(ith_Data.df))] = ith_EPB_Selected.df[1, grep(colname, names(ith_EPB_Selected.df))]
      }

      return(ith_Data.df)
    }, warning = function(w){
      # Print iteration number when a warning occurs
      print(paste("Warning on iteration", i))

      # Store warning index
      warning_indices <<- c(warning_indices, i)
    })
  })

  # rename list
  names(New_Data.list) = RID


  cat("\n", crayon::green("Extracting Data by RID is done :"), crayon::red(Data_Name),"\n")



  # returning
  return(New_Data.list)
}
