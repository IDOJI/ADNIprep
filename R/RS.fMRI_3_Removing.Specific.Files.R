RS.fMRI_3_Removing.Specific.Files = function(path,
                                               recursive_folder = NULL,
                                               files_list = c("FunRaw", "FunImg", "FunImgA", "FunImgAR", "RealignParameter", "ReorientMats", "QC", "T1Img", "T1ImgBet", "T1ImgCoreg", "Masks", "TRInfo.tsv"),
                                               remove=F){
  # path : lapply이므로 벡터~리스트 형태도 가능
  # recursive_folder = path에 대응하는 벡터/리스트 원소로 입력 가능
  # recursive_folder : 'path'에 path/recursive_folder/ 의 형식으로  다시 저장
  # remove=F : files_list에 있는 파일을 제외하고 나머지 삭제
  # remove=T : files_list에 있는 파일들을 삭제



  lapply(path, FUN=function(ith_path, ...){
    ind = which(path == ith_path)
    if(!is.null(recursive_folder) & length(path) == length(recursive_folder)){
      RS.fMRI_3_Removing.Specific.Files___Single.Path(ith_path, recursive_folder[ind], files_list, remove)
    }else if(is.null(recursive_folder)){
      RS.fMRI_3_Removing.Specific.Files___Single.Path(path = ith_path, files_list = files_list, remove = remove)
    }

  })

  cat("\n", crayon::red("Removing Files"), crayon::yellow("is done!"),"\n")
}
