RS.fMRI_1_Data.Selection___Loading.Lists___Search___ImageID = function(data.df){
  # data.list = Search_3.list
  Image.ID = data.df$IMAGE.ID

  have.ID = grep("I", Image.ID, ignore.case = F) %>% length > 0
  if(!have.ID){
    data.df$IMAGE.ID = paste0("I", Image.ID)
  }

  data.df = data.df %>% rename(IMAGE_ID = IMAGE.ID) %>% relocate(starts_with("IMAGE_"))

  return(data.df)
}
