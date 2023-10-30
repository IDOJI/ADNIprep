RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Sorted.FC.by.Dist.for.Each.Region = function(Brain_Region, FC.list, Center_Dist.mat, path_Export, preprocessing_pipeline, figure=F){
  #===============================================================================
  # path Export
  #===============================================================================
  path_Export_2 = paste0(path_Export, "/", preprocessing_pipeline)
  dir.create(path_Export_2, F)




  #===============================================================================
  # Sort FC by Distance for each brain region
  #===============================================================================
  FC_Sorted.list = lapply(Brain_Region, function(kth_Region){
    k = which(Brain_Region == kth_Region)

    kth_Region_FC = FC.list[[k]]
    kth_Dist = Center_Dist.mat[,k]
    kth_Order = order(kth_Dist)

    kth_Dist_Sorted = kth_Dist[kth_Order]
    kth_Region_FC_Sorted = kth_Region_FC[kth_Order,]


    if(figure){
      png(filename = paste0(path_Export_2, "/", kth_Region, ".png"), bg="white", width = 5000, height = 1000)
      # Set the character expansion for the main title
      par(cex.main = 2)  # Adjust the value (2) to change the font size
      # png(filename = paste0("C:/Users/lleii/Desktop","/test", ".png"), bg="white", width = 5000, height = 1000)
      matplot(x= kth_Dist_Sorted, y = kth_Region_FC_Sorted, type = "l", main = paste0("Region : ", kth_Region))
      # Draw vertical lines
      abline(v = kth_Dist_Sorted, col = "red", lty = 2)  # Adjust the color and line type as needed
      dev.off()
    }


    cat("\n", crayon::red(kth_Region), crayon::green("is done!"),"\n")

    kth_Region_FC_Sorted_with_Mean.Dist = cbind(Mean_Dist = kth_Dist_Sorted, kth_Region_FC_Sorted)
    kth_Region_FC_Sorted_with_Mean.Dist
  })
  names(FC_Sorted.list) = Brain_Region





  #===============================================================================
  # Export
  #===============================================================================
  dir.create(path_Export, F)
  saveRDS(FC_Sorted.list, paste0(path_Export_2, ".rds"))



  return(FC_Sorted.list)
}
