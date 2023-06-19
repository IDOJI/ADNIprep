RS.fMRI_1.3_Diagnosis___Extract.Demographics___Gender = function(Data.list){

  Gender.list = lapply(seq_along(Data.list), function(i,...){
    ith_RID.df = Data.list[[i]]

    # Hand
    ith_Hand = ith_RID.df$PTDEMO___PTHAND %>% na.omit %>% unique
    if(1 %in% ith_Hand | "Right" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Right", nrow(ith_RID.df))
    }else if(2 %in% ith_Hand | "Left" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Left", nrow(ith_RID.df))
    }


    # Gender
    ith_Gender = ith_RID.df$SEX %>% na.omit %>% unique
    if("Female" %in% ith_Gender | "F" %in% ith_Gender){
      ith_RID.df$ADNIMERGE___PTGENDER = rep("Female", nrow(ith_RID.df))
      ith_RID.df$SEX = rep("Female", nrow(ith_RID.df))
    }else if("Male" %in% ith_Gender | "M" %in% ith_Gender){
      ith_RID.df$ADNIMERGE___PTGENDER = rep("Male", nrow(ith_RID.df))
      ith_RID.df$SEX = rep("Male", nrow(ith_RID.df))
    }

    return(ith_RID.df)
  })


  cat("\n",crayon::green("Checking"), crayon::red("Gender"), crayon::green("is done!"),"\n")
  return(Gender.list)

}
