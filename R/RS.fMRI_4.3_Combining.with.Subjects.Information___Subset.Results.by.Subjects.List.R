RS.fMRI_4.3_Combining.with.Subjects.Information___Subset.Results.by.Subjects.List = function(Subjects.list, Extracted_Data.list){
  manufacturer = names(Subjects.list)
  manu_RS = names(Extracted_Data.list[[1]]) # ROI signals
  manu_FC = names(Extracted_Data.list[[2]]) # Functional Connectivity

  selected_subjects_lists.list = lapply(manu_RS, FUN=function(ith_manu, ...){
    ## index
    ind = unique(which(manu_RS==ith_manu), which(manu_FC==ith_manu))
    if(length(ind)>1){stop("Check the names of `ROI signals.list` and `Functional Connectivity`!")}

    ### ith data
    ith_RS_Data  = Extracted_Data.list[[1]][[ind]] # ROI signals
    ith_FC_Data  = Extracted_Data.list[[2]][[ind]] # Functional Connectivity


    ### subjects names
    ith_RS_Sub_names = names(ith_RS_Data)
    ith_FC_Sub_names = names(ith_FC_Data)
    if(length(ith_RS_Sub_names)!=length(ith_FC_Sub_names) && sum(ith_RS_Sub_names %in% ith_FC_Sub_names)!=length(ith_FC_Sub_names)){stop("The selected subjects of RS and FC is different !!")}


    ### ith subjects list
    ind_Subjects = grep(ith_manu, manufacturer, ignore.case = F)
    ith_Subjects = Subjects.list[[ind_Subjects]] %>% dplyr::filter(Sub_folder %in% ith_RS_Sub_names)

    return(ith_Subjects)
  })
  names(selected_subjects_lists.list) = manu_RS
  return(selected_subjects_lists.list)
}
