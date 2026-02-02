###########################################
# 메타분석 R 실습
###########################################

# 패키지 설치 및 로드
install.packages('meta')
library(meta)

###########################################
# 예제 데이터 소개: woodyplants
###########################################

library(meta)
library(ggplot2)

data(woodyplants, package = "meta")

plot(woodyplants$mean.amb, woodyplants$mean.elev, 
     main = "Check Scales",     # 제목
     xlab = "Control Mean", ylab = "Experimental Mean", 
     pch = 19, col = "blue")    # 점 모양, 색상

###########################################
# Scale 차이를 고려하지 않았을 때-MD
###########################################

library(meta)
data(woodyplants)

# 1. 실패한 시각화 (MD) 
m_md <- metacont(n.e = n.elev, mean.e = mean.elev, sd.e = sd.elev,
                 n.c = n.amb, mean.c = mean.amb, sd.c = sd.amb,
                 data = woodyplants, sm = "MD", subset = 1:20) # 너무 많으면 20개만
forest(m_md, 
       main = "Before: 단위가 제각각 (MD)", 
       digits = 1, 
       xlim = c(-100, 100))

###########################################
# Scale 차이를 고려할 때 - SMD
###########################################

m_smd <- metacont(n.e = n.elev, mean.e = mean.elev, sd.e = sd.elev,
                  n.c = n.amb, mean.c = mean.amb, sd.c = sd.amb,
                  data = woodyplants, sm = "SMD", subset = 1:20)
forest(m_smd, 
       main = "After: 표준화 완료 (SMD)", digits = 2)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (1)
# 기본 출력
###########################################

forest(m_smd)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (2)
# layout 변경
###########################################

forest(m_smd,
       layout = "JAMA")

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (3)
# 고정효과 모델 숨기기
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (4)
# 라벨 텍스트 변경
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE,
       text.random = "Overall Effect")

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (5)
# 예측구간(Prediction Interval) 추가
###########################################

forest(m_smd,
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (6)
# x축 범위 및 눈금 조정
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2))

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (7)
# 축 라벨 추가
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2")

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (8)
# 소수점 자릿수 조정
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       digits.pval = 3)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (9)
# 이질성 통계량 표시 조정
###########################################

forest(m_smd,
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       digits.pval = 3,
       print.I2 = FALSE,
       print.tau2 = FALSE,
       print.pval.Q = FALSE)

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (10)
# 색상 변경
###########################################

forest(m_smd,
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       digits.pval = 3,
       print.I2 = TRUE,
       print.tau2 = TRUE,
       print.pval.Q = TRUE,
       col.diamond = "steelblue",
       col.predict = "darkgray")

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (11)
# 표시할 열(Column) 선택
###########################################

forest(m_smd,
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       col.diamond = "steelblue",
       col.predict = "darkgray",
       leftcols = c("studlab", "n.e", "n.c"),
       rightcols = c("effect", "ci", "w.random"))

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (12)
# 열 라벨 변경
###########################################

forest(m_smd,
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       col.diamond = "steelblue",
       col.predict = "darkgray",
       leftcols = c("studlab", "n.e", "n.c"),
       leftlabs = c("Study", "N(Exp)", "N(Ctrl)"),
       rightcols = c("effect", "ci", "w.random"),
       rightlabs = c("SMD", "95% CI", "Weight(%)"))

###########################################
# R 실습 예제 - Forest plot 옵션 변화 (13)
# 정렬 순서 변경
###########################################

forest(m_smd,
       layout = "JAMA",
       common = FALSE,
       text.random = "Overall Effect",
       prediction = TRUE,
       xlim = c(-2, 2),
       at = c(-2, -1, 0, 1, 2),
       label.left = "Favours Control",
       label.right = "Favours CO2",
       digits = 2,
       col.diamond = "steelblue",
       col.predict = "darkgray",
       leftcols = c("studlab", "n.e", "n.c"),
       leftlabs = c("Study", "N(Exp)", "N(Ctrl)"),
       rightcols = c("effect", "ci", "w.random"),
       rightlabs = c("SMD", "95% CI", "Weight(%)"),
       sortvar = TE)

###########################################
# Subgroup 분석
###########################################

m_sub <- metacont(
  n.e = n.elev, mean.e = mean.elev, sd.e = sd.elev,
  n.c = n.amb, mean.c = mean.amb, sd.c = sd.amb,
  studlab = papno,
  data = woodyplants,
  sm = "SMD",
  random = TRUE,
  common = FALSE,
  subgroup = treat    # subgroup 변수 지정
)

