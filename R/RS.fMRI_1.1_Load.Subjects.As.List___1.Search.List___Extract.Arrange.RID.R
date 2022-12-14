RS.fMRI_1.1_Load.Subjects.As.List___1.Search.List___Extract.Arrange.RID = function(df, which.col="SUBJECT.ID"){

  # extracting
  if(is.data.frame(df)){
    PTID = df[,which.col] %>% unlist
    RID = substr(PTID, nchar(PTID)-3, nchar(PTID)) %>% as.numeric %>% suppressWarnings()
    if(class(RID)=="character"){
      RID = stringr::str_squish(RID)
    }
    combined.df = cbind(RID=RID, df) %>% dplyr::arrange(RID)
    combined.df = dplyr::as_tibble(combined.df)
    combined.df$RID = combined.df$RID %>% as.character
    return(combined.df)
  }else if(is.vector(df)){
    # subject ID인 경우
    RID = substr(df, start=nchar(x[1])-3, stop=nchar(x[1]))
    return(RID)
  }
}
