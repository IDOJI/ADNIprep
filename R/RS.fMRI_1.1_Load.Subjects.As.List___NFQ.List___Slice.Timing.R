RS.fMRI_1.1_Load.Subjects.As.List___NFQ.List___Slice.Timing = function(NFQ.df){
  # NFQ.df = NFQ_3.df
  #=============================================================================
  # Extracting Raw Slice timing info
  #=============================================================================
  Slice.Timing.Raw = NFQ.df$SLICETIMING
  NFQ.df$SLICETIMING = NULL


  #=============================================================================
  # Splitting Slice Timing Raw
  #=============================================================================
  Splitted_Slice.Timing.Raw = lapply(Slice.Timing.Raw, FUN=function(x){
    strsplit(x, "_")[[1]] %>% as.numeric
  })



  #=============================================================================
  # Subtracting min timing
  #=============================================================================
  Subtract.Min_Slice.Timing.Raw = sapply(Splitted_Slice.Timing.Raw, FUN=function(y){
    # y = Splitted_Slice.Timing.Raw[[1]]
    paste(y - min(y), collapse = "    ")  # 4space = 1tab
  })



  #=============================================================================
  # Extracting Slice Order of Slice Timing
  #=============================================================================
  Extract.Slice.Order_Slice.Timing.Raw = sapply(Subtract.Min_Slice.Timing.Raw, FUN=function(z){
    # z = Subtract.Min_Slice.Timing.Raw[1]
    z = strsplit(z, "    ")[[1]] %>% as.numeric %>% order
    paste(z, collapse = "    ") %>% return
  })




  #=============================================================================
  # Extracting Slice Order Type
  #=============================================================================
  Manufacturer = NFQ.df$MANUFACTURER
  Slice.Order.Type = sapply(Manufacturer, FUN=function(x){
    if(grep("Philips", x, ignore.case = T) %>% length > 0 ){
      return("IA")
    }else{
      "No Need"
    }
  })




  #=============================================================================
  # Combining
  #=============================================================================
  NFQ.df$Slice.Timing = Subtract.Min_Slice.Timing.Raw
  NFQ.df$Slice.Order = Extract.Slice.Order_Slice.Timing.Raw
  NFQ.df$Slice.Order.Type = Slice.Order.Type



  text = "1.1.3 : Extracting Slicetiming is done."
  cat("\n", crayon::green(text), "\n")
  return(NFQ.df)
}




