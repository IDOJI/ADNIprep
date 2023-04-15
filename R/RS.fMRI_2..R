RS.fMRI_2. = function(path_raw = "D:/ADNI/ADNI_RS.fMRI_2/ADNI",
                      all.subjects.list.file = "C:/Users/lleii/Desktop/Subjects_Lists_Exported/0.All_Subjects/[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv"){
  ###############################################################
  # Selecting by Manufacturer
  ###############################################################
  subjects_list = read.csv(file = all.subjects.list.file)
  subjects_list$Band.Type = ifelse(subjects_list$FMRI_TR < 2000, "MB", "SB")
  subjects_list$MANUFACTURER = str_replace(subjects_list$MANUFACTURER, pattern = " ", replacement = ".")
  subjects_list$MANUFACTURER = str_replace(subjects_list$MANUFACTURER, pattern = " ", replacement = ".")

  Total_lists = list()
  Total_lists[[1]] = Manu_SIEMENS.SB_list = subjects_list %>% filter(MANUFACTURER == "SIEMENS" & FMRI_TR >= 2900)
  Total_lists[[2]] = Manu_SIEMENS.MB_list = subjects_list %>% filter(MANUFACTURER == "SIEMENS" & FMRI_TR < 1000)
  Total_lists[[3]] = Manu_GE.MEDICAL_list = subjects_list %>% filter(MANUFACTURER == "GE.MEDICAL.SYSTEMS")
  Total_lists[[4]] = Manu_Philips_list = subjects_list %>% filter(SLICE.ORDER.TYPE == "IA")



  ###############################################################
  # Adding "Sub" numbering & Folder names
  ###############################################################
  Folder.Names_Total.lists = lapply(Total_lists, FUN=function(ith_Manu_list){
    is.philips = grep("Philips", ith_Manu_list$MANUFACTURER, T) %>% length > 0


    Sub_numbering = paste0("Sub_", stringr::str_pad(1:nrow(ith_Manu_list), width = 3, pad = "0"))
    if(is.philips){
      Folder_names = paste0("Philips", "_", ith_Manu_list$Band.Type,"_", Sub_numbering, "_", "RID", "_", ith_Manu_list$RID)
    }else{
      Folder_names = paste0(ith_Manu_list$MANUFACTURER, "_", ith_Manu_list$Band.Type,"_", Sub_numbering, "_", "RID", "_", ith_Manu_list$RID)
    }

    cbind(Folder_names=Folder_names, Sub_numbering=Sub_numbering, ith_Manu_list)
  })
  Folder.Names_Total.df = do.call(rbind, Folder.Names_Total.lists)
  # View(Folder.Names_Total.df)



  ##############################################################################
  # Change Folder Names
  ##############################################################################
  raw_folders = list.files(path_raw)
  sapply(raw_folders[4:5], FUN=function(ith_raw_folder, ...){
    which_row = which(Folder.Names_Total.df$SUBJECT.ID == ith_raw_folder)
    if(length(which_row)==1){
      ### ith folder's path Change
      ith_FolderName = Folder.Names_Total.df[which_row, "Folder_names"]
      ith_FolderName_Path = paste0(path_raw, "/", ith_FolderName)
      file.rename(paste0(path_raw, "/", ith_raw_folder), ith_FolderName_Path) %>% invisible


      ### EPI, MT1 folders
      ith_which_EPI = grep("MRI", list.files(ith_FolderName_Path))
      ith_EPI_Folder_Path = list.files(ith_FolderName_Path, full.names=T)[ith_which_EPI]
      ith_MT1_Folder_Path = list.files(ith_FolderName_Path, full.names=T)[-ith_which_EPI]

      ith_FunRaw_Path = paste0(ith_FolderName_Path, "/", "FunRaw")
      ith_T1Raw_Path = paste0(ith_FolderName_Path, "/", "T1Raw")

      file.rename(ith_EPI_Folder_Path, ith_FunRaw_Path) %>% invisible()
      file.rename(ith_MT1_Folder_Path, ith_T1Raw_Path) %>% invisible()


      ### Sub folder
      ith_Sub = Folder.Names_Total.df[which_row, "Sub_numbering"]
      ith_FunRaw_Sub_Path = paste0(ith_FunRaw_Path, "/", ith_Sub)
      ith_T1Raw_Sub_Path = paste0(ith_T1Raw_Path, "/", ith_Sub)
      file.rename(list.files(ith_FunRaw_Path, full.names=T), ith_FunRaw_Sub_Path)
      file.rename(list.files(ith_T1Raw_Path, full.names=T), ith_T1Raw_Sub_Path)


      ### moving files
      FunRaw_Image_Folder_Path = list.files(ith_FunRaw_Sub_Path, full.names = T)
      T1Raw_Image_Folder_Path = list.files(ith_T1Raw_Sub_Path, full.names = T)

      ith_EPI_dcm_files = list.files(ith_FunRaw_Sub_Path, full.names = T, recursive = T)
      ith_MT1_dcm_files = list.files(ith_T1Raw_Sub_Path, full.names = T, recursive = T)
      tictoc::tic()
      lapply(ith_EPI_dcm_files, FUN=function(kth_dcm, ...){
        filesstrings::file.move(files = kth_dcm, destinations = ith_FunRaw_Sub_Path) %>% suppressMessages()
      }) %>% invisible()
      lapply(ith_MT1_dcm_files, FUN=function(kth_dcm, ...){
        filesstrings::file.move(files = kth_dcm, destinations = ith_T1Raw_Sub_Path) %>% suppressMessages()
      }) %>% invisible()
      tictoc::toc()

      ### Delete folders
      unlink(FunRaw_Image_Folder_Path, recursive=T)
      unlink(T1Raw_Image_Folder_Path, recursive=T)

      ### Slice Order Info
      is.philips = grep("Philips", ith_FolderName, T) %>% length > 0
      if(is.philips){
        SliceOrderInfo = cbind("Subject ID" = ith_Sub, "Slice Order Type" = "IA")
        write.table(SliceOrderInfo, paste0(ith_FolderName_Path, "/", "SliceOrderInfo.tsv"), row.names=F, quote=F, sep="\t")
      }

      cat("\n", crayon::bgRed(ith_FolderName), crayon::yellow("is done"), "\n")
    }
    cat("\n", crayon::bgRed(ith_raw_folder), crayon::yellow("is done"), "\n")
  })



  ##############################################################################
  # 5. final
  ##############################################################################
  text1 = crayon::bgMagenta("STEP 2")
  text2 = crayon::red("Moving DCM files")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")

}







