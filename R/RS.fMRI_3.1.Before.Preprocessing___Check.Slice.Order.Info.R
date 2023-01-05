### 현재 존재하는 slice order 정보가 맞게 입력되었는지 확인 : legacy
RS.fMRI_3.1.Before.Preprocessing___Check.Slice.Order.Info = function(Manu_path){
  Manu_path = path_tail_slash(Manu_path)
  Sub___Slice.Order.Info = read.csv(paste0(Manu_path, "SliceOrderInfo.tsv"))[,1] %>% substr(start = 1, stop = 7)
  Sub___FunRaw = list.files(paste0(Manu_path, "FunRaw"))
  Sub___MT1Raw = list.files(paste0(Manu_path, "T1Raw"))


  check.list = list()
  check.list[[1]] = length(Sub___FunRaw) == length(Sub___Slice.Order.Info)
  check.list[[2]] = length(Sub___MT1Raw) == length(Sub___Slice.Order.Info)
  names(check.list)[1:2] = c("Length.Diff__FunRaw vs Slice.Order.Info", "Length.Diff__MT1Raw vs Slice.Order.Info")

  check.list[[3]] = setdiff(Sub___FunRaw, Sub___Slice.Order.Info)
  check.list[[4]] = setdiff(Sub___MT1Raw, Sub___Slice.Order.Info)
  names(check.list)[3:4] = c("Only in FunRaw", "Only in MT1")


  check.list[[5]] = setdiff(Sub___Slice.Order.Info, Sub___FunRaw)
  check.list[[6]] = setdiff(Sub___Slice.Order.Info, Sub___FunRaw)
  names(check.list)[5:6] = c("Only in SliceOrder (FunRaw)", "Only in SliceOrder (MT1Raw)")

  return(check.list)
}
