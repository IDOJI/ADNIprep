# RS.fMRI_4. = function(path_completed.preprocessing, save.path=NULL, exclude.list=NULL){
#   # path_completed.preprocessing = "D:/ADNI/ADNI_RS.fMRI/@완료_New_Template_unified_segmentation"
#   #==================================================================================================
#   # 1) Results path
#   #==================================================================================================
#   path_Results = RS.fMRI_4.1_Extract.Rusults.Path(path_completed.preprocessing)
#   cat("\n", crayon::red("Step 4.1"), crayon::yellow("Extracting"),  crayon::red("'Results'"),crayon::yellow("path of each folder"), crayon::blue("is done !!") ,"\n")
#
#
#   #==================================================================================================
#   # 2) Extracting Results
#   #==================================================================================================
#   Extracted_Results.list = RS.fMRI_4.2_Extracting.Results(path_Results)
#   cat("\n", crayon::red("Step 4.1"), crayon::yellow("Extracting"),  crayon::red("'Results'"), crayon::blue("is done !!") ,"\n")
#
#
#   #==================================================================================================
#   # 3) Combining Results by Manufacturer
#   #==================================================================================================
#   RS.fMRI_4.3_Combine.Results.By.Manufacturer = function(Extracted_Results.list){
#     #==========================================================================
#     # Manufacturer
#     #==========================================================================
#     manufacturer = c("SIEMENS", "GE.MEDICAL.SYSTEMS", "Philips")
#     manu_BT = lapply(manufacturer, FUN=function(ith_manu){
#       return(c(paste0(ith_manu, "_SB"), paste0(ith_manu, "_MB")))
#     }) %>% unlist
#
#
#
#
#     #==========================================================================
#     # find folders
#     #==========================================================================
#     which_folders.list = lapply(manu_BT, FUN=function(ith_manu_BT, ...){
#       # ith_manu_BT = manu_BT[1]
#       grep(ith_manu_BT, Extracted_Results.list[[1]] %>% names)
#     })
#     names(which_folders.list) = manu_BT
#
#
#
#     #==========================================================================
#     # combining results
#     #==========================================================================
#     Combined_Results.list = rep(NA, length(Extracted_Results.list)) %>% as.list
#     names(Combined_Results.list) = names(Extracted_Results.list)
#     for(i in 1:length(which_folders.list)){
#       ith_folder = which_folders.list[[i]]
#       for(j in 1:length(ith_folder)){
#
#
#
#       }
#
#
#     }
#
#
#
#     for(i in 1:length(manu_BT)){
#       ith_manu_BT = manu_BT[i]
#       lapply(, FUN=function(kth_results, ...){
#         # kth_results = Extracted_Results.list[[1]]
#         selected_folders = grep(ith_manu_BT, names(kth_results))
#         for(i in)
#       })
#     }
#
#
#
#
#
#
#     for(i in 1:length(manu_BT)){
#       test = Extracted_Results.list[[]]
#       grep(manu_BT[i], folders)
#
#
#       lapply(ith_manu, FUN=function(kth){
#         Extracted_Results.list[[kth]]
#       })
#
#
#
#
#
#     }
#
#
#
#
#
#   }
#
#
#
#
#
#
#
#
#
#   Combined_by_RID.list = RS.fMRI_4.3_Combining.with.Subjects.Information(Extracted_Data.list, path_ADNI)
#   cat("\n", crayon::red("Step 4.3."), crayon::yellow("Combining subjects information"), crayon::blue("is done !!") ,"\n")
#   saving_data(rda.name = "ADNI___RS.fMRI___Group_All", rda = Combined_by_RID.list, path = save.path)
#
#
#
#   #==================================================================================================
#   # 4) Split by Research.Groups
#   #==================================================================================================
#   Split_by_Research_Groups.list = RS.fMRI_4.3_Combining.with.Subjects.Information___Split.by.Research.Groups(Combined_by_RID.list)
#   cat("\n", crayon::red("Step 4.4."), crayon::yellow("Splitting by research groups"), crayon::blue("is done !!") ,"\n")
#
#
#
#   #==================================================================================================
#   # 5) Data saving
#   #==================================================================================================
#   if(!is.null(save.path)){
#     group_names = names(Split_by_Research_Groups.list)
#     filenames = paste0("ADNI___RS.fMRI___Group_", group_names)
#     for(i in 1:length(filenames)){
#       saving_data(rda.name = filenames[i], rda = Split_by_Research_Groups.list[[i]], path = save.path)
#     }
#     cat("\n", crayon::red("Step 4.5."), crayon::yellow("Saving data for each group"), crayon::blue("is done !!") ,"\n")
#   }
#
#   cat("\n", crayon::bgRed("Step 4"), crayon::blue("is all done !!") ,"\n")
# }
