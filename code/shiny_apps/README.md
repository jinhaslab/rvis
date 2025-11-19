# Shiny 앱 예제

Chapter 7 "인터랙티브 시각화"에서 소개된 Shiny 앱들을 실제로 실행할 수 있는 예제 파일들입니다.

## 📁 앱 목록

### 1. 기본 Shiny 앱 (`01_basic_app`)
- **설명**: Shiny의 반응성을 보여주는 간단한 산점도 앱
- **기능**: 슬라이더로 점의 개수 조절

### 2. 감염병 감시 대시보드 (`02_disease_dashboard`)
- **설명**: 실전 공중보건 감시 시스템 예제
- **기능**:
  - 지역별/기간별 필터링
  - 인터랙티브 시계열 그래프 (plotly)
  - 지역별 비교 차트
  - 검색/정렬 가능한 데이터 테이블 (DT)

## 🚀 실행 방법

### 방법 1: RStudio에서 실행

```r
# 작업 디렉토리를 프로젝트 루트로 설정
setwd("/path/to/rvis")

# 앱 실행
shiny::runApp("code/shiny_apps/01_basic_app")
shiny::runApp("code/shiny_apps/02_disease_dashboard")
```

### 방법 2: 파일 더블클릭 (RStudio 설치된 경우)

1. RStudio에서 `app.R` 파일 열기
2. 우측 상단의 "Run App" 버튼 클릭

### 방법 3: R 콘솔에서 실행

```r
# 필요한 패키지 설치 (처음 한 번만)
install.packages(c("shiny", "tidyverse", "plotly", "DT"))

# 앱 실행
shiny::runApp("code/shiny_apps/01_basic_app")
```

## 📦 필수 패키지

```r
install.packages(c(
  "shiny",       # Shiny 프레임워크
  "tidyverse",   # 데이터 처리
  "plotly",      # 인터랙티브 그래프
  "DT"           # 인터랙티브 테이블
))
```

## 🔧 커스터마이징

각 `app.R` 파일을 수정하여 자신만의 대시보드를 만들어보세요!

### 데이터 변경하기

```r
# 02_disease_dashboard/app.R의 데이터 부분을 수정
disease_data <- read_csv("your_data.csv")  # 실제 데이터 사용
```

### UI 변경하기

```r
# titlePanel, sidebarPanel 등을 수정하여 레이아웃 변경
titlePanel("나만의 대시보드")
```

## 📚 추가 학습 자료

- **Shiny 공식 튜토리얼**: https://shiny.posit.co/r/getstarted/
- **Mastering Shiny (무료 전자책)**: https://mastering-shiny.org/
- **Shiny Gallery (예제 모음)**: https://shiny.posit.co/r/gallery/

## 🌐 온라인 배포

앱을 완성했다면 shinyapps.io에 무료로 배포할 수 있습니다:

```r
# rsconnect 패키지 설치
install.packages("rsconnect")

# 계정 연결 (https://www.shinyapps.io/ 가입 필요)
rsconnect::setAccountInfo(name="your-account",
                          token="your-token",
                          secret="your-secret")

# 앱 배포
rsconnect::deployApp("code/shiny_apps/01_basic_app")
```

## ❓ 문제 해결

### 앱이 실행되지 않을 때

1. **패키지 설치 확인**:
```r
library(shiny)
library(tidyverse)
library(plotly)
library(DT)
```

2. **작업 디렉토리 확인**:
```r
getwd()  # 프로젝트 루트 디렉토리여야 함
```

3. **파일 경로 확인**:
```r
file.exists("code/shiny_apps/01_basic_app/app.R")  # TRUE여야 함
```

## 📝 라이선스

이 예제들은 교육 목적으로 자유롭게 사용 및 수정 가능합니다.
