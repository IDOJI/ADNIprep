RS.fMRI_1.3_Exporting.Lists___SUB_Export.SliceOrderInfo = function(path, EPB=NULL, filename=NULL, Sub_Num = NULL){

  if(!is.null(EPB)){
    type = EPB$FMRI___SLICE.ORDER.TYPE
    if(type[1]!="No Need"){
      ## TSV
      path = path %>% path_tail_slash()
      subject = paste("Sub_", fit_length(1:nrow(EPB), nrow(EPB) %>% nchar), sep = "")
      SliceOrderInfo = cbind("Subject ID" = subject, "Slice Order Type" = type)
      write.table(SliceOrderInfo, paste(path, paste(filename, "tsv", sep="."), sep=""), row.names=F, quote=F, sep="\t")
    }
  }else{
    ## TSV
    path = path %>% path_tail_slash()
    SliceOrderInfo = cbind("Subject ID" = Sub_Num, "Slice Order Type" = "IA")
    write.table(SliceOrderInfo, paste0(path, "SliceOrderInfo.tsv"), row.names=F, quote=F, sep="\t")
  }



  text1 = crayon::blue("Exporting")
  text2 = crayon::red("SliceOrderInfo.tsv")
  text3 = crayon::blue("for DPABI is done!")
  cat("\n", text1, text2, text3,"\n")
}
