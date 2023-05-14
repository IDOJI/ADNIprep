RS.fMRI_2.9_Extract.Specific.ImageID___Rearrange.Files = function(path_All.Subjects.EPB.List.File,
                                                                  path_ADNI.Unzipped.Folders){
  RS.fMRI_2.5_Changing.Folders.Names.By.Sub.Numbering(path_All.Subjects.EPB.List.File,
                                                      path_ADNI.Unzipped.Folders)


  RS.fMRI_2.6_Changing.Folders.Names.for.DPABI(path_ADNI.Unzipped.Folders)

  cat("\n", crayon::bgMagenta("Step 2.9"), crayon::red("Rearranging newly downloaded files"), crayon::blue("is done!"),"\n")
}