#
#
# RS.fMRI_2. = function(path_ADNI = "D:/ADNI", All.Subjects=F){
#   ##############################################################################
#   # 0. Creating path
#   ##############################################################################
#   path_ADNI                =   path_ADNI                                     %>% path_tail_slash()
#   path_Subjects            =   paste(path_ADNI,     "ADNI_Subjects", sep="") %>% path_tail_slash()
#   path_Subjects_RS.fMRI    =   paste(path_ADNI,     "ADNI_RS.fMRI",  sep="") %>% path_tail_slash()
#   path_Subjects_Downloaded =   paste(path_Subjects, "Downloaded",    sep="") %>% path_tail_slash()
#
#
#
#
#   ##############################################################################
#   # 1. Checking missing files
#   ##############################################################################
#   RS.fMRI_2.1_Check.Missing.On.Unzipped.Files(path_Subjects_RS.fMRI, path_Subjects)
#   text1 = crayon::blue("2.1 : ")
#   text2 = crayon::red("Checking Missing Files on Unzipped Folders")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
#
#
#
#
#   ##############################################################################
#   # 2. Moving Slice Order file
#   ##############################################################################
#   RS.fMRI_2.2_Moving.Slice.Order.Info(path_Subjects, path_Subjects_RS.fMRI, All.Subjects)
#   text1 = crayon::blue("2.2 : ")
#   text2 = crayon::red("Moving Slice Order files")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
#
#
#
#
#   ##############################################################################
#   # 3. Creating Folder for DPABI
#   ##############################################################################
#   Path_of_Created_Folders.list = RS.fMRI_2.3_Creating.Folders.for.DPABI(path_Subjects, path_Subjects_RS.fMRI, All.Subjects) %>% suppressWarnings()
#   text1 = crayon::blue("2.3 : ")
#   text2 = crayon::red("Creating 'Sub' Folders")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
#
#
#
#   ##############################################################################
#   # 4. Extracting files Path for each ID
#   ##############################################################################
#   Extracted_ImageID_Folders_Path.list = RS.fMRI_2.4_Extracting.ImageID.Folders.Path.for.Each.Manufacturer(path_Subjects, path_Subjects_RS.fMRI)
#   text1 = crayon::blue("2.4 : ")
#   text2 = crayon::red("Extarcting ImageID folders Path for each ID")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
#
#
#
#   ##############################################################################
#   # 5. Moving DCM Files
#   ##############################################################################
#   RS.fMRI_2.5_Moving.DCM.Files(path_Subjects_RS.fMRI, Path_of_Created_Folders.list, Extracted_ImageID_Folders_Path.list)
#   text1 = crayon::blue("2.5 : ")
#   text2 = crayon::red("Creating Folders")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
#
#
#   ##############################################################################
#   # 5. final
#   ##############################################################################
#   text1 = crayon::bgMagenta("STEP 2")
#   text2 = crayon::red("Moving DCM files")
#   text3 = crayon::blue("is done!")
#   cat("\n", text1, text2, text3,"\n")
# }
