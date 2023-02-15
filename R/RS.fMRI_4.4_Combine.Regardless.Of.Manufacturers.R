RS.fMRI_4.4_Combine.Regardless.Of.Manufacturers = function(Combined_Subjects_Info.list){
  New_Combined_Subjects_Info.list = rep(NA, length(Combined_Subjects_Info.list)) %>% as.list
  for(i in 1:length(Combined_Subjects_Info.list)){
    # i=3
    ### Subjects' information
    if(i==1){
      New_Combined_Subjects_Info.list[[i]] = do.call(rbind, Combined_Subjects_Info.list[[i]])
      ### Signals
    }else if(i==2){
      ith_Combined.list = list()
      n = length(Combined_Subjects_Info.list[[i]])
      for(k in 1:n){
        ith_Combined.list = c(ith_Combined.list, Combined_Subjects_Info.list[[i]][[k]])
      }
      New_Combined_Subjects_Info.list[[i]] = ith_Combined.list
      ### Correlation
    }else{
      ith_Combined_1.list = list()
      ith_Combined_2.list = list()
      n = length(Combined_Subjects_Info.list[[i]][[1]])
      for(k in 1:n){
        ith_Combined_1.list = c(ith_Combined_1.list, Combined_Subjects_Info.list[[i]][[1]][[k]])
        ith_Combined_2.list = c(ith_Combined_2.list, Combined_Subjects_Info.list[[i]][[2]][[k]])
      }
      New_Combined_Subjects_Info.list[[i]] = list(ith_Combined_1.list, ith_Combined_2.list)
      names(New_Combined_Subjects_Info.list[[i]]) = names(Combined_Subjects_Info.list[[i]])
    }
    names(New_Combined_Subjects_Info.list) = names(Combined_Subjects_Info.list)
  }
  return(New_Combined_Subjects_Info.list)
}
