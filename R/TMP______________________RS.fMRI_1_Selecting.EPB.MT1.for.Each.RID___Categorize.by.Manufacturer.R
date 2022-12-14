RS.fMRI_1_Selecting.EPB.MT1.for.Each.RID___Categorize.by.Manufacturer = function(data.list){
  # data.list = one_EPB_MT1.list

  data.df = do.call(rbind, one_EPB_MT1.list)
  EPB = data.df[data.df$Series_Type=="EPB",]

  ### EPB의 manufacturer
  manu_total_EPB = EPB$Manufacturer %>% unique

  ### results.list
  results.list = list()
  for(i in 1:length(manu_total_EPB)){
    ith_manu = manu_total_EPB[i]

    ith.list = lapply(data.list, ith_manu, FUN=function(x, ith_manu){
      # x = data.list[[1]]
      ### manufacturere
      if(x[x$Series_Type=="EPB",]$Manufacturer == ith_manu){
        return(x)
      }else{
        return(NULL)
      }
    })
    results.list[[i]] = rm_list_null(ith.list)
    names(results.list)[i] = ith_manu
  }# for

  ### add MB
  SIEMENS = list()
  if(manu_total_EPB[1]=="SIEMENS"){
    for(j in 1:2){
      SIEMENS[[j]] = lapply(results.list[[1]], j, FUN=function(x, j=j){
        # x = results.lits[[1]][[1]]
        x_EPB = x[x$Series_Type=="EPB",]
        ind = have_this(x_EPB$Description, " MB ", any = T, as.ind = T)
        if(length(ind)>0){
          if(j==1){
            return(x)
          }else{
            return(NULL)
          }
        }else{
          if(j==2){
            return(x)
          }else{
            return(NULL)
          }
        }
      })# lapply
    }# for
    SIEMENS[[1]] = rm_list_null(SIEMENS[[1]])
    SIEMENS[[2]] = rm_list_null(SIEMENS[[2]])

    results.list[[1]] = NULL
    results_2.list = c(SIEMENS, results.list)
    names(results_2.list)[1:2] = c("SIEMENS_MB", "SIEMENS_SB")
  }else{
    stop("The first element is not 'SIEMENS'.")
  }# if

  return(results_2.list)
}

