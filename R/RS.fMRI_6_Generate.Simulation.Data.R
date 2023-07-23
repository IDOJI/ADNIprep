RS.fMRI_6_Generate.Simulation.Data = function(path_Coordinates = "C:/Users/lleii/Dropbox/Github/Papers___Data/ADNI___RS.fMRI___BOLD.Signals___Coordinates/FunImgARCWSF___Coordinates.rds",
                                              path_Export,
                                              save.as.rds=T,
                                              Dim = c(61, 73, 61),
                                              N_timepoints = 187,
                                              base = 0,
                                              TR = 3,
                                              SNR = 1,
                                              noise = "none",
                                              type = "gaussian",
                                              N_Subjects = 100,
                                              return.as.NIFTI=T){
  # Default option = Single Band (SB) of ADNI protocol
  # MB should be different.
  # noise = c("white", "physiological")
  #=============================================================================
  # Coordinates
  #=============================================================================
  Coordinates = readRDS(path_Coordinates)
  Coordinates_New = lapply(Coordinates, function(y){
    lapply(y, function(x){
      strsplit(x, "_")[[1]] %>% as.numeric
    })
  })
  names(Coordinates_New) = names(Coordinates)

  # combining Coordinates
  Combined_Coordinates = c()
  for(k in 1:length(Coordinates_New)){
    Combined_Coordinates = c(Combined_Coordinates, Coordinates_New[[k]])
  }









  #=============================================================================
  # Sub Function
  #=============================================================================
  fit_length = function(x.vec, fit.num){
    if(class(x.vec)=="numeric"){
      x.vec = as.character(x.vec)
    }

    New_x.vec = sapply(x.vec, function(y){
      if(nchar(y)>fit.num){
        stop("fit.num should larger!")
      }else{
        while(nchar(y) != fit.num){
          y = paste("0", y, collapse = "", sep = "")
        }
        return(y)
      }
    })

    return(New_x.vec)
  }







  #=============================================================================
  # Generate Simulation of RS-fMRI on Multiple Subjects
  #=============================================================================
  File.Name.Numbering = paste0("Sub_", fit_length(1:N_Subjects, nchar(N_Subjects[length(N_Subjects)])))
  Generated_Data.list = lapply(File.Name.Numbering, function(nth_File.Name.Numbering, ...){
    RS.fMRI_6_Generate.Simulation.Data___Single.Subject(path_Export,
                                                        save.as.rds,
                                                        File.Name.Numbering = nth_File.Name.Numbering,
                                                        Combined_Coordinates,
                                                        Dim,
                                                        N_timepoints,
                                                        base,
                                                        TR,
                                                        SNR,
                                                        noise,
                                                        type,
                                                        return.as.NIFTI)
  })






  #=============================================================================
  # Returning results
  #=============================================================================
  if(length(Generated_Data.list)==1){
    return(Generated_Data.list[[1]])
  }else{
    return(Generated_Data.list)
  }
}


















