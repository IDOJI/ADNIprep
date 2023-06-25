#=============================================================================
# 2. Remove RID only having Screening 어차피 sereies selected 통과이므로 사용함
#=============================================================================
RS.fMRI_1.2_Merging.Search.with.QC___Remove.Screening = function(data.list, ...){


  each_length = sapply(selected.list, FUN=function(x){
    # x = selected.list[[1]]
    length(x) %>% return
  })

  which_only_have_one =




    ### Remove only having Screening
    lapply(each_length, FUN=function(x){


      # x = selected.list[[100]]
      x = x[[1]]
      if(length(x)==1){
        SEARCH = x[[1]]$SEARCH
        QC = x[[1]]$QC

        visit = SEARCH$VISIT %>% unique

      }

    })


}
