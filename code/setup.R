# =============================================================================
# setup.R - 보건학 R 시각화 프로젝트 패키지 설정
# =============================================================================
#
# 이 스크립트는 프로젝트에 필요한 모든 R 패키지를 설치하고 로드합니다.
# if(!require()) 패턴을 사용하여 중복 설치를 방지합니다.
#
# 사용법:
#   source("code/setup.R")
#
# =============================================================================

# CRAN 미러 설정 (글로벌)
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# 패키지 설치 및 로드 함수
install_and_load <- function(packages) {
  for (pkg in packages) {
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      message(paste("Installing package:", pkg))
      install.packages(pkg, dependencies = TRUE)
      library(pkg, character.only = TRUE)
    } else {
      library(pkg, character.only = TRUE)
    }
  }
}

# =============================================================================
# 1. 핵심 패키지 (Core Packages)
# =============================================================================
message("Loading core packages...")

core_packages <- c(
  "tidyverse",    # 데이터 처리 및 시각화
  "here",         # 프로젝트 경로 관리
  "conflicted"    # 함수 충돌 해결
)

install_and_load(core_packages)

# 함수 충돌 해결
conflict_prefer("filter", "dplyr")
conflict_prefer("select", "dplyr")

# =============================================================================
# 2. 데이터 시각화 패키지 (Visualization Packages)
# =============================================================================
message("Loading visualization packages...")

viz_packages <- c(
  "ggplot2",      # 그래픽 문법 기반 시각화
  "scales",       # 스케일 조정
  "RColorBrewer", # 색상 팔레트
  "patchwork",    # 다중 플롯 조합
  "ggrepel",      # 텍스트 라벨 겹침 방지
  "ggpubr"        # 출판용 그래프 보조
  # viridis 색상은 ggplot2에 내장되어 있음
)

install_and_load(viz_packages)

# =============================================================================
# 3. 역학 분석 패키지 (Epidemiology Packages)
# =============================================================================
message("Loading epidemiology packages...")

epi_packages <- c(
  "incidence2",   # 유행 곡선 (Epicurve)
  "outbreaks",    # 감염병 예제 데이터
  "surveil"       # 연령 표준화 비율
)

install_and_load(epi_packages)

# =============================================================================
# 4. 공간 분석 패키지 (Spatial Analysis Packages)
# =============================================================================
message("Loading spatial packages...")

spatial_packages <- c(
  "sf"            # Simple Features (공간 데이터)
  # tmap, leaflet은 시스템 의존성 필요 (librsvg, gdal)
  # 필요시 별도 설치: sudo apt install librsvg2-dev libgdal-dev
)

# Spatial packages는 선택적으로 설치 (실패해도 계속 진행)
for (pkg in spatial_packages) {
  tryCatch({
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      message(paste("Installing package:", pkg))
      install.packages(pkg, dependencies = TRUE)
      library(pkg, character.only = TRUE)
    } else {
      library(pkg, character.only = TRUE)
    }
  }, error = function(e) {
    message(paste("Warning: Failed to install", pkg, "- skipping"))
  })
}

# =============================================================================
# 5. 임상 통계 패키지 (Clinical Statistics Packages)
# =============================================================================
message("Loading clinical statistics packages...")

clinical_packages <- c(
  "survival",     # 생존 분석
  "ggsurvfit",    # ggplot2 기반 생존 곡선
  "metafor",      # 메타 분석
  "broom"         # 모델 결과 정리
)

install_and_load(clinical_packages)

# =============================================================================
# 6. 대화형 시각화 패키지 (Interactive Visualization Packages)
# =============================================================================
message("Loading interactive packages...")

interactive_packages <- c(
  "plotly",       # 인터랙티브 그래프
  "shiny",        # 웹 애플리케이션
  "DT"            # 인터랙티브 테이블
)

install_and_load(interactive_packages)

# =============================================================================
# 7. 테마 및 스타일 패키지 (Theme Packages)
# =============================================================================
message("Loading theme packages...")

theme_packages <- c(
  "ggthemes",     # 추가 ggplot2 테마
  "showtext"      # 폰트 관리 (한글 지원)
)

install_and_load(theme_packages)

# =============================================================================
# 8. 데이터 생성 및 유틸리티 (Utilities)
# =============================================================================
message("Loading utility packages...")

utility_packages <- c(
  "fabricatr",    # 시뮬레이션 데이터 생성
  "glue",         # 문자열 조합
  "janitor",      # 데이터 정제
  "lubridate",    # 날짜/시간 처리
  "knitr",        # 문서 생성
  "kableExtra"    # 표 스타일링
)

install_and_load(utility_packages)

# =============================================================================
# 9. 한글 폰트 설정 (Korean Font Setup)
# =============================================================================
message("Setting up Korean fonts...")

if (requireNamespace("showtext", quietly = TRUE)) {
  library(showtext)
  showtext_auto()

  # Noto Sans KR 폰트 추가 (시스템에 설치되어 있어야 함)
  # font_add_google("Noto Sans KR", "notosanskr")

  message("Korean font support enabled")
}

# =============================================================================
# 10. ggplot2 기본 테마 설정
# =============================================================================
message("Setting default ggplot2 theme...")

theme_set(
  theme_minimal(base_size = 14) +
    theme(
      plot.title = element_text(face = "bold", size = 16),
      plot.subtitle = element_text(size = 12),
      axis.title = element_text(face = "bold"),
      legend.position = "bottom",
      panel.grid.minor = element_blank()
    )
)

# =============================================================================
# 완료 메시지
# =============================================================================
message("\n========================================")
message("Package setup complete!")
message("========================================")
message(paste("R version:", R.version.string))
message(paste("ggplot2 version:", packageVersion("ggplot2")))
message(paste("tidyverse version:", packageVersion("tidyverse")))
message("========================================\n")

# 설치된 패키지 목록 저장
installed_pkgs <- data.frame(
  Package = c(core_packages, viz_packages, epi_packages,
              spatial_packages, clinical_packages,
              interactive_packages, theme_packages, utility_packages),
  Version = sapply(c(core_packages, viz_packages, epi_packages,
                     spatial_packages, clinical_packages,
                     interactive_packages, theme_packages, utility_packages),
                   function(x) as.character(packageVersion(x)))
)

write.csv(installed_pkgs,
          here::here("code", "installed_packages.csv"),
          row.names = FALSE)

message("Package list saved to: code/installed_packages.csv")
