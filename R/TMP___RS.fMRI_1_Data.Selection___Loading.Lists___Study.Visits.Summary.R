# RS.fMRI_1_Data.Selection___Loading.Lists___Study.Visits.Summary = function(Selected_RID, Subjects_Study.Visits.Summary, path_Subjects.Lists_Downloaded){
#   #=============================================================================
#   # Loading data
#   #=============================================================================
#   Data.df = read.csv(paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Study.Visits.Summary, ".csv"))
#
#
#
#
#   #=============================================================================
#   # RID
#   #=============================================================================
#   Data_2.df = Data.df %>% filter(RID %in% Selected_RID)
#   Data.df$RID %>% unique %>% length
#   Data_2.df
#
#
#
#   #=============================================================================
#   # names change
#   #=============================================================================
#   print_colnames(CV.df)
#   selected_cols = c("USERDATE", "USERDATE2", "CENROLL", "UPDATE_STAMP", "INCLUSION", "FAILINCLU", "EXCLUSION", "FAILEXCLU", "CONTINCLU", "CONTFAILI", "CONTEXCLU", "CONTFAILE", "CEMRI", "CRAND", "CDATE")
#   cols_index = which(names(CV.df) %in% selected_cols)
#   names(CV.df)[cols_index] = paste0("CLIELG___", selected_cols)
#
#
#
#
#   #=============================================================================
#   # replace elements
#   #=============================================================================
#   # CLIELG_Intersect_Selected.df = replace_elements(CLIELG_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c("Cognitively Normal", "Early MCI", "Late MCI", "Significant Memory Concern"), to = c("CN", "EMCI", "LMCI", "SMC"))
#
#
#
#
#   #=============================================================================
#   # as list
#   #=============================================================================
#   CV.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, CV.df)
#
#   return(CV.list)
#
#
#
# }
