RS.fMRI_1.1_Load.Subjects.As.List___3.NFQ.List___Slice.Timing = function(NFQ.df){

    slice.timing.raw = NFQ.df$SLICETIMING
    NFQ.df$SLICETIMING = NULL



    slice.timing.list = lapply(slice.timing.raw, function(x){
    x_split = strsplit(x, "_") %>% unlist %>% as.numeric
    x_min = min(x_split)

    y_min = x_split - x_min
    y_order = order(y_min) # 오름차순으로 나열할 때의 해당 차례의 위치

    y_split_tab = paste(x_split, collapse="    ") # 4space = 1tab
    y_min_tab = paste(y_min, collapse="    ")
    y_order_tab = paste(y_order, collapse="    ")

    y.df = data.frame(SLICE.TIMING_RAW = y_split_tab,
                      SLICE.TIMING_MIN = y_min_tab,
                      SLICE.TIMING_ORDER = y_order_tab)
    names(y.df) = names(y.df) %>% toupper
    return(y.df)
    }
  )


  slice.timing.df = do.call(rbind, slice.timing.list)
  NFQ.df = cbind(NFQ.df, slice.timing.df) %>% dplyr::as_tibble()

  text = "1.1.3 : Extracting Slicetiming is done."
  cat("\n", crayon::green(text), "\n")
  return(NFQ.df)
}




