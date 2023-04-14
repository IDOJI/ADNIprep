# seed1 <- NULL
# seed0 <- NULL
# n1 <- 100
# n2 <- 100
# n <- n1 + n2
# SNR <- 100
# #Evaluate and store results for ith observation
# for (i in 1:n1){
#   seedi < -sample(1:10000,1)
#   seed1[[i]] <- seedi }
# for (i in 1:n2){
#   seedi <- sample(1:10000,1)
#   seed0[[i]] <- seedi
# }
#
# library(neuRosim)
# #Parameters
# dimx <- 20
# dimy <- 20
#
#
# dimz <- 10
# nscan <- 100
# TR <- 2
# total <- TR*nscan
# os <- seq(1, total, 20)
# dur <- 7
# regions <- simprepSpatial(regions = 2, coord = list(c(2, 2, 2), c(-2,-3,1)), radius = c(3,1), form = "sphere")
# onset <- list(os,os) duration <- list(dur, dur) effect1 <- list(7, 15) effect2 <- list(12, 8) design1 <- simprepTemporal (regions = 2, onsets = list(os,os), durations = duration, TR = TR, hrf = "double-gamma", effectsize = effect1, totaltime=total) design2 <- simprepTemporal (regions = 2, onsets = list(os,os), durations = duration, TR = TR, hrf = "double-gamma", effectsize effect2, totaltime=total)
