RS.fMRI_1.3_Diagnosis___Extract.Demographics___Handedness = function(Data.list){
  Handedness.list = lapply(seq_along(Data.list), function(i,...){
    ith_RID.df = Data.list[[i]]

    # Hand
    ith_Hand = ith_RID.df$PTDEMO___PTHAND %>% na.omit %>% unique
    if(1 %in% ith_Hand | "Right" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Right", nrow(ith_RID.df))
    }else if(2 %in% ith_Hand | "Left" %in% ith_Hand){
      ith_RID.df$PTDEMO___PTHAND = rep("Left", nrow(ith_RID.df))
    }


    return(ith_RID.df)
  })
  cat("\n",crayon::green("Checking"), crayon::red("Handedness"), crayon::green("is done!"),"\n")

  return(Handedness.list )
}
