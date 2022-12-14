# RS.fMRI_1.2_Merging.Lists___Slice.Order.Info___Type.Extractor = function(SLICE.TIMING.ORDER){
#
#
#   SliceOrderType.list = lapply(SLICE.TIMING.ORDER, FUN=function(x){
#     # x = SLICE.TIMING.ORDER[1]
#
#     #===========================================================================
#     # 0. Splitting
#     #===========================================================================
#     x_split = strsplit(x, split="    ") %>% unlist %>% as.numeric
#     n_slice = max(x_split)
#
#
#     # IA: interleaved ascending
#     # ID: interleaved descending
#     # IA2: interleaved ascending, for SIEMENS scanner with even number of slices. Scanning of 2,4,6,... and then 1,3,5,... i.e., [2:2:SliceNumber,1:2:SliceNumber]
#     # ID2: interleaved descending, for SIEMENS scanner with even number of slices. Scanning of [SliceNumber-1:-2:1,SliceNumber:-2:1].
#
#     #===========================================================================
#     # 1. Sequential? : Ascending interleaved 1 (odd-first) : 1 3 5 2 4
#     #===========================================================================
#     if(x_split[1]==1 && x_split[2]==2){
#       # SA : Sequential Ascending
#       return("SA")
#     }else if(x_split[1]==max(x_split) && x_split[2]==(max(x_split)-1)){
#       # SD : Sequential Decending
#       return("SD")
#
#
#
#       #===========================================================================
#       # 2. Even number slices
#       #===========================================================================
#     }else if(n_slice%%2==0 && x_split[1]%%2==0 && x_split[2]%%2==0){
#       if(x_split[1] < x_split[2]){
#         # 2-1. Increasing? : Ascending interleaved 2 (even-first) 2 4 1 3
#         return("IA2")
#       }else if(x_split[1] > x_split[2]){
#         # 2-2. Decreasing? Descending interleaved 2 : 3 1 4 2 on Magnetom or 2 4 1 3
#         return("ID")
#       }
#       #===========================================================================
#       # 3. Odd number slices
#       #===========================================================================
#     }else if(n_slice%%2!=0 && x_split[1]%%2!=0 && x_split[2]%%2!=0){
#       if(x_split[1] < x_split[2] ){
#         # 2-1. Ascending interleaved 1 (odd-first) 	1 3 5 2 4
#         return("IA")
#       }else{
#         # 2-2. Ascending interleaved 1 reversed (Descending interleaved 1) 5 3 1 4 2
#         return("ID")
#       }
#
#       else{
#         return(x)
#       }
#     }
#
#
#
#   })
# }
# RS.fMRI_1_Load.Subjects.As.List___NFQ.List___Slice.Timing___Extracting.Slice.Order = function(slice.order){
#   # slice.order = NFQ_2.df$SLICE.ORDER
#
#
#
#
#
#   SliceOrderType.list %>% unlist %>% table
#
#
#
#   results.list = apply(NFQ.df, MARGIN=1, FUN=function(x){
#     # x = NFQ.df[1,] %>% unlist
#
#     ### as data frame
#     x.df = matrix(x, nrow=1) %>% as.data.frame
#     names(x.df) = names(x)
#
#     ### add slice.order.type
#     x.df = cbind(x.df, Slice.Order.Type=NA)
#
#     ### extract slice.order
#     x_slice.order = x.df$slice.order %>% strsplit(split = "    ") %>% unlist
#     first = x_slice.order[1] %>% as.numeric
#     second = x_slice.order[2] %>% as.numeric
#
#     ### decision =========================================
#     ## Sequential=====================================================
#     SA_order = 1:length(x_slice.order) %>% as.character
#     SD_order = length(x_slice.order):1 %>% as.character
#     #
#     if(sum(SA_order==x_slice.order) == length(x_slice.order)){
#       x.df$Slice.Order.Type = "SA"
#       return(x.df)
#       # SD : Sequential Descending
#     }else if(sum(SD_order==x_slice.order) == length(x_slice.order)){
#       x.df$Slice.Order.Type = "SD"
#       return(x.df)
#       ## Interleaved =====================================================
#     }else if(first%%2!=0 && second%%2!=0){ # 홀수
#       # IA : 1,3,2,4
#       if(first<second){
#         x.df$Slice.Order.Type = "IA"
#         return(x.df)
#         # ID2 : 3,1,4,2
#       }else{
#         x.df$Slice.Order.Type = "ID2"
#         return(x.df)
#       }
#     }else if(first%%2==0 && second%%2==0){ # 짝수
#       # IA2 : 2,4,1,3
#       if(first<second){
#
#         return(x.df)
#       }
#     }# else if
#   })# apply
#   return(do.call(rbind, results.list))
# }
#
#
#
# ### returning results
# text = paste("\n","Step 1.2 is done !","\n")
# cat(crayon::bgMagenta(text))
# return(dates_removed.df)
# }
