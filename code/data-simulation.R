# =============================================================================
# data-simulation.R - 실습용 시뮬레이션 데이터 생성
# =============================================================================
#
# 이 스크립트는 챕터별 실습에 필요한 시뮬레이션 데이터를 생성합니다.
# 생성된 데이터는 data/processed/ 폴더에 저장됩니다.
#
# 사용법:
#   source("code/setup.R")           # 먼저 패키지 로드
#   source("code/data-simulation.R")  # 데이터 생성
#
# =============================================================================

# 패키지 로드 확인
if (!require("tidyverse", quietly = TRUE)) {
  stop("Please run 'source(\"code/setup.R\")' first!")
}

# 재현 가능성을 위한 시드 설정
set.seed(2024)

# 저장 경로
data_dir <- here::here("data", "processed")
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

message("Generating simulation datasets...")

# =============================================================================
# 1. 건강검진 데이터 (Chapter 02 - ggplot2 기초)
# =============================================================================
message("Creating health_survey dataset...")

n_subjects <- 1000

health_survey <- tibble(
  id = 1:n_subjects,
  age = round(rnorm(n_subjects, mean = 45, sd = 15)),
  sex = sample(c("Male", "Female"), n_subjects, replace = TRUE, prob = c(0.48, 0.52)),
  height = ifelse(sex == "Male",
                  rnorm(n_subjects, 172, 7),
                  rnorm(n_subjects, 159, 6)),
  weight = ifelse(sex == "Male",
                  rnorm(n_subjects, 72, 12),
                  rnorm(n_subjects, 58, 10)),
  bmi = weight / (height/100)^2,
  sbp = rnorm(n_subjects, mean = 120, sd = 15),  # 수축기혈압
  dbp = rnorm(n_subjects, mean = 80, sd = 10),   # 이완기혈압
  glucose = rnorm(n_subjects, mean = 100, sd = 20), # 공복혈당
  cholesterol = rnorm(n_subjects, mean = 200, sd = 40), # 총콜레스테롤
  smoker = sample(c("Never", "Former", "Current"),
                  n_subjects, replace = TRUE, prob = c(0.6, 0.2, 0.2)),
  exercise = sample(c("None", "1-2days", "3-4days", "5+days"),
                    n_subjects, replace = TRUE, prob = c(0.3, 0.3, 0.25, 0.15)),
  income = sample(c("Low", "Middle", "High"),
                  n_subjects, replace = TRUE, prob = c(0.3, 0.5, 0.2)),
  region = sample(c("Seoul", "Gyeonggi", "Busan", "Daegu", "Incheon"),
                  n_subjects, replace = TRUE, prob = c(0.2, 0.25, 0.15, 0.15, 0.25))
) %>%
  mutate(
    age = pmax(20, pmin(age, 80)),  # 나이 범위 제한
    bmi = round(bmi, 1),
    sbp = pmax(90, pmin(sbp, 180)),
    dbp = pmax(60, pmin(dbp, 110)),
    glucose = pmax(70, glucose),
    cholesterol = pmax(120, cholesterol),
    # 고혈압, 당뇨, 고지혈증 진단
    hypertension = ifelse(sbp >= 140 | dbp >= 90, "Yes", "No"),
    diabetes = ifelse(glucose >= 126, "Yes", "No"),
    hyperlipidemia = ifelse(cholesterol >= 240, "Yes", "No")
  )

write_csv(health_survey, file.path(data_dir, "health_survey.csv"))
message("  ✓ health_survey.csv created (N=", n_subjects, ")")

# =============================================================================
# 2. 감염병 발생 데이터 (Chapter 03 - 역학)
# =============================================================================
message("Creating disease_incidence dataset...")

# 2019-2023년 월별 데이터
dates <- seq(as.Date("2019-01-01"), as.Date("2023-12-31"), by = "month")
n_months <- length(dates)

disease_incidence <- tibble(
  date = dates,
  year = year(date),
  month = month(date),
  # 계절성이 있는 질병 발생 패턴
  cases = rpois(n_months,
                lambda = 100 + 50*sin(2*pi*(month-3)/12) + (year-2019)*10),
  population = 100000,
  rate = (cases / population) * 100000
) %>%
  mutate(
    # 95% 신뢰구간 계산 (Poisson)
    lower_ci = rate - 1.96 * sqrt(cases) / population * 100000,
    upper_ci = rate + 1.96 * sqrt(cases) / population * 100000,
    lower_ci = pmax(0, lower_ci)
  )

write_csv(disease_incidence, file.path(data_dir, "disease_incidence.csv"))
message("  ✓ disease_incidence.csv created (", n_months, " months)")

# =============================================================================
# 3. 지역별 질병 발생률 데이터 (Chapter 04 - 공간 역학)
# =============================================================================
message("Creating regional_disease dataset...")

# 한국 시도 이름
regions <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종",
             "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주")

regional_disease <- tibble(
  region = regions,
  population = c(9668465, 3350711, 2401110, 2947217, 1441552, 1451635, 1120189, 348254,
                 13565072, 1536814, 1591625, 2119631, 1793319, 1836832, 2620346, 3319314, 672948),
  cases = rpois(length(regions), lambda = c(450, 180, 120, 150, 80, 85, 65, 20,
                                             650, 90, 95, 130, 110, 115, 160, 200, 45)),
  disease = "Tuberculosis",
  year = 2023
) %>%
  mutate(
    incidence_rate = (cases / population) * 100000,
    # 연령 표준화 비율 (시뮬레이션)
    asr = incidence_rate * runif(n(), 0.9, 1.1),
    risk_category = case_when(
      asr < 20 ~ "Low",
      asr < 40 ~ "Medium",
      TRUE ~ "High"
    )
  )

