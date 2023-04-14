RS.fMRI_4.2_Extracting.Results___ROI.Signals___Combining.by.TimePoints = function(Grouped_Signals){
  ### Extracting timepoints for each ROI
  TimePoints = sapply(Grouped_Signals[[1]], FUN=function(jth_subject){
    length(jth_subject)
  })
  TimePointsTypes = unique(TimePoints)



  ### Combine by same TimePointsType for each ROI
  ROISignals_Grouped_by_TimePointsTypes = lapply(Grouped_Signals, FUN=function(ith_ROI, ...){
    ith_ROISignals_Grouped_by_TimePointsTypes = lapply(TimePointsTypes, FUN=function(ith_TimePointType, ...){
      ith_ROI[TimePoints == ith_TimePointType]
    })
    names(ith_ROISignals_Grouped_by_TimePointsTypes) = TimePointsTypes
    return(ith_ROISignals_Grouped_by_TimePointsTypes)
  })


  ### Extracting each
  Grouped_Signals.list = list()
  for(k in 1:length(TimePointsTypes)){
    Grouped_Signals.list[[k]] = list()
    for(r in 1:length(ROISignals_Grouped_by_TimePointsTypes)){
      Grouped_Signals.list[[k]][[r]] = ROISignals_Grouped_by_TimePointsTypes[[r]][[k]]
    }
    names(Grouped_Signals.list[[k]]) = names(ROISignals_Grouped_by_TimePointsTypes)
  }
  names(Grouped_Signals.list) = TimePointsTypes
  return(Grouped_Signals.list)
}
