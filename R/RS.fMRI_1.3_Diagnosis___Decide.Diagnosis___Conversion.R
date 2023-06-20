RS.fMRI_1.3_Diagnosis___Decide.Diagnosis___Conversion = function(Data.list){
  # Data.list = Merged_Data.list

  Returned.list = lapply(seq_along(Data.list), function(i){
    ith_RID.df = Data.list[[i]]
    ith_RID.df = cbind(DIAGNOSIS_NEW = ith_RID.df$DIAGNOSIS, ith_RID.df)


    cat("\n", crayon::yellow(i),"\n")

    ith_DXMCI = ith_RID.df$DXSUM___DXMCI
    ith_DXNORM = ith_RID.df$DXSUM___DXNORM
    ith_DXAD = ith_RID.df$DXSUM___DXAD

    ith_Diagnosis = ith_RID.df$DIAGNOSIS_NEW


    #===========================================================================
    # Decision
    #===========================================================================
    for(k in seq_along(ith_DXMCI)){
      cat("\n", crayon::red(k),"\n")
      kth_dx = ith_Diagnosis[k]

      kth_MCI = ith_DXMCI[k] %>% as.numeric
      kth_NORM = ith_DXNORM[k] %>% as.numeric
      kth_AD = ith_DXAD[k] %>% as.numeric


      # MCI
      if(!is.na(kth_MCI)){
        if(kth_MCI==1){
          if(is.na(kth_dx) || kth_dx %in% c("SMC", "CN", "MCI")){
            ith_Diagnosis[k] = "MCI"
          }
        }
      }

      # NORM
      if(!is.na(kth_NORM)){
        if(kth_NORM==1){
          if(is.na(kth_dx) || kth_dx %in% c("SMC", "CN")){
            ith_Diagnosis[k] = "CN"
          }
        }
      }


      # AD
      if(!is.na(kth_AD)){
        if(kth_AD==1){
          if(is.na(kth_dx) || kth_dx  %in% c("Dementia", "AD")){
            ith_Diagnosis[k] = "AD"
          }
        }
      }
    }
    ith_RID.df$DIAGNOSIS_NEW = ith_Diagnosis

    return(ith_RID.df)
  })



#



  #=============================================================================
  Returned_2.list = lapply(seq_along(Returned.list), function(i,...){
    print(i)
    # i=112
    ith_RID.df = Returned.list[[i]]
    ith_VISCODE2 = ith_RID.df$VISCODE2

    ith_DX.bl = ith_RID.df$ADNIMERGE___DX.bl %>% na.omit() %>% unique()
    ith_DXCHANGE = ith_RID.df$DXSUM___DXCHANGE
    ith_Comments = ith_RID.df$BLCHANGE___BCSUMM
    ith_DIAGNOSIS_NEW = ith_RID.df$DIAGNOSIS_NEW

    #===========================================================================
    # DX Change
    #===========================================================================
    for(k in seq_along(ith_DXCHANGE)[-1]){


      cat("\n", crayon::bgMagenta(k) ,"\n")

      kth_DX = ith_DXCHANGE[k]

      if(is.na(kth_DX)){

        if(is.na(ith_DIAGNOSIS_NEW[k])){
          ith_DIAGNOSIS_NEW[k] = ith_DIAGNOSIS_NEW[k-1]
        }

      }else{

        #=====================
        # 1=Stable: NL to NL
        #=====================
        if(kth_DX==1){
          ith_DIAGNOSIS_NEW[k] = "CN"

          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "CN"
          }


        #=======================
        # 2=Stable: MCI to MCI;
        #=======================
        }else if(kth_DX==2){
          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }

          if(!is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "MCI"
          }


        #=================================
        # 3=Stable: Dementia to Dementia;
        #=================================
        }else if(kth_DX==3){
          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "Dementia"
          }

          if(ith_DIAGNOSIS_NEW[k-1]=="AD"){
            ith_DIAGNOSIS_NEW[k] = "AD"
          }else{
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }




        #=================================
        # 4=Conversion: NL to MCI;
        #=================================
        }else if(kth_DX==4){
          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "CN"
          }

          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }

          if(!ith_DIAGNOSIS_NEW[k] %in% c("EMCI", "LMCI", "MCI")){
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }


        #=================================
        # 5=Conversion: MCI to Dementia;
        #=================================
        }else if(kth_DX==5){
          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "MCI"
          }


          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }else{
            if(! ith_DIAGNOSIS_NEW[k] %in% c("AD", "Dementia")){
              ith_DIAGNOSIS_NEW[k] = "Dementia"
            }
          }



        #=================================
        # 6=Conversion: NL to Dementia;
        #=================================
        }else if(kth_DX==6){
          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "CN"
          }else{
            stop("Different!")
          }


          if(! ith_DIAGNOSIS_NEW[k] %in% c("AD", "Dementia")){
            ith_DIAGNOSIS_NEW[k] = "Dementia"
          }


        #=================================
        # 7=Reversion: MCI to NL;
        #=================================
        }else if(kth_DX==7){
          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "CN"
          }
          if(ith_DIAGNOSIS_NEW[k]!="CN"){
            stop("No CN!")
          }

          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "MCI"
          }



        #=================================
        # 8=Reversion: Dementia to MCI;
        #=================================
        }else if(kth_DX==8){
          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "MCI"
          }

          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "Dementia"
          }

        #=================================
        # 9=Reversion: Dementia to NL
        #=================================
        }else if(kth_DX==9){
          if(ith_DIAGNOSIS_NEW[k]=="SMC"){
            stop("SMC!")
          }

          if(is.na(ith_DIAGNOSIS_NEW[k])){
            ith_DIAGNOSIS_NEW[k] = "CN"
          }

          if(is.na(ith_DIAGNOSIS_NEW[k-1])){
            ith_DIAGNOSIS_NEW[k-1] = "Dementia"
          }
        }
      }
    }# for

    ith_RID.df$DIAGNOSIS_NEW = ith_DIAGNOSIS_NEW
    return(ith_RID.df)
  })

  return(Returned.list)
}
