# Diagnosis at the screen visit (VISCODE2=‘sc’)
# · When randomization is assigned
# · Determines visitation schedule, which is diagnosis specific
# · Available in the arm table (ARM.csv)
# ∗ Diagnosis at baseline visit (VISCODE2=‘bl’)
# · Based on additional information acquired at the baseline visit to obtain diagnosis
# · Diagnosis recommended by the Clinical Core for use as initial diagnosis
# · Available in the diagnosis summary table (DXSUM PDXCONV ADNIALL.csv)

# · Note that in ADNIGO/2, if you want to identify SMC and EMCI, you need to use the information in
# the arm table and verify that the diagnosis was stable at VISCODE2=‘bl’ in the diagnostic summary
# table (SMC and EMCI are not diagnostic categories used after the screen visit).


# – Current diagnosis variable names change by the phase in the diagnosis summary table.
# ∗ ADNI1: DXCURREN 1=NL; 2=MCI; 3=AD
# ∗ ADNIGO/2: DXCHANGE 1=Stable: NL to NL; 2=Stable: MCI to MCI; 3=Stable: Dementia to Dementia; 4=Conversion: NL to MCI; 5=Conversion: MCI to Dementia; 6=Conversion: NL to Dementia;
# 7=Reversion: MCI to NL; 8=Reversion: Dementia to MCI; 9=Reversion: Dementia to NL
# ∗ ADNI3: DIAGNOSIS 1=CN; 2=MCI; 3=Dementi




# • About EXAMDATE in Clinical data files
# – Clinical data acquired in ADNIGO/2 do not include ‘EXAMDATE’ (the date of the exam), although this
# information was included for ADNI1 visits.
# – The variable ’USERDATE’ is the data entry (or modification) date, and may be very different from EXAMDATE.
# – Use the variable ‘EXAMDATE’ in the registry table (REGISTRY.csv) as the date of exam for all clinical
# data (merge by RID and VISCODE or VISCODE2)
Clipboard_to_path()
registry.df = read.csv("C:/Users/lleii/Dropbox/Github/Rpkgs/Papers___Data/Data___ADNI___RS.fMRI___Subjects.Lists/Subjects_Lists_Downloaded/REGISTRY_23Jun2023.csv")

registry.df %>% filter(RID==5277)


RS.fMRI_1.3_Diagnosis = function(Merged_Lists.df,
                                 path_Subjects_BLCHANGE,
                                 path_Subjects_DX_Summary){
  #===============================================================================
  # Combining Data
  #===============================================================================
  Combined.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames(Merged_Lists.df, path_Subjects_BLCHANGE, path_Subjects_DX_Summary)



  #===============================================================================
  # Decide Diagnosis
  #===============================================================================
  Diagnosis.list = RS.fMRI_1.3_Diagnosis___Decide.Diagnosis(Combined.list)




  #===============================================================================
  # Calculating times till AD
  #===============================================================================
  Time_To_First_AD.list = RS.fMRI_1.3_Diagnosis___Time.To.First.AD(Diagnosis.list)





  cat("\n", crayon::bgMagenta("STEP 1.3"), crayon::green("Deciding Diagnosis is done!") ,"\n")
  return(Time_To_First_AD.list)
}









































