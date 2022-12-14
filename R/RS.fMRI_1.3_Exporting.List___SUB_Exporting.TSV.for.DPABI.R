RS.fMRI_1.3_Exporting.List___SUB_Exporting.TSV.for.DPABI = function(){
  # ### Sub_000
  # nrow = 1:nrow(EPB.df) %>% as.character
  # max_nrow = nchar(nrow) %>% max
  # nrow_list = fit_length(nrow, max_nrow)
  # Sub_list = paste("Sub", nrow_list, sep="_")
  #
  # ### Slice Order Type
  # NFQ_1 = EPB.df$Slice.Order.Type_NFQ
  # NFQ_0 = EPB.df$Slice.Order.Type_NO_NFQ
  # if(length(NFQ_1[is.na(NFQ_1)])>0){
  #   NFQ_1[is.na(NFQ_1)] = NFQ_0[is.na(NFQ_1)]
  # }
  # if(sum(NFQ_1=="NA")>0){
  #   NFQ_1[NFQ_1=="NA"] = "IA" # philips는 IA
  # }
  #
  # ### making df
  # slice.order.info.df = data.frame(Sub_list, NFQ_1)
  # names(slice.order.info.df) = c("Subject ID", "Slice Order Type")
  #
  # ### writing tsv
  # tsv = paste(path, "SliceOrderInfo.tsv", sep="/")
  # write.table(slice.order.info.df, file=tsv, row.names=F, sep="\t")
}

