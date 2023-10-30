RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Extract.Center.Coordinate = function(ith_Brain_Coordinates){
  # 좌표 데이터 프레임의 행 개수
  # num_rows <- nrow(ith_Brain_Coordinates)

  # Extract each col
  x = ith_Brain_Coordinates$x
  y = ith_Brain_Coordinates$y
  z = ith_Brain_Coordinates$z


  # 모든 좌표의 중심 좌표 계산
  center_x <- mean(x)
  center_y <- mean(y)
  center_z <- mean(z)

  # 중심 좌표와 모든 좌표 간의 거리 계산
  # distances <- sqrt((x - center_x)^2 + (y - center_y)^2 + (z - center_z)^2)


  # 거리가 가장 작은 좌표의 인덱스 찾기
  # closest_index <- which.min(distances)

  # 가장 중심에 있는 좌표 출력
  # closest_coordinates <- ith_Brain_Coordinates[closest_index, ]
  # return(closest_coordinates)

  return(c(center_x, center_y, center_z))
}
