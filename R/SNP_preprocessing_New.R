SNP_preprocessing_New = function(PLINK_path = "C:/Users/lleii/Dropbox/Github/Rpkgs/ADNIprep/Preprocessing Tools/SNP/PLINK_1.9/plink",
                                 SubjectID_To_Include = NULL,
                                 # SubjectID_To_Include = "137_S_4303",
                                 which_ID_column = 2,
                                 SNP_files_path = "C:/Users/lleii/Dropbox/패밀리룸/Data/ADNI_SNP/ADNI2GO/ADNI_GO_2_OmniExpress",
                                 bed_file_name = "ADNI_GO_2_Forward_Bin",
                                 mind = 0.1,
                                 hwe_p.val = 1e-6# hwe_pvalue < 0.000001
){
  #===============================================================================
  # 0) files path
  #===============================================================================
  bed_file_path = file.path(SNP_files_path, paste0(bed_file_name))
  ped_file_path = file.path(SNP_files_path, paste0(bed_file_name))





  #===============================================================================
  # 1) Converting bed to ped
  #===============================================================================
  cmd = paste(paste0('"', PLINK_path, '"'), "--bfile", paste0('"', bed_file_path, '"'), "--recode --out", paste0('"', ped_file_path, '"'), sep=" ")
  system(cmd)
  # error detection
  log_data = readLines(paste0(ped_file_path, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, ".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 01"), crayon::red("Converting into ped"), crayon::blue("is done! : "), crayon::yellow(paste0()), "\n")





  #===============================================================================
  # 2) Excluding subjects
  #===============================================================================
  # Loading ped file
  New_Suffix = "___Filtered"
  ped_filtered = ped = data.table::fread(paste0(ped_file_path, ".ped"))
  if(!is.null(SubjectID_To_Include)){
    ped_filtered = ped[ped[,2] %>% unlist %in% SubjectID_To_Include, ]
  }
  # Exporting filtered ped
  write.table(x = ped_filtered, file = paste0(ped_file_path, New_Suffix, ".ped"), row.names = FALSE, col.names = FALSE, quote = FALSE, sep = " ")
  # copy a MAP file in the same name with the filtered.ped
  file.copy(paste0(ped_file_path, ".map"), paste0(ped_file_path, New_Suffix, ".map"))
  cat("\n", crayon::bgMagenta("Step 02"), crayon::red("Excluding subjects"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")







  #=============================================================================
  # 3) 기록된 성별과 유전자 성별이 다른 경우 찾기
  #=============================================================================
  # a funny step
  # check if there is any subject with discrepency
  # between the gender they reported
  # and gender inferred by sex chromosome information
  Former_Suffix = New_Suffix
  New_Suffix = "___Sex"
  All_Suffix = paste0(Former_Suffix, New_Suffix)
  cmd = paste(paste0('"', PLINK_path, '"'), "--file",  paste0('"', ped_file_path, Former_Suffix, '"'),  "--check-sex", "--out",   paste0('"', ped_file_path, All_Suffix, '"'), sep=" ")
  system(cmd)
  # Check the results
  sexcheck_data = read.table(paste0(ped_file_path, All_Suffix, ".sexcheck"), header = TRUE, stringsAsFactors = FALSE)
  problems_detected = any(sexcheck_data$STATUS != "OK")
  # No problem = Copy ped file & Change its name
  if(!problems_detected){
    New_ped_file_path = paste0(ped_file_path, All_Suffix)
    # Copy the PED file
    file.copy(paste0(ped_file_path, Former_Suffix, ".ped"), paste0(New_ped_file_path, ".ped")) %>% invisible
    # Copy the corresponding MAP file
    file.copy(paste0(ped_file_path, Former_Suffix, ".map"), paste0(New_ped_file_path, ".map")) %>% invisible
  }else{
    stop(paste("Problems detected in the sex check. Please review the file. : ", crayon::bgYellow(paste0(bed_file_name, All_Suffix, ".sexcheck"))))
  }
  cat("\n", crayon::bgMagenta("Step 03"),crayon::red("Checking Sex discrepancy"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")







  #=============================================================================
  # 4) Removing low-genotyped individuals
  #=============================================================================
  # remove individuals low genotyped,
  # remove subject with missing proportion of genotype > 0.1
  Former_Suffix = All_Suffix
  New_Suffix = "___Rm.Low.Gene"
  All_Suffix = paste0(Former_Suffix, New_Suffix)
  cmd = paste(paste0('"', PLINK_path, '"'), "--file", paste0('"', ped_file_path, Former_Suffix, '"'), "--mind 0.1 --recode --out", paste0('"', ped_file_path, All_Suffix, '"'), sep=" ")
  system(cmd)
  # error detection
  log_data = readLines(paste0(ped_file_path, All_Suffix, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, All_Suffix, ".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 04"), crayon::red("Removing low phenotype individuals"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")





  #=============================================================================
  # 5) Filter SNPs based on minor allele frequency (MAF) and genotyping rate
  #=============================================================================
  # remove snps with missing
  # remove
  # (1) missing proportion 0.05
  # (2) maf < 0.05
  Former_Suffix = All_Suffix
  New_Suffix = "___MAF"
  All_Suffix = paste0(Former_Suffix, New_Suffix)
  cmd = paste(paste0('"', PLINK_path, '"'), "--file", paste0('"', ped_file_path, Former_Suffix, '"'), "--geno 0.05 --maf 0.05 ", "--recode --out", paste0('"', ped_file_path, All_Suffix, '"'), sep=" ")
  system(cmd)
  # Error detection
  log_data = readLines(paste0(ped_file_path, All_Suffix, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, All_Suffix, ".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 05"), crayon::red("Filtering SNPs by MAF"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")






  #=============================================================================
  # 6) Filter individuals based on missingness rate
  #=============================================================================
  Former_Suffix = All_Suffix
  New_Suffix = "___Missing.Rate"
  All_Suffix = paste0(Former_Suffix, New_Suffix)
  cmd = paste(paste0('"', PLINK_path, '"'), "--file", paste0('"', ped_file_path, Former_Suffix, '"'), "--mind",  mind, "--recode --out", paste0('"', ped_file_path, All_Suffix, '"'), sep=" ")
  system(cmd)
  # Error detection
  log_data = readLines(paste0(ped_file_path, All_Suffix, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, All_Suffix, ".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 06"), crayon::red("Filtering by missingness rate"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")






  #=============================================================================
  # 7) Filter SNPs based on Hardy-Weinberg equilibrium (HWE)
  #=============================================================================
  Former_Suffix = All_Suffix
  New_Suffix = "___HWE"
  All_Suffix = paste0(Former_Suffix, New_Suffix)
  cmd = paste(paste0('"', PLINK_path, '"'), "--file", paste0('"', ped_file_path, Former_Suffix, '"'), "--hwe",  hwe_p.val, "--recode --out", paste0('"', ped_file_path, All_Suffix, '"'), sep=" ")
  system(cmd)
  # Error detection
  log_data = readLines(paste0(ped_file_path, All_Suffix, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, All_Suffix, ".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 07"), crayon::red("Filtering by HWE"), crayon::blue("is done! : "), crayon::yellow(paste0(New_Suffix)), "\n")





  #=============================================================================
  # Exporting as raw
  #=============================================================================
  Former_Suffix = All_Suffix
  New_Suffix = "___Final"
  cmd = paste(paste0('"', PLINK_path, '"'), "--file", paste0('"', ped_file_path, Former_Suffix, '"'), "--hwe",  hwe_p.val, "--recodeA --out", paste0('"', ped_file_path, New_Suffix, '"'), sep=" ")
  system(cmd)
  system(paste0(plink_path, " --bfile input_data_preprocessed --recodeA --out input_data_preprocessed_raw"))
  # error detection
  log_data = readLines(paste0(ped_file_path, New_Suffix, ".log"))
  errors_detected = any(grepl("ERROR", log_data, ignore.case = TRUE)) %>% suppressWarnings()
  if(errors_detected){
    stop(paste("Errors detected in the log file. Please review the log file : ", crayon::bgYellow(paste0(bed_file_name, New_Suffix,".log"))))
  }
  cat("\n", crayon::bgMagenta("Step 08"), crayon::red("Converting into raw file"), crayon::blue("is done! : "), crayon::yellow(paste0()), "\n")


}
