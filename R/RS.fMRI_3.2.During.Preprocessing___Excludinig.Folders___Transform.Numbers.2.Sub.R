RS.fMRI_3.2.During.Preprocessing___Excludinig.Folders___Transform.Numbers.2.Sub = function(numbers){
  fitted_numbers = fit_length(numbers, 3) %>% as.character
  fitted_sub = sapply(fitted_numbers, FUN=function(ith_fitted){
    paste0("Sub_", ith_fitted)
  })
  return(fitted_sub)
}
