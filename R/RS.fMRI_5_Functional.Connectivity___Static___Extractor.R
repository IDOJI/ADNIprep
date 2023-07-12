RS.fMRI_5_Functional.Connectivity___Static___Extractor = function(path_Sub, Pipeline = "FunImgARCWSF", Atlas = "AAL3", path_Export){
  #=============================================================================
  # Select atlas : cat(paste0('"', AAL3[,1], '"'), sep=", ")
  #=============================================================================
  if(Atlas == "AAL1"){
    Atlas_Labels = c("Precentral_L", "Precentral_R", "Frontal_Sup_L", "Frontal_Sup_R", "Frontal_Sup_Orb_L", "Frontal_Sup_Orb_R", "Frontal_Mid_L", "Frontal_Mid_R", "Frontal_Mid_Orb_L", "Frontal_Mid_Orb_R", "Frontal_Inf_Oper_L", "Frontal_Inf_Oper_R", "Frontal_Inf_Tri_L", "Frontal_Inf_Tri_R", "Frontal_Inf_Orb_L", "Frontal_Inf_Orb_R", "Rolandic_Oper_L", "Rolandic_Oper_R", "Supp_Motor_Area_L", "Supp_Motor_Area_R", "Olfactory_L", "Olfactory_R", "Frontal_Sup_Medial_L", "Frontal_Sup_Medial_R", "Frontal_Med_Orb_L", "Frontal_Med_Orb_R", "Rectus_L", "Rectus_R", "Insula_L", "Insula_R", "Cingulum_Ant_L", "Cingulum_Ant_R", "Cingulum_Mid_L", "Cingulum_Mid_R", "Cingulum_Post_L", "Cingulum_Post_R", "Hippocampus_L", "Hippocampus_R", "ParaHippocampal_L", "ParaHippocampal_R", "Amygdala_L", "Amygdala_R", "Calcarine_L", "Calcarine_R", "Cuneus_L", "Cuneus_R", "Lingual_L", "Lingual_R", "Occipital_Sup_L", "Occipital_Sup_R", "Occipital_Mid_L", "Occipital_Mid_R", "Occipital_Inf_L", "Occipital_Inf_R", "Fusiform_L", "Fusiform_R", "Postcentral_L", "Postcentral_R", "Parietal_Sup_L", "Parietal_Sup_R", "Parietal_Inf_L", "Parietal_Inf_R", "SupraMarginal_L", "SupraMarginal_R", "Angular_L", "Angular_R", "Precuneus_L", "Precuneus_R", "Paracentral_Lobule_L", "Paracentral_Lobule_R", "Caudate_L", "Caudate_R", "Putamen_L", "Putamen_R", "Pallidum_L", "Pallidum_R", "Thalamus_L", "Thalamus_R", "Heschl_L", "Heschl_R", "Temporal_Sup_L", "Temporal_Sup_R", "Temporal_Pole_Sup_L", "Temporal_Pole_Sup_R", "Temporal_Mid_L", "Temporal_Mid_R", "Temporal_Pole_Mid_L", "Temporal_Pole_Mid_R", "Temporal_Inf_L", "Temporal_Inf_R", "Cerebelum_Crus1_L", "Cerebelum_Crus1_R", "Cerebelum_Crus2_L", "Cerebelum_Crus2_R", "Cerebelum_3_L", "Cerebelum_3_R", "Cerebelum_4_5_L", "Cerebelum_4_5_R", "Cerebelum_6_L", "Cerebelum_6_R", "Cerebelum_7b_L", "Cerebelum_7b_R", "Cerebelum_8_L", "Cerebelum_8_R", "Cerebelum_9_L", "Cerebelum_9_R", "Cerebelum_10_L", "Cerebelum_10_R", "Vermis_1_2", "Vermis_3", "Vermis_4_5", "Vermis_6", "Vermis_7", "Vermis_8", "Vermis_9", "Vermis_10")
  }else if(Atlas == "AAL3"){

    Atlas_Labels = c("Precentral_L", "Precentral_R", "Frontal_Sup_2_L", "Frontal_Sup_2_R", "Frontal_Mid_2_L", "Frontal_Mid_2_R", "Frontal_Inf_Oper_L", "Frontal_Inf_Oper_R", "Frontal_Inf_Tri_L", "Frontal_Inf_Tri_R", "Frontal_Inf_Orb_2_L", "Frontal_Inf_Orb_2_R", "Rolandic_Oper_L", "Rolandic_Oper_R", "Supp_Motor_Area_L", "Supp_Motor_Area_R", "Olfactory_L", "Olfactory_R", "Frontal_Sup_Medial_L", "Frontal_Sup_Medial_R", "Frontal_Med_Orb_L", "Frontal_Med_Orb_R", "Rectus_L", "Rectus_R", "OFCmed_L", "OFCmed_R", "OFCant_L", "OFCant_R", "OFCpost_L", "OFCpost_R", "OFClat_L", "OFClat_R", "Insula_L", "Insula_R", "Cingulate_Ant_L", "Cingulate_Ant_R", "Cingulate_Mid_L", "Cingulate_Mid_R", "Cingulate_Post_L", "Cingulate_Post_R", "Hippocampus_L", "Hippocampus_R", "ParaHippocampal_L", "ParaHippocampal_R", "Amygdala_L", "Amygdala_R", "Calcarine_L", "Calcarine_R", "Cuneus_L", "Cuneus_R", "Lingual_L", "Lingual_R", "Occipital_Sup_L", "Occipital_Sup_R", "Occipital_Mid_L", "Occipital_Mid_R", "Occipital_Inf_L", "Occipital_Inf_R", "Fusiform_L", "Fusiform_R", "Postcentral_L", "Postcentral_R", "Parietal_Sup_L", "Parietal_Sup_R", "Parietal_Inf_L", "Parietal_Inf_R", "SupraMarginal_L", "SupraMarginal_R", "Angular_L", "Angular_R", "Precuneus_L", "Precuneus_R", "Paracentral_Lobule_L", "Paracentral_Lobule_R", "Caudate_L", "Caudate_R", "Putamen_L", "Putamen_R", "Pallidum_L", "Pallidum_R", "Thalamus_L", "Thalamus_R", "Heschl_L", "Heschl_R", "Temporal_Sup_L", "Temporal_Sup_R", "Temporal_Pole_Sup_L", "Temporal_Pole_Sup_R", "Temporal_Mid_L", "Temporal_Mid_R", "Temporal_Pole_Mid_L", "Temporal_Pole_Mid_R", "Temporal_Inf_L", "Temporal_Inf_R", "Cerebellum_Crus1_L", "Cerebellum_Crus1_R", "Cerebellum_Crus2_L", "Cerebellum_Crus2_R", "Cerebellum_3_L", "Cerebellum_3_R", "Cerebellum_4_5_L", "Cerebellum_4_5_R", "Cerebellum_6_L", "Cerebellum_6_R", "Cerebellum_7b_L", "Cerebellum_7b_R", "Cerebellum_8_L", "Cerebellum_8_R", "Cerebellum_9_L", "Cerebellum_9_R", "Cerebellum_10_L", "Cerebellum_10_R", "Vermis_1_2", "Vermis_3", "Vermis_4_5", "Vermis_6", "Vermis_7", "Vermis_8", "Vermis_9", "Vermis_10", "Thal_AV_L", "Thal_AV_R", "Thal_LP_L", "Thal_LP_R", "Thal_VA_L", "Thal_VA_R", "Thal_VL_L", "Thal_VL_R", "Thal_VPL_L", "Thal_VPL_R", "Thal_IL_L", "Thal_IL_R", "Thal_Re_L", "Thal_Re_R", "Thal_MDm_L", "Thal_MDm_R", "Thal_MDl_L", "Thal_MDl_R", "Thal_LGN_L", "Thal_LGN_R", "Thal_MGN_L", "Thal_MGN_R", "Thal_PuI_L", "Thal_PuI_R", "Thal_PuM_L", "Thal_PuM_R", "Thal_PuA_L", "Thal_PuA_R", "Thal_PuL_L", "Thal_PuL_R", "ACC_sub_L", "ACC_sub_R", "ACC_pre_L", "ACC_pre_R", "ACC_sup_L", "ACC_sup_R", "N_Acc_L", "N_Acc_R", "VTA_L", "VTA_R", "SN_pc_L", "SN_pc_R", "SN_pr_L", "SN_pr_R", "Red_N_L", "Red_N_R", "LC_L", "LC_R", "Raphe_D", "Raphe_M")

  }




  #=============================================================================
  # Exporting results
  #=============================================================================
  path_Sub_List = list.files(path_Sub, full.names=T)

  Results = sapply(seq_along(path_Sub_List), function(i, ...){
    # i=126
    y = path_Sub_List[i]
    path_Results = list.files(y, full.names=T, pattern = "Results")
    path_ROISignals_Folder = list.files(path_Results, full.names=T, pattern="ROISignals") %>% filter_by(Pipeline)


    # path files
    path_ROI_OrderKey = list.files(path_ROISignals_Folder, pattern  ="ROI_OrderKey", full.names = T) %>% filter_by("\\.tsv$")
    path_ROI_Signals = list.files(path_ROISignals_Folder, pattern = "ROISignals_", full.names=T) %>% filter_by("\\.txt$")
    path_ROI_Correlation = list.files(path_ROISignals_Folder, pattern  ="ROICorrelation", full.names = T) %>% filter_by(include = "\\.txt$", any_include = T, exact_include = F, exclude = "Fisher")
    path_ROI_FisherZ = list.files(path_ROISignals_Folder, pattern  ="FisherZ", full.names = T) %>% filter_by("\\.txt$")


    # ROI labels
    ith_ROI_Orderkey = readr::read_tsv(path_ROI_OrderKey, show_col_types = F) %>% as_tibble %>% invisible
    if(nrow(ith_ROI_Orderkey)==0){
      stop(paste0(i, "th subject has no ROI Order key!"))
    }
    ith_ROI_Labels = ith_ROI_Orderkey$`Label in Mask` %>% unlist %>% as.numeric
    ith_Atlas_ROI_Labels = Atlas_Labels[ith_ROI_Labels]


    # read files
    ith_ROI_Signals = read.table(path_ROI_Signals)
    ith_Correlation = read.table(path_ROI_Correlation)
    ith_FisherZ = read.table(path_ROI_FisherZ)

    # renaming
    colnames(ith_ROI_Signals) = ith_Atlas_ROI_Labels
    colnames(ith_Correlation) = colnames(ith_FisherZ) = ith_Atlas_ROI_Labels
    rownames(ith_Correlation) = rownames(ith_FisherZ) = ith_Atlas_ROI_Labels



    # Filenames
    ith_RID = basename(y) %>% str_extract("RID_\\d+")
    filename_ROI_Signals = paste(ith_RID, "BOLD.Signals", "ROI", Atlas, Pipeline, "Raw.rds", sep = "___")
    filename_Correlation = paste(ith_RID, "Functional.Connectivity", "ROI", Atlas, Pipeline, "Pearson", "Raw.rds", sep = "___")
    filename_FisherZ = paste(ith_RID, "Functional.Connectivity", "ROI", Atlas, Pipeline, "Pearson", "Fisher.Z.Transformed.rds", sep = "___")




    # creating Exporting path
    path_Export_Correlation = paste0(path_Export, "/ROI___", Atlas, "___", Pipeline, "___Static___Pearson___Raw")
    dir.create(path_Export_Correlation, showWarnings = F)
    path_Export_FisherZ = paste0(path_Export, "/ROI___", Atlas, "___", Pipeline, "___Static___Pearson___FisherZ")
    dir.create(path_Export_FisherZ, showWarnings = F)


    # Exporting
    saveRDS(object = ith_Correlation, file = paste(path_Export_Correlation, filename_Correlation, sep="/"))
    cat("\n",crayon::yellow("Exporting ROI Correlation is done :"), crayon::red(ith_RID),"\n")

    saveRDS(object = ith_FisherZ, file = paste(path_Export_FisherZ, filename_FisherZ, sep="/"))
    cat("\n",crayon::yellow("Exporting ROI FisherZ Correlation is done :"), crayon::red(ith_RID),"\n")

  })
  cat("\n",crayon::blue("Extracting ROI Signals and FC is done!"),"\n")
}
