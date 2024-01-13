Abbreviation = c("ACC_sub_L", "the Left Subgenual Anterior Cingulate Cortex",
                 "ACC_sub_R", "the Right Subgenual Anterior Cingulate Cortex",
                 #
                 "Caudate_L", "the Left Caudate Nucleus",
                 "Caudate_R", "the Right Caudate Nucleus",
                 #
                 "Cingulate_Mid_L", "the Left Middle cingulate & Paracingulate Gyri",
                 "Cingulate_Mid_R", "the Right Middle cingulate & Paracingulate Gyri",
                 #
                 "Cingulate_Post_L", "the Left Posterior Cingulate Gyrus",
                 "Cingulate_Post_R", "the Right Posterior Cingulate Gyrus",
                 #
                 "Frontal_Inf_Tri_L", "the Left Inferior Frontal Gyrus (Triangular Part)",
                 "Frontal_Inf_Tri_R", "the Right Inferior Frontal Gyrus (Triangular Part)",
                 #
                 "OFCmed_R", "the Right Medial Orbital Gyrus",
                 "OFCmed_L", "the Left Medial Orbital Gyrus",
                 #
                 "OFClat_R", "the Right Lateral Orbital Gyrus",
                 "OFClat_L", "the Left Lateral Orbital Gyrus",
                 #
                 "Parietal_Inf_R", "the Right Inferior Parietal Gyrus, Excluding Supramarginal and Angular Gyri",
                 "Parietal_Inf_L", "the Left Inferior Parietal Gyrus, Excluding Supramarginal and Angular Gyri",
                 #
                 "Supp_Motor_Area_L", "the Left Supplementary Motor Area",
                 "Supp_Motor_Area_R", "the Right Supplementary Motor Area",
                 #
                 "Temporal_Mid_L", "the Left Middle Temporal Gyrus",
                 "Temporal_Mid_R", "the Right Middle Temporal Gyrus",
                 # Table1 : The parcellation of the thalamic nuclei
                 "Thal_IL_L", "the Left Intralaminar",
                 "Thal_IL_R", "the Right Intralaminar")


# Create a dataframe with two columns
AAL3 = data.frame(Abbreviation = Abbreviation[seq(1, length(Abbreviation), by = 2)],
                  Description = Abbreviation[seq(2, length(Abbreviation), by = 2)])


# Export
saveRDS(AAL3, "/Users/Ido/Library/CloudStorage/Dropbox/Github/Rpkgs/ADNIprep/Preprocessing Tools/RS-fMRI/AAL3/AAL3 atlas.rds")

















