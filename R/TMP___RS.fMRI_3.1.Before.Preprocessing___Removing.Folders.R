RS.fMRI_3.1.Before.Preprocessing___Removing.Folders = function(path, repreprocessing=T){
  # path = "D:/ADNI/ADNI_RS.fMRI/New_Template/[완료]2.SIEMENS_SB_3_4"

  if(repreprocessing){
    except_files = c("FunImgA", "FunImgAR","FunImgARC","FunImgARCovs","FunImgARCW","FunImgARCWS","FunImgARCWSF","FunImgARCWSFsym","Masks", "RealignParameter","SymmetricGroupT1MeanTemplate","T1ImgBet","T1ImgCoreg","T1ImgNewSegment", "TRInfo.tsv", "Results")
  }else{
    except_files = c("FunImgA", "FunImgAR","FunImgARC","FunImgARCovs","FunImgARCW","FunImgARCWS","FunImgARCWSF","FunImgARCWSFsym","Masks", "SymmetricGroupT1MeanTemplate","T1ImgBet","T1ImgCoreg","T1ImgNewSegment", "TRInfo.tsv", "FunImg", "T1Img")
  }

  files_path = paste0(path, "/", except_files)
  sapply(files_path, FUN=function(ith_files_path){
    unlink(ith_files_path, recursive = T)
  })


  ### DPARSFA_AutoSave_
  unlink(list.files(path, pattern = "DPARSFA_AutoSave_", full.names = T), recursive=T)

  text = crayon::green("Unnecessary files created by the former preprocessing is removed clearly ! ")
  cat(text)
}
