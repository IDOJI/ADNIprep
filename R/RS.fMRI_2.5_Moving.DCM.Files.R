RS.fMRI_2.5_Moving.DCM.Files = function(path_Subjects_RS.fMRI,
                                        Path_of_Created_Folders.list,
                                        Extracted_ImageID_Folders_Path.list){
  Manu_folders = c(list.files(path_Subjects_RS.fMRI, pattern = "_MB"),
                   list.files(path_Subjects_RS.fMRI, pattern = "_SB")) %>% sort

  lapply(Manu_folders, FUN=function(ith_Manu, ...){
    # ith_Manu = Manu_folders[3]
    ind = which(Manu_folders == ith_Manu)

    ### sub folders
    ith_Sub_EPB = Path_of_Created_Folders.list[[ind]][[1]]
    ith_Sub_MT1 = Path_of_Created_Folders.list[[ind]][[2]]

    ### Img folders
    ith_Img_EPB = Extracted_ImageID_Folders_Path.list[[ind]][[1]]
    ith_Img_MT1 = Extracted_ImageID_Folders_Path.list[[ind]][[2]]


    #===========================================================================
    # Copying files using robocopy
    #===========================================================================
    lapply(ith_Sub_EPB, FUN=function(jth_Sub, ...){
      # jth_Sub = ith_Sub_EPB[1]
      ind = which(ith_Sub_EPB==jth_Sub)
      ### moving EPB
      # 023_S_0031
      copy_files_fast(Source.Folder      = ith_Img_EPB[ind],
                      Destination.Folder = ith_Sub_EPB[ind],
                      move = T)
      ### copying MT1
      copy_files_fast(Source.Folder      = ith_Img_MT1[ind],
                      Destination.Folder = ith_Sub_MT1[ind],
                      move = T)

      text0 = crayon::yellow(ith_Manu)
      text1 = crayon::blue(": Moving EPB & MT1 files of")
      text2 = crayon::red(substr(jth_Sub, nchar(jth_Sub)-6, nchar(jth_Sub)))
      text3 = crayon::blue("is done!")
      cat("\n", text0, text1, text2, "\n")
    })
  })
}
