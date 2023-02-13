RS.fMRI_4.2_Extracting.Results___ROI.Signals = function(path_Results.ROISignals, files_Norm.Pictures){
  ##############################################################################
  ### Files' list
  ##############################################################################
  path_ROISignals.list = lapply(path_Results.ROISignals, FUN=function(ith_path_Results.ROISignals){
    list.files(ith_path_Results.ROISignals, pattern=glob2rx("*ROISignals_Sub*txt*"), full.names = T)
  })



  ##############################################################################
  ### Files' list
  ##############################################################################
  ROISignals.list = lapply(path_ROISignals.list, FUN=function(path_ith_ROISignals){
    # path_ith_ROISignals = path_ROISignals.list[[1]]
    ith_Loaded.ROISignals = RS.fMRI_4.2_Extracting.Results___ROI.Signals___Loading.Files(path_ith_ROISignals)
  })




  ##############################################################################
  ### Adding Sub names
  ##############################################################################
  for(i in 1:length(ROISignals.list)){
    names(ROISignals.list[[i]]) = files_Norm.Pictures[[i]]
  }



  ##############################################################################
  ### Combining by each manufacture
  ##############################################################################
  combined_ROISignals.list = RS.fMRI_4.0_SUB___Combining.by.Scanner.Manufacturer(ROISignals.list)



  ##############################################################################
  ### Ordering by "Sub"
  ##############################################################################
  Ordered_by_Sub.list = lapply(combined_ROISignals.list, FUN=function(ith_manu.list){
    ith_manu.list[order(names(ith_manu.list))]
  })



  ##############################################################################
  # ROI signals이 0으로 나온 개체가 있으면 제외하기
  ##############################################################################
  RS.fMRI_4.2_Extracting.Results___ROI.Signals___Exclude.Zero.Signals = function(Ordered_by_Sub.list){
    have_zeros = list()
    for(i in 1:length(Ordered_by_Sub.list)){
      have_zeros[[i]] = lapply(Ordered_by_Sub.list[[i]], FUN=function(jth_signals){
        is.zero = apply(jth_signals %>% as.data.frame, MARGIN=2, FUN=function(kth_col){
          sum(kth_col == 0 )
        })
        if(sum(is.zero)!=0){
          return(sum(is.zero))
        }
      }) %>% rm_list_null
    }
    names(have_zeros) = names(Ordered_by_Sub.list)
    have_zeros = rm_list_null(have_zeros)
  }





    test = lapply(Signals, FUN=function(ith_Subject){
      # ith_Subject = Signals[[1]]
      is.zero = apply(ith_Subject %>% as.data.frame, MARGIN=2, FUN=function(kth_col){
        sum(kth_col == 0)
      })
      sum(is.zero)
    })



  return(Ordered_by_Sub.list)
}


















