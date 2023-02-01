RS.fMRI_4.4_Combine.Regardless.Of.Manufacturers = function(Combined_Subjects_Info.list){
  for(i in 1:length(Combined_Subjects_Info.list)){
    ### Subjects' information
    if(i==1){
      Combined_Subjects_Info.list[[i]] = do.call(rbind, Combined_Subjects_Info.list[[i]])
      ### Signals
    }else if(i==2){
      ith_Combined.list = list()
      n = length(Combined_Subjects_Info.list[[i]])
      for(k in 1:n){
        ith_Combined.list = c(ith_Combined.list, Combined_Subjects_Info.list[[i]][[k]])
      }
      Combined_Subjects_Info.list[[i]] = ith_Combined.list
      ### Correlation
    }else{
      ith_Combined_1.list = list()
      ith_Combined_2.list = list()
      n = length(Combined_Subjects_Info.list[[i]][[1]])
      for(k in 1:n){
        ith_Combined_1.list = c(ith_Combined_1.list, Combined_Subjects_Info.list[[i]][[1]][[k]])
        ith_Combined_2.list = c(ith_Combined_2.list, Combined_Subjects_Info.list[[i]][[2]][[k]])
      }
      Combined_Subjects_Info.list[[i]][[1]] = ith_Combined_1.list
      Combined_Subjects_Info.list[[i]][[2]] = ith_Combined_2.list
    }
  }
  return(Combined_Subjects_Info.list)
}
