RS.fMRI_1.2_Merging.Search.with.QC___Selecting.Good = function(not_unique_imageID.list){

  results.list = lapply(not_unique_imageID.list, FUN=function(x){
    # k = 5
    # x = not_unique_imageID.list[[k]]

    ith_search = x$Search
    ith_QC = x$QC

    # remove duplicate rows
    if(nrow(ith_search)>1){
      ith_search = rm_dup_row(ith_search)
      if(nrow(ith_search)>1){
        ith_imageID = ith_search$Image_ID
        text = paste("Check the imageID", ith_imageID,"in 'Search' data has more than one rows!!")
        stop(text)
      }
    }


    if(nrow(ith_QC)>1){
      ith_QC = rm_dup_row(ith_QC)
    }

    # 중복이 없는 경우 QC를 기준으로 다시 선택
    if(nrow(ith_QC)>1){
      ### select a good data : image ID가 동일하므로 QC 내용을 기준으로 선택
      ## create a columns list
      col.list = list()
      col.list[[1]] = c("study", "abnormal", "medical")
      col.list[[2]] = c("study", "rescan")
      col.list[[3]] = c("series", "quality")
      col.list[[4]] = c("Study", "Overall")
      # col.list = c("Series", "description")

      ## criteria order list
      order.list = list()
      order.list[[1]] = c("0", "NA") # (0) Not present, (1) Present, (-1) Not evaluated (1��??)
      order.list[[2]] = c("FALSE", "NA") #
      order.list[[3]] = c("1", "2", "3","-1") # 1(Excellent) > 2(Good) > 3(Fair) > -1(Not Evaluated) /// > 4(unusable) ????
      order.list[[4]] = c("1", "-1") # 0(FAIL) < -1 < 1  (0��??)
      # order.list_MT1[[5]] = c("RAGE", "SPGR") # RAGE > SPGR


      ith_QC_good = filter_good(ith_QC, which.col.list = col.list, what.order.list = order.list)
      if(nrow(ith_QC_good)>1){
        stop("There are more than one good data. Check 'filter_good' function!")
      }

      ith_merged = merge_by_ID(ith_search, ith_QC_good, by = "ImageID", name.x="_Search", name.y="_QC")
    }else{
      ith_merged = merge_by_ID(ith_search, ith_QC, by = "ImageID", name.x="_Search", name.y="_QC")
    }
    return(ith_merged)
  })# lapply

  return(results.list)
}
