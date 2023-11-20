RS.fMRI_1_Data.Selection___Demographics___Marriage = function(Data.list){
  # Data.list = Education.list
  Marriage.list = lapply(seq_along(Data.list), function(i){
    # print(i)
    ith_RID.df = Data.list[[i]]
    ith_Marry_1 = ith_RID.df$PTDEMO___PTMARRY %>% as.character
    ith_Marry_2 = ith_RID.df$ADNIMERGE___PTMARRY



    ith_Marry_1_New = rep(NA, length(ith_Marry_1))
    for(k in seq_along(ith_Marry_1)){
      kth = ith_Marry_1[k]
      if(!is.na(kth)){
        if(kth=="1"){
          kth = "Married"
        }else if(kth == "2"){
          kth = "Widowed"
        }else if(kth == "3"){
          kth = "Divorced"
        }else if(kth == "4"){
          kth = "Never Married"
        }else if(kth == "5"){
          kth = "Unknown"
        }else if(kth == "-4"){
          kth = NA
        }
      }



      if(k==1){
        ith_Marry_1_New[k] = kth
      }else{
        if(is.na(kth)){
          ith_Marry_1_New[k] = ith_Marry_1_New[k-1]
        }else{
          ith_Marry_1_New[k] = kth
        }
      }

    }# for


    #===========================================================================
    ith_Marry_2 = gsub(pattern="married", replacement = "Married", ith_Marry_2)




    #===========================================================================
    ith_Marry_Combined = rep(NA, length(ith_Marry_2))
    for(m in seq_along(ith_Marry_2)){
      mth_1 = ith_Marry_1_New[m]
      mth_2 = ith_Marry_2[m]
      if(is.na(mth_1) && is.na(mth_2)){
        ith_Marry_Combined[m] = NA
      }else if(!is.na(mth_1) && is.na(mth_2)){
        ith_Marry_Combined[m] = mth_1
      }else if(is.na(mth_1) && !is.na(mth_2)){
        ith_Marry_Combined[m] = mth_2
      }else{
        ith_Marry_Combined[m] = mth_2
      }
    }
    # if(length(ith_Marry)==1){
    #   ith_RID.df$PTDEMO___PTEDUCAT = ith_RID.df$ADNIMERGE___PTEDUCAT = ith_Edu
    #   return(ith_RID.df)
    # }
    ith_RID.df$PTDEMO___PTMARRY = ith_RID.df$ADNIMERGE___PTMARRY =ith_Marry_Combined
    return(ith_RID.df)
  })


  cat("\n",crayon::green("Checking"), crayon::red("Marriage"), crayon::green("is done!"),"\n")
  return(Marriage.list)
}
