RS.fMRI_5_Functional.Connectivity___Dynamic___Calculate.Cor.Mat = function(BOLD.df, brain.region.by.row = F, window.size, method = c("Pearson", "Spearman", "FisherZ")){
  # BOLD.df = ith_BOLD.df
  #===========================================================================
  # Columns must be brain regions
  #===========================================================================
  if(brain.region.by.row){
    BOLD.df = t(BOLD.df)
  }




  #===========================================================================
  # Extracting Rows' sequence by window.size
  #===========================================================================
  n_row = nrow(BOLD.df)
  end_point = window.size-1
  seq_by_window.list = lapply(1:(n_row-end_point), function(i, ...){
    i:(i+window.size - 1)
  })





  #===========================================================================
  # calculate Functional Connectivity
  #===========================================================================
  Cor_Mat.list = lapply(seq_by_window.list, function(ith_seq, ...){

    if(method == "Pearson" | method == "FisherZ"){
      cor.mat = cor(BOLD.df[ith_seq, ], method = "pearson")


      if(method == "FisherZ"){
        cor.mat = 0.5 * log((1 + cor.mat) / (1 - cor.mat))
      }


    }else if(method == "Spearman"){
      cor.mat = cor(BOLD.df[ith_seq, ], use = "everything", method = "spearman")
    }

    colnames(cor.mat) = rownames(cor.mat) = colnames(BOLD.df)

    return(cor.mat)
  })

  return(Cor_Mat.list)
}
