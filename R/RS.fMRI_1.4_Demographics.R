RS.fMRI_1.4_Demographics = function(Merged_Diagnosis.list){
  #=============================================================================
  # Handedness
  #=============================================================================
  Handedness.list = RS.fMRI_1.4_Demographics___Handedness(Merged_Diagnosis.list)




  #=============================================================================
  # Gender
  #=============================================================================
  Gender.list = RS.fMRI_1.4_Demographics___Gender(Handedness.list)




  #=============================================================================
  # Retirement
  #=============================================================================
  Retire.list = RS.fMRI_1.4_Demographics___Retirement(Gender.list)





  #=============================================================================
  # Education
  #=============================================================================
  Education.list = RS.fMRI_1.4_Demographics___Education(Retire.list)






  #=============================================================================
  # Marital status
  #=============================================================================
  Marriage.list = RS.fMRI_1.4_Demographics___Marriage(Education.list)





  #=============================================================================
  # APOE
  #=============================================================================
  RS.fMRI_1.4_Demographics___APOE = function(Data.list, path_APOE = "C:/Users/lleii/Dropbox/Github/Rpkgs/Papers___Data/Data___ADNI___RS.fMRI___Subjects.Lists/Subjects_Lists_Downloaded/APOE4/APOERES_19Jun2023.csv"){
    APOERES = read.csv(path_APOE)


    Returned.list = lapply(seq_along(Data.list), function(i,...){
      ith_RID.df %>% View
      ith_RID.df = Data.list[[i]]
      ith_RID = ith_RID.df$RID %>% na.omit %>% as.numeic %>% unique

      # APOE
      ith_APOE = ith_RID.df$ADNIMERGE___APOE4

      # only one?
      ith_Unique_APOE = ith_APOE %>% na.omit %>% as.numeric %>% unique
      if(length(ith_Unique_APOE)==1){
        ith_RID.df$ADNIMERGE___APOE4 = ith_Unique_APOE
      # 아예 정보가 없는 경우
      }else if(length(ith_Unique_APOE) == 0){
        require(ADNIMERGE)
        if(ith_RID %in% apoe3$RID){

        }else if(ith_RID %in% apoego2$RID){

        }else if(ith_RID %in% apoeres$RID){

          sum(as.numeric(APOERES$RID) %in% apoeres$RID) == nrow(APOERES)
        }else if(ith_RID %in% as.numeric(APOERES$RID))
          APOERES$RID %>% class
        ith_RID
        tail(APOERES$RID, 30)
        data

        APOE3 = apoe3
        APOEGO2 =
        APOE_RES = apoeres$RID

        if(w)


        ith_RID.df$ADNIMERGE___APOE4 = NA






      }else{
        print(i)
        stop("there are more than one!")
      }


      return(ith_RID.df)

    })
    cat("\n",crayon::green("Checking"), crayon::red("APOE4"), crayon::green("is done!"),"\n")
    return(Returned)

  }



  #=============================================================================
  # ADAS cog
  #=============================================================================







  #=============================================================================
  # demographic variable
  #=============================================================================
  Demo.list = RS.fMRI_1.4_Demographics___Renaming.Demographics(Marriage.list)






  #=============================================================================
  # Extract Demo variables
  #=============================================================================
  Selected.list = RS.fMRI_1.4_Demographics___Selecting.Variables(Demo.list)






  #=============================================================================
  # Binding
  #=============================================================================
  Binded.list = RS.fMRI_1.4_Demographics___Combining.Data(Selected.list)



  cat("\n", crayon::green("Extracting Demographics is done!") ,"\n")
  return(Binded.list)
}




