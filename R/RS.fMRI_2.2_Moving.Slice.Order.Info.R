RS.fMRI_2.2_Moving.Slice.Order.Info = function(path_Subjects, path_Subjects_RS.fMRI, All.Subjects){
  folders_path = list.files(path_Subjects, full.names = T, all.files = F)
  folders_name = list.files(path_Subjects, full.names = F, all.files = F)

  if(All.Subjects){
    selected_folders  = folders_path[grep("0.All", folders_path)]
    selected_names    = folders_name[grep("0.All", folders_name)]
  }else{
    which_Manu        = c(grep("_MB", folders_path), grep("_SB", folders_path)) %>% sort
    selected_folders  = folders_path[which_Manu]
    selected_names    = folders_name[which_Manu]
  }


  ### copying files
  for(i in 1:length(selected_names)){
    dir.create(paste0(path_Subjects_RS.fMRI, selected_names[i]), showWarnings = F)

    ith_path_from  = paste0(path_Subjects,         selected_names[i]) %>% path_tail_slash()
    ith_path_to    = paste0(path_Subjects_RS.fMRI, selected_names[i]) %>% path_tail_slash()

    ith_files             =  list.files(ith_path_from, full.names = F)
    ith_slice.order.info  =  ith_files[grep("SliceOrderInfo", ith_files, ignore.case = F)]


    ### copying slice order info
    if(length(ith_slice.order.info)>0){
      file.copy(from      =   paste0(ith_path_from, ith_slice.order.info),
                to        =   ith_path_to,
                overwrite = T)

      file.rename(from = paste0(ith_path_to, ith_slice.order.info),
                  to   = paste0(ith_path_to, "SliceOrderInfo.tsv"))
    }
  }
}
