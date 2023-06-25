RS.fMRI_1.2_Merging.Lists___Selecting.By.What.Date = function(data.list,...){
  ### Extracting RID
  RID = sapply(data.list, FUN=function(y,...){
    return(names(y))
  })



  ### selecting by what.date & combining by RID
  selected_by_what.date.list = lapply(data.list, FUN=function(x,...){
    # x = data.list[[1]]

    cat("\n",crayon::blue(names(x)) ,"is done ", paste("(",100*which(RID==names(x))/length(RID), "%)"),"\n")


    if(length(x) >= what.date){
      ### select each df
      if(length(x[[what.date]][[1]])==2){
        search         =   x[[what.date]][[1]]$SEARCH
        QC             =   x[[what.date]][[1]]$QC

        NFQ_names       =   c("PHASE", "RID", "SCANDATE", "SERIESDATE","VISCODE","VISCODE2","SERIESTIME", "MANUFACTURER", "MANUFACTURERSMODELNAME", "REPETITIONTIME","SOFTWAREVERSIONS","NFQ","OVERALLQC", "SLICE.TIMING_RAW","SLICE.TIMING_MIN", "SLICE.TIMING_ORDER")
        NFQ             =   matrix(NA, nrow=1, ncol=length(NFQ_names)) %>% as.data.frame
        names(NFQ)      =   NFQ_names
        NFQ$SERIESDATE  =   QC$SERIES_DATE %>% unique
        NFQ$RID         =   QC$RID %>% unique
      }else if(x[[what.date]][[1]] %>% length == 3){
        search         =   x[[what.date]][[1]]$SEARCH
        QC             =   x[[what.date]][[1]]$QC
        NFQ            =   x[[what.date]][[1]]$NFQ
      }

      ### Select EPB & MT1
      QC_EPB = QC %>% dplyr::filter(SERIES_TYPE=="EPB")
      QC_MT1 = QC %>% dplyr::filter(SERIES_TYPE=="MT1")
      search_EPB = search %>% dplyr::filter(IMAGE_ID==QC_EPB$IMAGE_ID)
      search_MT1 = search %>% dplyr::filter(IMAGE_ID==QC_MT1$IMAGE_ID)

      ### Merging
      NFQ = NFQ %>% rename(RID_NFQ=RID)
      EPB = dplyr::full_join(search_EPB, QC_EPB, by="IMAGE_ID", suffix=c("Search", "QC"))
      MT1 = dplyr::full_join(search_MT1, QC_MT1, by="IMAGE_ID", suffix=c("Search", "QC"))
      combined = rbind(EPB, MT1)
      return(list(combined, NFQ))
    }
  })


  ### find not df
  each_class = sapply(selected_by_what.date.list, FUN=function(y){
    is.data.frame(y[[1]])
  })

  if(sum(each_class)==length(selected_by_what.date.list)){
    EPB_MT1.list = lapply(selected_by_what.date.list, FUN=function(z){
      return(z[[1]])
    })
    NFQ.list = lapply(selected_by_what.date.list, FUN=function(z){
      return(z[[2]])
    })


    IMAGE.df = do.call(rbind, EPB_MT1.list)
    NFQ.df = do.call(rbind, NFQ.list)
  }
  return(list(IMAGE.df, NFQ.df))
}
