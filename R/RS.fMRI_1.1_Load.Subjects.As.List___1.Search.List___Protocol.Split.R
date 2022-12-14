RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Protocol.Split = function(data.list){

  fMRI_protocol.list = strsplit_by(x.vec=data.list[[1]]$IMAGING.PROTOCOL, split_by=";", subsplit_by="=")
  MRI_protocol.list  = strsplit_by(x.vec=data.list[[2]]$IMAGING.PROTOCOL, split_by=";", subsplit_by="=")


  binding_list = function(data.list){
    if(length(data.list)!=1){
      for(i in 1:length(data.list)){
        if(i==1){
          data.df = data.list[[i]]
        }else{
          data.df = dplyr::bind_rows(data.df, data.list[[i]])
        }
      }
    }else{
      data.df = data.list[[1]]
    }
    return(data.df)
  }

  fMRI_protocol.df =  binding_list(fMRI_protocol.list)
  MRI_protocol.df =  binding_list(MRI_protocol.list)

  names(fMRI_protocol.df) = names(fMRI_protocol.df) %>% toupper
  names(MRI_protocol.df) = names(MRI_protocol.df) %>% toupper

  data.list[[1]]$IMAGING.PROTOCOL = NULL
  data.list[[2]]$IMAGING.PROTOCOL = NULL


  fMRI_protocol_combined = cbind(data.list[[1]], fMRI_protocol.df)
  MRI_protocol_combined = cbind(data.list[[2]],  MRI_protocol.df)

  return(list(fMRI_protocol_combined, MRI_protocol_combined))
}
