RS.fMRI_1.1_Load.Subjects.As.List___Search.List___ImageID = function(data.list){
  # data.list = Search_3.list
  data_New.list = lapply(data.list, function(data.df){
    Image.ID = data.df$IMAGE.ID

    have.ID = grep("I", Image.ID, ignore.case = F) %>% length > 0
    if(!have.ID){
      data.df$IMAGE.ID = paste0("I", Image.ID)
    }

    data.df = data.df %>% rename(IMAGE_ID = IMAGE.ID) %>% relocate(starts_with("IMAGE_"))

    return(data.df)
  })
  return(data_New.list)
}
