RS.fMRI_3.1.Before.Preprocessing___Generate.SliceOrderInfo.tsv = function(manu_path, all.subjects.list_path){
  ### scanner?
  have_Philips = grep(pattern = "Philips", x = manu_path, ignore.case = T) %>% length
  have_SIEMENS = grep(pattern = "SIEMENS", x = manu_path, ignore.case = T) %>% length
  have_GE.MEDICAL = grep(pattern = "GE.MEDICAL", x = manu_path, ignore.case = T) %>% length

  if(sum(have_Philips, have_SIEMENS, have_GE.MEDICAL) == 0){
    EPI_list = read.csv(list.files(all.subjects.list_path, pattern = "EPB", full.names = T))

    splitted_path = str_split(string = manu_path, pattern = "/")[[1]]
    splitted_ID = splitted_path[length(splitted_path)]
    selected_Subject = EPI_list %>% filter(SUBJECT.ID == splitted_ID)
    have_Philips = grep("Philips", selected_Subject$MANUFACTURER, ignore.case = T) %>% length
  }
  if(have_Philips != 0){
    manu_path = manu_path %>% path_tail_slash()
    path_FunRaw= paste0(manu_path, "FunRaw")
    sub_list = list.files(path_FunRaw)
    type = rep("IA", length(sub_list))
    SliceOrderInfo = cbind("Subject ID" = sub_list, "Slice Order Type" = type)
    write.table(SliceOrderInfo, paste(manu_path, paste("SliceOrderInfo", "tsv", sep="."), sep=""), row.names=F, quote=F, sep="\t")
    cat("\n", crayon::blue("SliceOrderInfo.tsv is created !"), "\n")
  }else{
    cat("\n", crayon::blue("The manufacture is not Philips. No need to create SliceOrderInfo.tsv."), "\n")
  }
}

