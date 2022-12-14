RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___ImageID = function(Search.df){

  ImageID = Search.df$IMAGE.ID
  which_NA = ImageID %>% is.na %>% which
  if(length(which_NA)>0){
    ImageID = ImageID[-which_NA]
    Search.df = Search.df[-which_NA,]
  }

  ImageID.list = lapply(ImageID, FUN=function(x){
    # x = ImageID[1]
    if((grep("I", x) %>% sum) == 0){
      x = paste0("I", x)
    }
    return(x)
  })
  Search.df[,"IMAGE.ID"] = unlist(ImageID.list)
  Search.df = Search.df %>% dplyr::relocate(IMAGE.ID)
  Search.df = Search.df %>% rename("IMAGE_ID":="IMAGE.ID")
  return(Search.df)
}