write_csv(regional_disease, file.path(data_dir, "regional_disease.csv"))
message("  ✓ regional_disease.csv created (", nrow(regional_disease), " regions)")

# =============================================================================
# 4. 임상시험 데이터 (Chapter 05 - 임상통계)
# =============================================================================
message("Creating clinical_trial dataset...")

n_patients <- 500

clinical_trial <- tibble(
  patient_id = 1:n_patients,
  treatment = sample(c("Control", "Treatment A", "Treatment B"),
                     n_patients, replace = TRUE),
  age = round(rnorm(n_patients, 60, 12)),
  sex = sample(c("Male", "Female"), n_patients, replace = TRUE),
  baseline_score = rnorm(n_patients, 50, 10),
  followup_score = baseline_score +
    ifelse(treatment == "Control", rnorm(n_patients, 0, 5),
           ifelse(treatment == "Treatment A", rnorm(n_patients, 10, 5),
                  rnorm(n_patients, 15, 5))),
  # 생존 분석 데이터
  time = rexp(n_patients, rate = ifelse(treatment == "Control", 0.1,
                                         ifelse(treatment == "Treatment A", 0.08, 0.06))),
  event = rbinom(n_patients, 1, 0.7)  # 70%가 이벤트 발생
) %>%
  mutate(
    age = pmax(18, pmin(age, 90)),
    baseline_score = pmax(0, pmin(baseline_score, 100)),
    followup_score = pmax(0, pmin(followup_score, 100)),
    improvement = followup_score - baseline_score,
    time = round(pmax(0.1, pmin(time, 60)), 1)  # 최대 60개월
  )

write_csv(clinical_trial, file.path(data_dir, "clinical_trial.csv"))
message("  ✓ clinical_trial.csv created (N=", n_patients, ")")

# =============================================================================
# 5. 메타분석 데이터 (Chapter 05 - 임상통계)
# =============================================================================
message("Creating meta_analysis dataset...")

n_studies <- 15

meta_analysis <- tibble(
  study = paste0("Study ", 1:n_studies),
  year = sample(2010:2023, n_studies, replace = TRUE),
  n_treatment = sample(50:200, n_studies, replace = TRUE),
  n_control = sample(50:200, n_studies, replace = TRUE),
  # 치료군 이벤트
  events_treatment = rbinom(n_studies, size = n_treatment, prob = 0.15),
  # 대조군 이벤트
  events_control = rbinom(n_studies, size = n_control, prob = 0.25),
  country = sample(c("Korea", "USA", "Japan", "UK", "Germany"),
                   n_studies, replace = TRUE)
) %>%
  arrange(year) %>%
  mutate(
    # 위험비 계산
    risk_treatment = events_treatment / n_treatment,
    risk_control = events_control / n_control,
    risk_ratio = risk_treatment / risk_control,
    log_rr = log(risk_ratio),
    # 표준오차
    se_log_rr = sqrt(1/events_treatment - 1/n_treatment +
                       1/events_control - 1/n_control),
    # 95% CI
    lower_ci = exp(log_rr - 1.96 * se_log_rr),
    upper_ci = exp(log_rr + 1.96 * se_log_rr)
  )

write_csv(meta_analysis, file.path(data_dir, "meta_analysis.csv"))
message("  ✓ meta_analysis.csv created (", n_studies, " studies)")

# =============================================================================
# 6. 시계열 COVID-19 유사 데이터 (Chapter 03, 07)
# =============================================================================
message("Creating covid_timeseries dataset...")

dates <- seq(as.Date("2020-01-20"), as.Date("2023-12-31"), by = "day")
n_days <- length(dates)

# 여러 wave 시뮬레이션
wave1 <- dnorm(1:n_days, mean = 60, sd = 30) * 500
wave2 <- dnorm(1:n_days, mean = 200, sd = 40) * 800
wave3 <- dnorm(1:n_days, mean = 400, sd = 50) * 1200
wave4 <- dnorm(1:n_days, mean = 650, sd = 60) * 1500
wave5 <- dnorm(1:n_days, mean = 900, sd = 70) * 1000

covid_timeseries <- tibble(
  date = dates,
  cases = rpois(n_days, lambda = pmax(10, wave1 + wave2 + wave3 + wave4 + wave5)),
  deaths = rpois(n_days, lambda = pmax(0, cases * 0.01)),
  tests = rpois(n_days, lambda = cases * runif(n_days, 20, 50)),
  vaccinated = cumsum(c(rep(0, 365), rpois(n_days - 365, lambda = 50000)))
) %>%
  mutate(
    positivity_rate = (cases / tests) * 100,
    positivity_rate = pmin(positivity_rate, 100),
    moving_avg_7 = zoo::rollmean(cases, 7, fill = NA, align = "right"),
    year = year(date),
    month = month(date),
    weekday = wday(date, label = TRUE)
  )

write_csv(covid_timeseries, file.path(data_dir, "covid_timeseries.csv"))
message("  ✓ covid_timeseries.csv created (", n_days, " days)")

# =============================================================================
# 데이터 생성 완료
# =============================================================================
message("\n========================================")
message("All simulation datasets created!")
message("========================================")
message("Location: ", data_dir)
message("\nGenerated files:")
message("  1. health_survey.csv")
message("  2. disease_incidence.csv")
message("  3. regional_disease.csv")
message("  4. clinical_trial.csv")
message("  5. meta_analysis.csv")
message("  6. covid_timeseries.csv")
message("========================================\n")
