RS.fMRI_1.3_Diagnosis___Extract.Demographics___Education = function(Data.list){
  Education.list = lapply(seq_along(Data.list), function(i){
    ith_RID.df = Data.list[[i]]
    ith_RID = ith_RID.df$RID %>% na.omit %>% as.character %>% unique

    ith_Edu_1 = ith_RID.df$ADNIMERGE___PTEDUCAT %>% na.omit %>% as.numeric %>% unique
    ith_Edu_2 = ith_RID.df$PTDEMO___PTEDUCAT %>% na.omit %>% as.numeric %>% unique

    if(length(ith_Edu_1)>0){
      if(length(which(ith_Edu_1==(-4)))>0){
        ith_Edu_1 = ith_Edu_1[-which(ith_Edu_1==(-4))]
      }
    }

    if(length(ith_Edu_2)>0){
      if(length(which(ith_Edu_2==(-4)))>0){
        ith_Edu_2 = ith_Edu_2[-which(ith_Edu_2==(-4))]
      }
    }

    ith_Edu = c(ith_Edu_1, ith_Edu_2) %>% unique

    if(length(ith_Edu)==1){
      ith_RID.df$PTDEMO___PTEDUCAT = ith_RID.df$ADNIMERGE___PTEDUCAT = ith_Edu
      return(ith_RID.df)
    }else{
      stop(paste("There are more than two : ", ith_RID))
    }

  })

  cat("\n",crayon::green("Checking"), crayon::red("Education"), crayon::green("is done!"),"\n")
  return(Education.list)
}
