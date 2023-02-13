RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders___Transform.Numbers.2.Sub = function(numbers){
  if(is.numeric(numbers)){
    fitted_numbers = fit_length(numbers, 3) %>% as.character
    fitted_sub = sapply(fitted_numbers, FUN=function(ith_fitted){
      paste0("Sub_", ith_fitted)
    })
    return(fitted_sub)
  }else{
    if(grep("Sub", x = numbers) %>% length > 0){
      return(numbers)
    }else{
      fitted_numbers = fit_length(numbers %>% as.numeric, 3) %>% as.character
      fitted_sub = sapply(fitted_numbers, FUN=function(ith_fitted){
        paste0("Sub_", ith_fitted)
      })
      return(fitted_sub)
    }
  }
}
