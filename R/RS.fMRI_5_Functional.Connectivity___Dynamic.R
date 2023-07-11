RS.fMRI_5_Functional.Connectivity___Dynamic = function(path_BOLD.Signals=NULL, Voxelwise=F, path_Export, brain.region.direction="col", window.size, method = c("Pearson", "Spearman", "FisherZ"), Atlas="AAL3"){
  #=============================================================================
  # rds files list
  #=============================================================================
  path_BOLD.Signals_RDS = list.files(path_BOLD.Signals, full.names=T)





  #=============================================================================
  # The length of path Export
  #=============================================================================
  if(length(path_Export)==1){
    path_Export = rep(path_Export, times = length(path_BOLD.Signals_RDS))
  }else if(length(path_BOLD.Signals_RDS)!=length(path_Export)){
    stop("The length of path is different!")
  }




  #=============================================================================
  # Exporting Dynamic FC
  #=============================================================================
  Results = lapply(seq_along(path_BOLD.Signals_RDS), function(i, ...){

    ith_path_BOLD = path_BOLD.Signals_RDS[i]
    ith_path_Export = path_Export[i]
    ith_RID = basename(ith_path_BOLD) %>% str_extract("RID_\\d+")
    ith_Pipeline = basename(ith_path_BOLD) %>% str_extract("FunImg[^_]*")



    # Voxelwise ?
    if(Voxelwise){
      ith_BOLD.list = readRDS(ith_path_BOLD)
      ith_BOLD.df = do.call(rbind, ith_BOLD.list)
      colnames(ith_BOLD.df) = names(ith_BOLD.list)
      brain.region.direction = "col"
    }else{
      ith_BOLD.df = readRDS(ith_path_BOLD)
    }

    tictoc::tic()
    # Calculate Corr mat
    ith_Corr_Mat.list = RS.fMRI_5_Functional.Connectivity___Dynamic___Calculate.Cor.Mat(BOLD.df = ith_BOLD.df, brain.region.direction, window.size, method)
    cat("\n", crayon::yellow("Calculating FC by window.size is done :"), crayon::red(ith_RID),"\n")



    # Extracting Timeseries
    ith_Corr_Timeseries.df = RS.fMRI_5_Functional.Connectivity___Dynamic___Extract.Timeseries(Corr_Mat.list = ith_Corr_Mat.list)
    cat("\n", crayon::yellow("Extracting timeseries of FC is done :"), crayon::red(ith_RID),"\n")


    #Saving files

    if(method == "Pearson"){

      ith_path_Export_New = paste0(ith_path_Export, "ROI___", Atlas, "___", ith_Pipeline, "___Dynamic___Pearson___Raw")
      ith_path_Export_New_1 = paste0(ith_path_Export_New, "___Matrices")
      ith_path_Export_New_2 = paste0(ith_path_Export_New, "___Timeseries")
      dir.create(ith_path_Export_New_1, showWarnings = F)
      dir.create(ith_path_Export_New_2, showWarnings = F)

      saveRDS(ith_Corr_Mat.list, paste0(ith_path_Export_New_1, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Pearson___Raw___", "window.", window.size, ".rds"))
      saveRDS(ith_Corr_Timeseries.df, paste0(ith_path_Export_New_2, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Pearson___Raw___Timeseries___", "window.", window.size, ".rds"))

    }else if(method == "FisherZ"){





      ith_path_Export_New = paste0(ith_path_Export, "ROI___", Atlas, "___", ith_Pipeline, "___Dynamic___Pearson___FisherZ")
      ith_path_Export_New_1 = paste0(ith_path_Export_New, "___Matrices")
      ith_path_Export_New_2 = paste0(ith_path_Export_New, "___Timeseries")
      dir.create(ith_path_Export_New_1, showWarnings = F)
      dir.create(ith_path_Export_New_2, showWarnings = F)



      saveRDS(ith_Corr_Mat.list, paste0(ith_path_Export_New_1, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Pearson___FisherZ___", "window.", window.size, ".rds"))
      saveRDS(ith_Corr_Timeseries.df, paste0(ith_path_Export_New_2, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Pearson___FisherZ___Timeseries___", "window.", window.size, ".rds"))

    }else if(methd == "Spearman"){

      ith_path_Export_New = paste0(ith_path_Export, "ROI___", Atlas, "___", ith_Pipeline, "___Dynamic___Spearman")
      ith_path_Export_New_1 = paste0(ith_path_Export_New, "___Matrices")
      ith_path_Export_New_2 = paste0(ith_path_Export_New, "___Timeseries")
      dir.create(ith_path_Export_New_1, showWarnings = F)
      dir.create(ith_path_Export_New_2, showWarnings = F)



      saveRDS(ith_Corr_Mat.list, paste0(ith_path_Export_New_1, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Speraman___Raw___", "window.", window.size, ".rds"))
      saveRDS(ith_Corr_Timeseries.df, paste0(ith_path_Export_New_2, "/", ith_RID, "___FC___ROI___AAL3___", ith_Pipeline, "___Dynamic___Speraman___Raw___Timeseries___", "window.", window.size, ".rds"))

    }
    cat("\n", crayon::yellow("Saving dynamic FC is done :"), crayon::red(ith_RID),"\n")
    tictoc::toc()

  })

}
