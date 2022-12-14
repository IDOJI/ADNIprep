RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Select.One.EPB.MT1 = function(data.list){
  results.list = lapply(selected_by_what.date.list, FUN=function(x){
    # test = sapply(selected_by_what.date.list, FUN=function(x){
    #   return(nrow(x))
    # })
    # table(test)
    # x = selected_by_what.date.list[[which(test==6)[1]]]

    # EPB가 2개 이상인 경우
    # RID : 6669
    # x = selected_by_what.date.list[names(selected_by_what.date.list)=="6669"][[1]]


    ### EPB, MT1
    EPB = x[x$Series_Type=="EPB",]
    MT1 = x[x$Series_Type=="MT1",]


    ### Manufacturer
    manu_intersect = intersect(MT1$Manufacturer, EPB$Manufacturer)
    if(length(manu_intersect)>0){
      MT1 = MT1[MT1$Manufacturer %in% manu_intersect,]
      EPB = EPB[EPB$Manufacturer %in% manu_intersect,]
    }


    ### EPB의 경우===========================================================
    # text = "nrow of EPB is more than one for RID"
    ### Image ID를 제외하고 서로 같은 행을 가졌으면 한 행 제거
    EPB = rm_dup_row(EPB, except=c("ImageID", "Series_Quality", "Study_Medical_Abnormalities", "Study_Overallpass", "Medical_Exclusion"))

    # stop(paste(text, EPB$RID))
    if(nrow(EPB)>1){
      ### Eyes open이 아닌 경우로
      ind = have_this(EPB$Description, "open", as.ind = T)
      if(length(ind)>0 && nrow(EPB)!=length(ind)){
        EPB = EPB[-ind,]
      }
    }
    ### Exteded가 아닌 경우로 고르기
    if(nrow(EPB)>1){
      ind = have_this(EPB$Description, "Extended", as.ind = T)
      if(length(ind)>0 && nrow(EPB)!=length(ind)){
        EPB = EPB[-ind,]
      }
    }
    ### series quality
    if(!nrow(EPB)==1){
      EPB = filter_good(data.df = EPB, which.col.list = list("Series_Quality"), what.order.list = list(c("1", "2", "3","-1")))
    }
    ### Protocol_Comments
    if(!nrow(EPB)==1){
      ind = which(EPB$Protocol_Comments %in% "NA")
      if(length(ind)>0){
        EPB = EPB[ind,]
      }
    }
    ### Series_Comments
    if(!nrow(EPB)==1){
      ind = which(EPB$Series_Comments %in% "NA")
      if(length(ind)>0){
        EPB = EPB[ind,]
      }
    }

    ### others
    # if(nrow(EPB)>1){
    #   stop("The nrow of EPB is more than one. Consider adding conditions.")
    #   # 고려할 변수 : "Study_Medical_Abnormalities", "Study_Overallpass", "Medical_Exclusion"
    # }

    ### MT1의 경우===========================================================
    ### Image ID를 제외하고 서로 같은 행을 가졌으면 한 행 제거
    MT1 = rm_dup_row(MT1, except=c("ImageID", "Series_Quality", "Study_Medical_Abnormalities", "Study_Overallpass", "Medical_Exclusion"))

    ### good을 포함하는 MPRAGE만 선택
    if(!nrow(MT1)==1){
      good_MPRAGE = c("SENSE","SENSE2","GRAPPA","Accelerated")
      ind = have_this(x.vec = MT1$Description, this = good_MPRAGE, any=T, as.ind = T)
      if(length(ind)>0){
        MT1 = MT1[ind,]
      }
    }

    ### 그래도 1개보다 많은 경우
    ### series_quality 기준으로 선택
    if(!nrow(MT1)==1){
      MT1 = filter_good(data.df = MT1, which.col.list = list("Series_Quality"), what.order.list = list(c("1", "2", "3","-1")))
    }

    ### 그래도 1개보다 많은 경우
    ### _ND를 제외 : distortion correction이 되지 않은 경우임
    if(!nrow(MT1)==1){
      ind = have_this(MT1$Description, "_ND", as.ind=T)
      if(length(ind)>0 && nrow(MT1)!=length(ind)){
        MT1 = MT1[-have_this(MT1$Description, "_ND", as.ind=T),]
      }
    }
    ### Series_Comments
    if(!nrow(MT1)==1){
      ind = which(MT1$Series_Comments %in% "NA")
      if(length(ind)>0){
        MT1 = MT1[ind,]
      }
    }

    ### others
    # if(nrow(MT1)>1){
    #   stop("The nrow of EPB is more than one. Consider adding conditions.")
    #   # 고려할 변수 : "Study_Medical_Abnormalities", "Study_Overallpass", "Medical_Exclusion"
    # }

    text1 = "RID"
    text2 = crayon::magenta(EPB$RID)
    text3 = "is done!"
    cat("\n", text1, text2, text3, "\n")
    if(nrow(EPB)==1 && nrow(MT1)==1){
      return(rbind(EPB, MT1))
    }else{
      return(NULL)
    }
  })

  which_null = sapply(results.list, FUN=function(x){
    return(is.null(x))
  })
  if(sum(which_null)>0){
    which_null = c(T,T, rep(F, length(results.list)-2))
    selected = results.list[which_null]
    selected_RID = sapply(selected, FUN=function(x){
      # x = selected[[1]]
      RID = x$RID %>% unique
      return(RID)
    })
    names(selected_RID) = NULL


    text = c("There is EPB or MT1 with more than one rows.")
    cat("\n", crayon::red(text), "\n")
    text = "Check these RID."
    cat("\n", crayon::red(text), "\n")
    cat("\n", crayon::blue(RID), "\n")

    results_2.list = list(results.list, selected)
    return(results_2.list)
  }else{
    cat("\n", crayon::blue("There were no EPB/MT1 with more than one rows!"), "\n")
    cat("\n", crayon::blue("Just one list is returned."), "\n")
    return(results.list)
  }
}
