RS.fMRI_1_Data.Selection___Loading.Data___SUB = function(path_Data){
  #=============================================================================
  # Loading Data
  #=============================================================================
  path_Files = list.files(path_Data, full.names = T)
  Files = path_Files %>% basename_sans_ext()
  Data.list = lapply(path_Files, read.csv) %>% setNames(Files)





  #=============================================================================
  # names to upper
  #=============================================================================
  toupper_colnames <- function(df) {
    names(df) <- toupper(names(df))
    return(df)
  }
  Data.list = lapply(Data.list, toupper_colnames)




  #=============================================================================
  # rm dup rows
  #=============================================================================
  Data.list = lapply(Data.list, unique)






  #=============================================================================
  # Remove ADNI 1
  #=============================================================================
  Remove_ADNI1 = function(df){
    if("PHASE" %in% names(df)) {
      # Filter out the rows if PHASE variable exists
      df %>% dplyr::filter(!PHASE %in% c("ADNI1", "ADNI 1", ""))
    }else{
      df
    }
  }
  Data.list = lapply(Data.list, Remove_ADNI1)







  #=============================================================================
  # Generate RID
  #=============================================================================
  Generate_RID = function(df) {
    if(!"RID" %in% colnames(df)){
      df$RID <- sub(".*_(\\d{4})$", "\\1", df$SUBJECT.ID) %>% as.numeric()
      df = df %>% dplyr::relocate(RID)
    }
    return(df)
  }
  Data.list = lapply(Data.list, Generate_RID)






  #=============================================================================
  # return
  #=============================================================================
  return(Data.list)
}
