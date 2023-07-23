# path_Export = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep"
RS.fMRI_6_Generate.Simulation.Data___Single.Subject = function(path_Export,
                                                               save.as.rds=T,
                                                               File.Name.Numbering,
                                                               Combined_Coordinates,
                                                               Dim,
                                                               N_timepoints,
                                                               base,
                                                               TR,
                                                               SNR,
                                                               noise,
                                                               type,
                                                               return.as.NIFTI=T){

  #=============================================================================
  # Transform to NIFTI
  #=============================================================================
  Sim_Data = array(0, dim = c(Dim, N_timepoints))
  tictoc::tic()
  for(i in seq_along(Combined_Coordinates)){
    ith_Coordiante = Combined_Coordinates[[i]]

    ith_x = ith_Coordiante[1]
    ith_y = ith_Coordiante[2]
    ith_z = ith_Coordiante[3]

    Sim_Data[ith_x, ith_y, ith_z, ] = neuRosim::simTSrestingstate(nscan = N_timepoints,
                                                                  base = base,
                                                                  TR = TR,
                                                                  SNR = SNR,
                                                                  noise = noise,
                                                                  type = type)
  }
  tictoc::toc()





  #=============================================================================
  # Transform to NIFTI
  #=============================================================================
  # Create a nifti object
  Sim_NIFTI = oro.nifti::nifti(Sim_Data)


  # Write the nifti object to a file
  if(save.as.rds){
    saveRDS(Sim_NIFTI, paste0(path_Export, "/BOLD.Signals___Simulation___", File.Name.Numbering, ".rds")) %>% invisible()
  }else{
    oro.nifti::writeNIfTI(nim = Sim_NIFTI, filename = paste0(path_Export, "/BOLD.Signals___Simulation___", File.Name.Numbering), gzipped = FALSE) %>% invisible()
  }
  cat("\n", crayon::green("Exporting simulation data of RS-fMRI BOLD singals is done!"),"\n")




  if(return.as.NIFTI){
    return(Sim_NIFTI)
  }else{
    return(Sim_Data)
  }

}


















