RS.fMRI_1.3_Exporting.List___SUB_Exporting.Comments = function(){

  ### Exporting comments ==========================================================================
  # EPB_comments.txt = paste("[Final_Selected]_Comments_EPB_(",list_names, ").csv", sep="")
  # MT1_comments.txt = paste("[Final_Selected]_Comments_MT1_(",list_names, ").csv", sep="")
  #
  # EPB_comments = EPB.df[which_col(EPB.df, "comment")] %>% unlist %>% unique
  # MT1_comments = MT1.df[which_col(MT1.df, "comment")] %>% unlist %>% unique
  #
  # ### writing csv
  # write.csv(x = EPB_comments, file = paste(sub_path, EPB_comments.txt, sep="/"), row.names = F)
  # write.csv(x = MT1_comments, file = paste(sub_path, MT1_comments.txt, sep="/"), row.names = F)

}

