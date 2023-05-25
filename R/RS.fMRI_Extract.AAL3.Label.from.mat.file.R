# Clipboard_to_path()
#
# AAL3 = readNIfTI("E:/ADNI/ADNI_Preprocessing.Tools/DPABI_V7.0_230110/Templates/AAL3v1_1mm.nii")
#
# install.packages("R.matlab")
# # Load the library
# library(R.matlab)
#
# # Read the .mat file
#
# Data <- readMat("E:/ADNI/ADNI_Preprocessing.Tools/DPABI_V7.0_230110/Templates/AAL3v1_1mm_Labels.mat")
#
#
#
# Data = Data[[1]] %>% unlist
#
# Data = data.frame(Data[1:171], Data[172:342])
# Data = Data[-1,]
#
# names(Data) = c("Brain_Region", "ROI")
#
# write.csv(x = Data, file = "E:/ADNI/ADNI_Preprocessing.Tools/DPABI_V7.0_230110/Templates/AAL3v1_1mm_Label.csv")
