# RS.fMRI_1.4_Demographics = function(Merged_Diagnosis.list, path_Subjects_APOE){
#   #=============================================================================
#   # Handedness
#   #=============================================================================
#   Handedness.list = RS.fMRI_1.4_Demographics___Handedness(Merged_Diagnosis.list)
#
#
#
#
#   #=============================================================================
#   # Gender
#   #=============================================================================
#   Gender.list = RS.fMRI_1.4_Demographics___Gender(Handedness.list)
#
#
#
#
#   #=============================================================================
#   # Retirement
#   #=============================================================================
#   Retire.list = RS.fMRI_1.4_Demographics___Retirement(Gender.list)
#
#
#
#
#
#   #=============================================================================
#   # Education
#   #=============================================================================
#   Education.list = RS.fMRI_1.4_Demographics___Education(Retire.list)
#
#
#
#
#
#
#   #=============================================================================
#   # Marital status
#   #=============================================================================
#   Marriage.list = RS.fMRI_1.4_Demographics___Marriage(Education.list)
#
#
#
#
#
#
#   #=============================================================================
#   # APOE
#   #=============================================================================
#   APOE.list = RS.fMRI_1.4_Demographics___APOE(Marriage.list)
#
#
#
#   #=============================================================================
#   # ADAS
#   #=============================================================================
#   path_Subjects_ADAS = "C:/Users/lleii/Dropbox/Github/Rpkgs/Papers___Data/Data___ADNI___RS.fMRI___Subjects.Lists/Subjects_Lists_Downloaded/ADAS_ADNIGO23_21Jun2023.csv"
#
#
#   RS.fMRI_1.4_Demographics___ADAS  = function(Data.list, path_Subjects_ADAS){
#     # Data.list = APOE.list
#     if(grep("\\.csv", path_Subjects_ADAS) %>% length>0){
#       ADAS.df = read.csv(path_Subjects_ADAS)
#     }else{
#       ADAS.df = read.csv(paste0(path_Subjects_ADAS, ".csv"))
#     }
#     ADAS.df$USERDATE = ADAS.df$USERDATE %>% as.Date
#
#
#
#     # merge with ADAS
#     Merged_ADAS.list = lapply(seq_along(Data.list), function(i, ...){
#       ith_RID.df = Data.list[[i]]
#
#       ith_RID.df$NEW_EXAMDATE = ith_RID.df$NEW_EXAMDATE %>% as.Date
#       ith_Index = which(!is.na(ith_RID.df$STUDY.DATE))
#       ith_Study.Date = ith_RID.df$STUDY.DATE %>% na.omit %>% as.Date
#
#       ith_RID = ith_RID.df$RID %>% na.omit %>% unique %>% as.numeric
#       if(ith_RID %in% ADAS.df$RID){
#         ith_ADAS.df = ADAS.df %>% filter(RID == ith_RID)
#
#         ith_ADAS_Dates = ith_ADAS.df$USERDATE
#
#         # Extract ADAS index
#         ith_ADAS_Dates_Index = difftime(ith_Study.Date, ith_ADAS_Dates) %>% abs %>% which.min
#
#         # Selected Scores
#         ith_ADAS_TOTAL.SCORE_11 = ith_ADAS.df$TOTSCORE[ith_ADAS_Dates_Index]
#         ith_ADAS_TOTAL.SCORE_13 = ith_ADAS.df$TOTAL13[ith_ADAS_Dates_Index]
#
#
#         # combine ADAS
#         ith_ADAS_Added.df = data.frame(STUDY.DATE = ith_Study.Date %>% as.character,
#                                        ADAS.DATE = ith_ADAS_Dates[ith_ADAS_Dates_Index] %>% as.character,
#                                        DATES.DIFF = difftime(ith_Study.Date, ith_ADAS_Dates[ith_ADAS_Dates_Index]) %>% as.numeric,
#                                        ADAS_11 = ith_ADAS_TOTAL.SCORE_11 %>% as.numeric,
#                                        ADAS_13 = ith_ADAS_TOTAL.SCORE_13 %>% as.numeric)
#
#         ith_Merged.df = merge(ith_ADAS_Added.df, ith_RID.df, by = "STUDY.DATE", all = T) %>% arrange(NEW_EXAMDATE)
#       }else{
#         ith_ADAS_Added.df = data.frame(STUDY.DATE = ith_Study.Date,
#                                        ADAS.DATE = NA,
#                                        DATES.DIFF = NA,
#                                        ADAS_11 = NA,
#                                        ADAS_13 = NA)
#
#         ith_Merged.df = merge(ith_ADAS_Added.df, ith_RID.df, by = "STUDY.DATE", all = T) %>% arrange(NEW_EXAMDATE)
#       }
#       return(ith_Merged.df)
#     })
# # ##################################################################################
#
#     Merged_ADAS_2.list = lapply(seq_along(Data.list), function(i, ...){
#       ith_RID.df = Data.list[[i]]
#
#       ith_RID.df$NEW_EXAMDATE = ith_RID.df$NEW_EXAMDATE %>% as.Date
#
#       ith_Index = which(!is.na(ith_RID.df$STUDY.DATE))
#       ith_Study.Date_Index = which(!is.na(ith_RID.df$STUDY.DATE))
#
#       ith_Study.Date =  ith_RID.df$STUDY.DATE[ith_Study.Date_Index] %>% as.Date()
#
#       ith_VISCODE2 = ith_RID.df$VISCODE2[ith_Study.Date_Index]
#
#
#       ith_RID = ith_RID.df$RID %>% na.omit %>% unique %>% as.numeric
#
#       if(ith_RID %in% ADAS.df$RID){
#         ith_ADAS.df = ADAS.df %>% filter(RID == ith_RID)
#
#         ith_ADAS_VISCODE2 = ith_ADAS.df$VISCODE2
#         ith_ADAS_Dates = ith_ADAS.df$USERDATE %>% as.Date()
#
#
#         if(ith_VISCODE2 %in% ith_ADAS_VISCODE2){
#           ith_ADAS_Selected.df = ith_ADAS.df[which(ith_ADAS_VISCODE2 %in% ith_VISCODE2), ]
#
#
#           # combine ADAS
#           ith_ADAS_Added.df = data.frame(STUDY.DATE = ith_Study.Date %>% as.character,
#                                          ADAS.DATE = ith_ADAS_Selected.df$USERDATE,
#                                          DATES.DIFF = difftime(ith_Study.Date, ith_ADAS_Selected.df$USERDATE),
#                                          ADAS_11 = ith_ADAS_Selected.df$TOTSCORE %>% as.numeric,
#                                          ADAS_13 = ith_ADAS_Selected.df$TOTAL13 %>% as.numeric,
#                                          VISCODE2_ADAS = ith_ADAS_Selected.df$VISCODE2)
#           ith_Merged.df = merge(ith_ADAS_Added.df, ith_RID.df, by = "STUDY.DATE", all = T) %>% arrange(NEW_EXAMDATE)
#
#         }else{
#           # Extract ADAS index
#           ith_selected_Dates_Index = which(ith_ADAS_Dates < ith_Study.Date)
#           ith_ADAS_Max_Date_Index = ith_selected_Dates_Index[length(ith_selected_Dates_Index)]
#           if(length(ith_ADAS_Max_Date_Index)==0){
#             ith_ADAS.DATE = NA
#             ith_diff.time = NA
#           }else{
#             ith_ADAS.DATE = ith_ADAS_Dates[ith_ADAS_Max_Date_Index] %>% as.character
#             ith_diff.time = difftime(ith_Study.Date, ith_ADAS_Dates[ith_ADAS_Dates_Index]) %>% as.numeric
#           }
#
#           # Selected Scores
#           ith_ADAS_VISCODE2 = ith_ADAS.df$VISCODE2[ith_ADAS_Max_Date_Index]
#           ith_ADAS_TOTAL.SCORE_11 = ith_ADAS.df$TOTSCORE[ith_ADAS_Max_Date_Index]
#           ith_ADAS_TOTAL.SCORE_13 = ith_ADAS.df$TOTAL13[ith_ADAS_Max_Date_Index]
#
#           if(length(ith_ADAS_TOTAL.SCORE_11)==0){
#             ith_ADAS_TOTAL.SCORE_11 = NA
#           }
#           if(length(ith_ADAS_TOTAL.SCORE_13)==0){
#             ith_ADAS_TOTAL.SCORE_13 = NA
#           }
#           if(length(ith_ADAS_VISCODE2)==0){
#             ith_ADAS_VISCODE2 = NA
#           }
#           # combine ADAS
#           ith_ADAS_Added.df = data.frame(STUDY.DATE = ith_Study.Date %>% as.character(),
#                                          ADAS.DATE = ith_ADAS.DATE,
#                                          DATES.DIFF = ith_diff.time,
#                                          ADAS_11 = ith_ADAS_TOTAL.SCORE_11 %>% as.numeric,
#                                          ADAS_13 = ith_ADAS_TOTAL.SCORE_13 %>% as.numeric,
#                                          VISCODE2_ADAS = ith_ADAS_VISCODE2)
#           ith_Merged.df = merge(ith_ADAS_Added.df, ith_RID.df, by = "STUDY.DATE", all = T) %>% arrange(NEW_EXAMDATE)
#         }
#         return(ith_Merged.df)
#       }
#     }) %>% rm_list_null
#
#
#
#
#
#
#   test_ADAS = lapply(seq_along(Merged_ADAS_2.list), function(i,...){
#       ith_RID.df = Merged_ADAS_2.list[[i]]
#       ith_index = which(!is.na(ith_RID.df$STUDY.DATE))
#       ith_Combined.df = data.frame(ADNIMERGE_ADAS_11 = ith_RID.df$ADNIMERGE___ADAS11[ith_index],
#                                    ADAS_11 = ith_RID.df$ADAS_11[ith_index],
#                                    ADNIMERGE_ADAS_13 = ith_RID.df$ADNIMERGE___ADAS13[ith_index],
#                                    ADAS_13 = ith_RID.df$ADAS_13[ith_index],
#                                    DATE.DIFF = ith_RID.df$DATES.DIFF[ith_index],
#                                    VISCDE2 = ith_RID.df$VISCODE2[ith_index],
#                                    VISCDE2_ADAS = ith_RID.df$VISCODE2_ADAS[ith_index])
#       return(ith_Combined.df)
#     })
#
#
#
#    index = sapply(Merged_ADAS_2.list, function(ith_RID.df,...){
#      ith_index = which(!is.na(ith_RID.df$STUDY.DATE))
#      if(!is.na(ith_RID.df$ADAS_11[ith_index]) &&  ith_RID.df$EPI___SLICE.BAND.TYPE[ith_index] == "SB"){
#        return(1)
#      }else{
#        return(0)
#      }
#    }) %>% rm_list_null()
#
# View(combined_SB)
#    combined_SB = do.call(rbind, test_ADAS)
#
#
#     SB.df = combined_SB[index==1,]
#     hist(SB.df$DATE.DIFF %>% as.numeric %>% abs)
#     dim(SB.df)
#    is.na(combined_SB$)
#
#
#    combined_SB %>% dim
#
#
#
#
#    hist(combined_SB$DATE.DIFF %>% as.numeric %>% abs)
#
#    combined_SB
#
#
#
#
# View(test.df )
#
#
#
# }
#
#
#
#
#
#
#   RID = sapply(APOE.list, function(ith_RID.df){
#     ith_RID.df$RID %>% na.omit %>% unique
#   })
# which(RID==751)
#   APOE.list[[31]] %>% View
#
#
#   length(test)
#   test = sapply(APOE.list, function(ith_RID.df){
#     y = ith_RID.df$ADNIMERGE___APOE4 %>% na.omit %>% unique
#     x = ith_RID.df$EPI___SLICE.BAND.TYPE %>% na.omit %>% unique
#     if(length(y)>0 && x == "SB"){
#       return(y)
#     }
#
#   }) %>% unlist
#
#   RS.fMRI_0_Data.Dictionary("TOTSCORE")
#   RS.fMRI_0_Data.Dictionary("COT3SCOR")
#   RS.fMRI_0_Data.Dictionary("COT2SCOR")
#   RS.fMRI_0_Data.Dictionary("COT1SCOR")
#
# Clipboard_to_path()
#
#
# 날짜 단위로 다시 MMSE 찾아보기
#
# ADAS_2$USERDATE
#
# ADAS_1$COT4TOTL
#
# ith_RID.df$ADNIMERGE___MMSE
#
#
# length(MMSE)
#
# MMSE.df =
#
# MMSE.df = read.csv("C:/Users/lleii/Dropbox/Github/Rpkgs/Papers___Data/Data___ADNI___RS.fMRI___Subjects.Lists/Subjects_Lists_Downloaded/MMSE_21Jun2023.csv")
#
#
# # VISCODE2가 NA인 경우...?
# MMSE = sapply(APOE.list, function(ith_RID.df, ...){
#   ith_index = which(!is.na(ith_RID.df$STUDY.DATE))
#   ith_VISCODE2 = ith_RID.df[ith_index,"VISCODE2"]
#   ith_RID = ith_RID.df$RID %>% na.omit %>% unique
#
#   ith_APOE = ith_RID.df$ADNIMERGE___APOE4 %>% na.omit %>% unique
#   ith_Band.Type = ith_RID.df$EPI___SLICE.BAND.TYPE %>% na.omit %>% unique
#
#   # ith_MMSE = ith_RID.df$ADNIMERGE___MMSE[ith_index] %>% na.omit %>% as.numeric
#
#   ith_MMSE = MMSE.df %>% filter(RID == ith_RID & VISCODE2 == ith_VISCODE2)
#   # z = ith_RID.df$ADNIMERGE___ADAS11[which(ith_RID.df$EPI___SLICE.BAND.TYPE=="SB")]
#   # z = ith_RID.df$ADNIMERGE___ADAS13[which(ith_RID.df$EPI___SLICE.BAND.TYPE=="SB")]
#   # ith_RID.df$ADNIMERGE___ADAS13
#
#   if(length(ith_APOE)>0 && ith_Band.Type == "SB" && length(ith_MMSE)>0){
#     return(ith_MMSE)
#   }
#
# }) %>% unlist
#
#
#   ADAS = sapply(APOE.list, function(ith_RID.df, ...){
#     ith_index = which(!is.na(ith_RID.df$STUDY.DATE))
#     ith_VISCODE2 = ith_RID.df[ith_index,"VISCODE2"]
#     ith_RID = ith_RID.df$RID %>% na.omit %>% unique
#
#
#
#     ith_APOE = ith_RID.df$ADNIMERGE___APOE4 %>% na.omit %>% unique
#     ith_Band.Type = ith_RID.df$EPI___SLICE.BAND.TYPE %>% na.omit %>% unique
#
#     ADAS_1$VISCODE
#     ith_ADAS_2 = ADAS_2 %>% filter(RID == ith_RID & VISCODE2 == ith_VISCODE2) %>% select(TOTSCORE) %>% unlist %>% as.vector
#
#     # z = ith_RID.df$ADNIMERGE___ADAS11[which(ith_RID.df$EPI___SLICE.BAND.TYPE=="SB")]
#     # z = ith_RID.df$ADNIMERGE___ADAS13[which(ith_RID.df$EPI___SLICE.BAND.TYPE=="SB")]
#     # ith_RID.df$ADNIMERGE___ADAS13
#
#     if(length(ith_APOE)>0 && ith_Band.Type == "SB" && length(ith_ADAS_11)>0){
#       return(ith_ADAS_11)
#     }
#
#   }) %>% unlist
#
# length(test)
#
#
#
#
#   #=============================================================================
#   # ADAS cog
#   #=============================================================================
#   RS.fMRI_1.4_Demographics___ADAS.Cog = function(Data.list){
#     # Data.list = APOE.list
#     Results.list = lapply(Data.list, function(ith_RID.df){
#       # ith_RID.df = Data.list[[1]]
#       ith_RID.df$ADNIMERGE___ADAS11
#       ith_RID.df$SUBJECT.ID
#
#       ith_RID.df$
# adas %>% View
#
# ith_RID.df$ADNIMERGE___ADAS13
# RS.fMRI_0_Data.Dictionary("ADAS13")
#
#
#
#
#     })
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
#   #=============================================================================
#   # demographic variable
#   #=============================================================================
#   Demo.list = RS.fMRI_1.4_Demographics___Renaming.Demographics(Marriage.list)
#
#
#
#
#
#
#   #=============================================================================
#   # Extract Demo variables
#   #=============================================================================
#   Selected.list = RS.fMRI_1.4_Demographics___Selecting.Variables(Demo.list)
#
#
#
#
#
#
#   #=============================================================================
#   # Binding
#   #=============================================================================
#   Binded.list = RS.fMRI_1.4_Demographics___Combining.Data(Selected.list)
#
#
#
#   cat("\n", crayon::green("Extracting Demographics is done!") ,"\n")
#   return(Binded.list)
# }
#
#
#
#
