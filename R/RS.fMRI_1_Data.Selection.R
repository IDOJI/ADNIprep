# # what.date            = 1
# # Include_RID        = NULL
# # Include_ImageID    = NULL
# # Exclude_RID          = NULL
# # Exclude_ImageID = NULL
# # Exclude_Comments = NULL
# # Exclude_ImageID = c(Error_ImageID_0, Error_ImageID_1, Error_ImageID_2)
# RS.fMRI_1_Data.Selection = function(path_ADNI_SubjectsList_Downloaded, Exclude_ImageID = NULL){
#   # #=============================================================================
#   # # 0.Arguments Setting
#   # #=============================================================================
#   # path_Downloaded = list.files(path_ADNI_SubjectsList_Downloaded, full.names = T)
#   #
#   #
#   #
#   #
#   #
#   # #=============================================================================
#   # # Loading Data
#   # #=============================================================================
#   # input = RS.fMRI_1_Data.Selection___Loading.Data(path_Downloaded)
#   # save_1 = input
#   # # input = save_1
#   #
#   # registry = list.files("C:/Users/lleii/Dropbox/Data/ADNI/Subjects.Lists/Useful", full.names=T, pattern = "REGISTRY") %>% read.csv
#   # Data = lapply(registry$RID %>% sort, function(ith_RID){
#   #   registry %>% dplyr::filter(RID == ith_RID)
#   # }) %>% setNames(registry$RID %>% sort)
#   #
#   # viscode.list = lapply(Data, function(x){
#   #   x %>% dplyr::select(VISCODE)
#   # })
#   #
#   #
#   #
#   # #=============================================================================
#   # # Select only EPI, MT1
#   # #=============================================================================
#   # input = RS.fMRI_1_Data.Selection___Series.Description(input)
#   # save_2 = input
#   # # input = save_2
#   #
#   #
#   #
#   #
#   # #=============================================================================
#   # # Image ID Intersection
#   # #=============================================================================
#   # input = RS.fMRI_1_Data.Selection___ImageID(input)
#   # save_3 = input
#   # # input = save_3s
#   #
#   #
#   #
#   #
#   #
#   #
#   # #=============================================================================
#   # # VISCODE
#   # #=============================================================================
#   # RS.fMRI_1_Data.Selection___VISCODE = function(input){
#   #   #===========================================================================
#   #   # Add VISCODE for Search
#   #   #===========================================================================
#   #   input$List_Search = lapply(input$List_Search, RS.fMRI_1_Data.Selection___VISCODE___Search)
#   #
#   #   # Check NA
#   #   if(input$List_Search$Search_fMRI$VISCODE %>% is.na %>% sum != 0 || input$List_Search$Search_MRI$VISCODE %>% is.na %>% sum != 0){
#   #     stop("There are cases with no VISCODE")
#   #   }
#   #
#   #
#   #
#   #
#   #
#   #
#   #   #===========================================================================
#   #   # Remove subjects only having sc
#   #   #===========================================================================
#   #   # Define a function :
#   #   Extract_VISCODE = function(df, ith_RID){
#   #     df %>%
#   #     dplyr::filter(RID == ith_RID) %>%
#   #     dplyr::select("VISCODE") %>%
#   #     unlist
#   #   }
#   #
#   #
#   #
#   #
#   #   # fMRI RID
#   #   RID_Search_fMRI = input$List_Search$Search_fMRI$RID %>% unique() %>% sort()
#   #
#   #   # Intersection VISCODE for each RID
#   #   Intersection_by_RID = lapply(RID_Search_fMRI, function(ith_RID) {
#   #
#   #      intersect(Extract_VISCODE(input$List_Search$Search_fMRI, ith_RID),
#   #                Extract_VISCODE(input$List_Search$Search_MRI, ith_RID))
#   #
#   #   }) %>% setNames(RID_Search_fMRI)
# #
# #
# #
# #
# #     # Extract the RID and VISCODE columns
# #     fMRI_RID_VISCODE <- with(input$List_Search$Search_fMRI, data.frame(RID, VISCODE))
# #     MRI_RID_VISCODE <- with(input$List_Search$Search_MRI, data.frame(RID, VISCODE))
# #
# #     # Find common RIDs with the same VISCODE
# #     common_RIDs <- intersect(fMRI_RID_VISCODE$RID, MRI_RID_VISCODE$RID)
# #
# #     # Filter the datasets to only include common RIDs
# #     fMRI_common <- input$List_Search$Search_fMRI[input$List_Search$Search_fMRI$RID %in% common_RIDs, ]
# #     MRI_common <- input$List_Search$Search_MRI[input$List_Search$Search_MRI$RID %in% common_RIDs, ]
# #
# #     # Now, for each common RID, check if there is a matching VISCODE in both datasets
# #     final_common_RIDs <- lapply(common_RIDs, function(rid) {
# #       fMRI_viscode <- fMRI_common$VISCODE[fMRI_common$RID == rid]
# #       MRI_viscode <- MRI_common$VISCODE[MRI_common$RID == rid]
# #
# #       # Find the intersection of VISCODEs for the current RID
# #       intersect(fMRI_viscode, MRI_viscode)
# #     })
# #
# #     # Filter out RIDs without matching VISCODEs
# #     final_common_RIDs <- Filter(function(x) length(x) > 0, final_common_RIDs)
# #     final_RIDs <- names(final_common_RIDs)
# #
# #     # Use these final_RIDs to filter your datasets
# #     filtered_fMRI <- input$List_Search$Search_fMRI[input$List_Search$Search_fMRI$RID %in% final_RIDs, ]
# #     filtered_MRI <- input$List_Search$Search_MRI[input$List_Search$Search_MRI$RID %in% final_RIDs, ]
# #
# #
# #   }
# #
# #   save_5 = input
# #
# #
# #   cat("\n", crayon::bgMagenta("Loading Data"), crayon::green("is done!"), "\n")
# #
# #
# #
#
#
#
#
#
#
#
#
#   #=============================================================================
#   # RID Intersection
#   #=============================================================================
#   input = RS.fMRI_1_Data.Selection___RID(input)
#   save_3 = input
#   # input = save_3
#
#   RID_NFQ = input$List_NFQ$NFQ$RID
#   RID_Search = input$List_Search$Search_fMRI$RID
#
#
#
#
#
#
#
#
#
#   #=============================================================================
#   # Date
#   #=============================================================================
#
#
#
#
#
#
#
#
#
#
#   #=============================================================================
#   # 3. Merging Subjects lists
#   #=============================================================================
#   Merged_Full.list = RS.fMRI_1_Data.Selection___Merging.Lists(Loaded_Data.list)
#
#
#
#
#
#
#
#
#   #============================================================================
#   # 4.Diagnosis
#   #============================================================================
#   Merged_Diagnosis.list = RS.fMRI_1_Data.Selection___Diagnosis(Merged_Full.list)
#
#
#
#
#
#
#
#   #===============================================================================
#   # 5. Demographics
#   #===============================================================================
#   Demographics.df = RS.fMRI_1_Data.Selection___Demographics(Merged_Diagnosis.list, path_Subjects.Lists_Downloaded, Subjects_APOE)
#
#
#
#
#
#
#   #===============================================================================
#   # 6. Imaging protocol
#   #===============================================================================
#   Protocol.df = RS.fMRI_1_Data.Selection___Imaging.Protocol(Demographics.df)
#
#   Final.list = list(Protocol.df, Demographics.df)
#
#
#
#
#
#   #============================================================================
#   # 7.Exporting Results
#   #============================================================================
#   if(is.null(path_Export_Subjects.Lists)){
#     ### returning results
#     text = paste("\n","Step 1 is all done !","\n")
#     cat(crayon::bgRed(text))
#     return(Final.list)
#   }else{
#     Final.list = RS.fMRI_1_Data.Selection___Exporting.Lists(Final.list,
#                                                             path_Export_Subjects.Lists)
#
#
#     ### returning results
#     text = paste("\n","Step 1 is all done !","\n")
#     cat(crayon::bgRed(text))
#     return(Final.list)
#   }
#
# }
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
