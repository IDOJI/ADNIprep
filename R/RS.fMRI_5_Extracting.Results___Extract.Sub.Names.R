RS.fMRI_4.2_Extracting.Results___Extract.Sub.Names = function(files){
  # files = ith_ROISignals_files
  dot_split = strsplit(files, "\\.")
  dot_split_selected = sapply(dot_split, FUN=function(ith_dot_split){
    # ith_dot_split = dot_split[[1]]
    return( ith_dot_split[1])
  })



  underbar_split = strsplit(dot_split_selected, "_")
  sub_names = sapply(underbar_split, FUN=function(ith_underbar_split){
    # ith_underbar_split = underbar_split[[1]]
    which_sub_ind = grep("Sub", ith_underbar_split)
    ith_splitted = ith_underbar_split[which_sub_ind:(which_sub_ind+1)]
    paste(ith_splitted[1], ith_splitted[2], sep="_")
  })

  return(sub_names)
}