###########################################
# Subgroup Forest Plot
###########################################

forest(m_sub,
       subgroup = TRUE,
       print.subgroup.labels = TRUE)

###########################################
# 특정 Subgroup만 선택
###########################################

# 특정 treat만 분석
m_subset <- metacont(
  n.e = n.elev, mean.e = mean.elev, sd.e = sd.elev,
  n.c = n.amb, mean.c = mean.amb, sd.c = sd.amb,
  studlab = papno,
  data = woodyplants,
  sm = "SMD",
  subset = treat %in% c("temp", "light"),
  subgroup = treat
)

forest(m_subset)

###########################################
# Subgroup 결과만 보기
###########################################

# subgroup별 요약만 출력
summary(m_subset)

###########################################
# Funnel Plot 실습 데이터
###########################################

pubbias_data <- data.frame(
  study = paste("Study", 1:15),
  n.e = c(120, 85, 90, 150, 45, 60, 200, 35, 75, 100, 40, 55, 180, 65, 95),
  mean.e = c(52, 48, 55, 51, 62, 58, 50, 68, 54, 53, 65, 59, 49, 56, 52),
  sd.e = c(12, 15, 14, 11, 18, 16, 10, 20, 14, 13, 19, 17, 11, 15, 13),
  n.c = c(118, 82, 88, 148, 47, 62, 198, 33, 73, 102, 42, 58, 178, 63, 93),
  mean.c = c(48, 46, 50, 48, 52, 50, 48, 55, 49, 49, 53, 51, 47, 50, 48),
  sd.c = c(13, 14, 15, 12, 17, 15, 11, 19, 13, 14, 18, 16, 10, 14, 12)
)

m <- metacont(
  n.e = n.e, mean.e = mean.e, sd.e = sd.e,
  n.c = n.c, mean.c = mean.c, sd.c = sd.c,
  studlab = study,
  data = pubbias_data,
  sm = "SMD",
  random = TRUE,
  common = FALSE
)

###########################################
# 기본 Funnel Plot
###########################################

funnel(m)

###########################################
# 연구명 표시
###########################################

funnel(m, studlab = TRUE)

# 라벨 크기 조정
funnel(m, 
       studlab = TRUE,
       cex.studlab = 0.8)

###########################################
# 축 범위 및 라벨 설정
###########################################

funnel(m,
       xlim = c(-2, 2),
       ylim = c(0, 0.8),
       xlab = "Standardized Mean Difference",
       ylab = "Standard Error")

###########################################
# Contour-Enhanced Funnel Plot
###########################################

funnel(m,
       contour.levels = c(0.90, 0.95, 0.99),
       col.contour = c("darkgray", "gray", "lightgray"))

###########################################
# 점/선 스타일 변경
###########################################

funnel(m,
       pch = 21,             # 테두리 있는 원
       col = "darkblue",     # 테두리 색
       bg = "lightblue",     # 채우기 색
       cex = 1.5,            # 점 크기
       lwd = 2)              # 선 두께

###########################################
# 종합 예제: 완성된 Funnel Plot
###########################################

funnel(m,
       xlim = c(-2, 2),
       xlab = "Standardized Mean Difference",
       ylab = "Standard Error",
       contour.levels = c(0.90, 0.95, 0.99),
       col.contour = c("darkgray", "gray", "lightgray"),
       pch = 19,
       col = "navy",
       cex = 1.2,
       lwd = 2,
       studlab = TRUE,
       cex.studlab = 0.8)

###########################################
# Egger's Test
###########################################

metabias(m, method.bias = "Egger")

###########################################
# Trim and Fill
###########################################

# Trim and fill 분석
tf <- trimfill(m)

# 결과 확인
summary(tf)

###########################################
# Trim and Fill Funnel Plot
###########################################

funnel(tf)

###########################################
# Trim and Fill 옵션
###########################################

# 왼쪽만 채우기
tf_left <- trimfill(m, left = TRUE)

# 오른쪽만 채우기  
tf_right <- trimfill(m, left = FALSE)

# 결과 비교
summary(tf_left)
summary(tf_right)

###########################################
# 보정 전후 비교
###########################################

# 원래 결과
summary(m)

# 보정 후 결과
summary(tf)

# 효과크기 비교
cat("원래:", m$TE.random, "\n")
cat("보정:", tf$TE.random, "\n")
