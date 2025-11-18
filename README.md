# R 기반 보건학 시각화

[![Quarto](https://img.shields.io/badge/Made%20with-Quarto-blue)](https://quarto.org/)
[![R](https://img.shields.io/badge/R-%3E%3D4.3.0-blue)](https://www.r-project.org/)
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

> **역학 및 임상통계를 위한 실습 가이드**

보건학, 역학, 임상 통계 분야의 대학원생과 전문가를 위한 R 시각화 Quarto Book 프로젝트입니다.

::: {.callout-note}
## 📌 저장소 구조 안내

이 저장소는 **빌드된 결과물(HTML)만** 포함합니다.
- ✅ `docs/` - GitHub Pages로 배포되는 HTML 파일
- ❌ 소스 코드(.qmd, .R) - 저장소에 미포함

소스 코드는 로컬에서만 관리됩니다.
:::

## 📖 온라인 북

- 🌐 **웹사이트**: <https://jinhaslab.github.io/rvis/>
- 📄 **PDF 다운로드**: [releases](https://github.com/jinhaslab/rvis/releases)
- 📘 **GitHub Pages 배포**: [배포 가이드](GITHUB_PAGES_SETUP.md) 참고

## ✨ 주요 특징

- ✅ **재현 가능한 실습**: 모든 코드와 데이터가 완전히 재현 가능
- ✅ **패키지 내장 데이터 우선**: 인터넷 없이도 대부분의 실습 가능
- ✅ **한글 지원**: 한국 보건학 연구자를 위한 완전 한글 설명
- ✅ **실무 중심**: 논문 작성과 대시보드 구축 실전 예제

## 🎯 학습 내용

### Part I: 기초편
- ggplot2 완전 정복
- 그래픽 문법의 7가지 구성 요소

### Part II: 역학편
- 유행 곡선 (Epidemic Curve)
- 연령 표준화 비율
- GIS와 공간 역학

### Part III: 임상통계편
- 생존 분석 (Kaplan-Meier)
- 메타 분석 (Forest Plot)
- 출판 품질 그래프

### Part IV: 고급편
- Plotly 인터랙티브 그래프
- Shiny 대시보드 구축

## 🚀 책 보기

온라인 웹사이트에서 바로 읽으세요:

👉 **<https://jinhaslab.github.io/rvis/>**

### 로컬에서 보기 (선택)

저장소를 클론하여 오프라인에서도 볼 수 있습니다:

```bash
git clone https://github.com/jinhaslab/rvis.git
cd rvis

# 웹 브라우저로 열기
open docs/index.html  # macOS
xdg-open docs/index.html  # Linux
start docs/index.html  # Windows
```

## 📁 저장소 구조

```
rvis/
├── docs/                    # GitHub Pages 배포 파일 (HTML)
│   ├── index.html
│   ├── chapters/
│   │   ├── 01-introduction.html
│   │   ├── 02-ggplot2-basics.html
│   │   └── ...
│   ├── search.json
│   └── site_libs/
│
├── .nojekyll               # GitHub Pages 설정
└── README.md               # 이 파일
```

## 🛠️ 책 제작에 사용된 도구

이 책은 다음 도구로 제작되었습니다:

- **[Quarto](https://quarto.org/)** - 과학 기술 문서 출판
- **[R](https://www.r-project.org/)** ≥ 4.3.0 - 통계 컴퓨팅
- **[ggplot2](https://ggplot2.tidyverse.org/)** - 데이터 시각화

## 📦 다루는 주요 R 패키지

```r
# Core
tidyverse, ggplot2, dplyr, tidyr

# Epidemiology
incidence2, surveil, outbreaks

# Spatial
sf, tmap, leaflet

# Clinical
survival, ggsurvfit, metafor

# Publication
patchwork, ggrepel, ggpubr

# Interactive
plotly, shiny
```

## 🤝 피드백

오탈자나 개선 제안이 있으시면 언제든 연락주세요:

- **이슈**: [GitHub Issues](https://github.com/jinhaslab/rvis/issues)
- **이메일**: jinhaslab@gmail.com

## 📜 라이선스

- **콘텐츠**: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
  - ✅ 출처 표시 시 비상업적 공유 가능
  - ✅ 2차 저작물 제작 가능 (동일 라이선스)
  - ❌ 상업적 이용 불가

## 🙏 감사의 말

이 프로젝트는 다음 오픈소스 프로젝트의 영향을 받았습니다:

- [R for Data Science](https://r4ds.hadley.nz/)
- [ggplot2 Book](https://ggplot2-book.org/)
- [The Epidemiologist R Handbook](https://epirhandbook.com/)
- [Quarto](https://quarto.org/)

## ⭐ Star History

이 프로젝트가 도움이 되었다면 ⭐ 스타를 눌러주세요!

---

**Built with ❤️ using [Quarto](https://quarto.org/) and [R](https://www.r-project.org/)**
