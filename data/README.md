# 데이터 디렉토리 설명

이 폴더는 Quarto Book 실습에 사용되는 데이터를 저장합니다.

## 📁 폴더 구조

```
data/
├── raw/          # 원본 데이터 (외부 다운로드)
├── processed/    # 시뮬레이션 생성 데이터 (실습용)
├── external/     # 외부 공개 데이터 (shapefile 등)
└── README.md     # 이 파일
```

## 📊 데이터 소스

### 1. 패키지 내장 데이터 (우선 사용)

다음 데이터는 R 패키지에 내장되어 있어 별도 다운로드가 필요 없습니다:

| 데이터셋 | 패키지 | 용도 | 챕터 |
|---------|--------|------|------|
| `mtcars` | base | 기본 시각화 연습 | Ch 01, 06 |
| `iris` | base | aes() 이해 | Ch 02 |
| `ToothGrowth` | base | 그룹 비교 | Ch 02, 06 |
| `lung` | survival | 생존 분석 | Ch 05 |
| `ebola_sim$linelist` | outbreaks | 유행 곡선 | Ch 03 |
| `cancer` | surveil | 연령 표준화 | Ch 03 |
| `dat.bcg` | metafor | 메타 분석 | Ch 05 |

### 2. 시뮬레이션 데이터 (`processed/`)

`code/data-simulation.R`을 실행하여 생성:

| 파일명 | 설명 | 크기 | 챕터 |
|--------|------|------|------|
| `health_survey.csv` | 건강검진 데이터 (N=1000) | ~200KB | Ch 02 |
| `disease_incidence.csv` | 월별 질병 발생률 (2019-2023) | ~15KB | Ch 03 |
| `regional_disease.csv` | 시도별 결핵 발생률 | ~2KB | Ch 04 |
| `clinical_trial.csv` | 임상시험 데이터 (N=500) | ~50KB | Ch 05 |
| `meta_analysis.csv` | 메타분석 연구 15개 | ~5KB | Ch 05 |
| `covid_timeseries.csv` | COVID-19 유사 일별 데이터 | ~150KB | Ch 03, 07 |

**생성 방법:**

```r
source("code/setup.R")
source("code/data-simulation.R")
```

### 3. 외부 데이터 (`external/`)

다음 파일은 별도로 다운로드해야 합니다:

#### 한국 행정구역 Shapefile (Chapter 04)

- **출처**: [통계지리정보서비스(SGIS)](https://sgis.kostat.go.kr/)
- **파일**: `sig.shp`, `sig.dbf`, `sig.shx` 등
- **라이선스**: 공공누리 제1유형
- **다운로드 스크립트**: `code/download-shapefile.R`

#### 다운로드 방법:

```r
# 자동 다운로드 (준비 중)
source("code/download-external-data.R")

# 또는 수동 다운로드:
# 1. https://sgis.kostat.go.kr/view/map/openDataMap 방문
# 2. 시도/시군구 경계 다운로드
# 3. data/external/ 폴더에 압축 해제
```

## 🔄 데이터 업데이트

시뮬레이션 데이터를 다시 생성하려면:

```r
source("code/data-simulation.R")
```

새로운 시드(seed)로 다른 데이터를 원하면 스크립트의 `set.seed()` 값을 변경하세요.

## ⚠️ 주의사항

1. **Git 관리**
   - `raw/`와 `external/`는 `.gitignore`에 포함
   - `processed/`는 재현 가능하므로 커밋하지 않음

2. **데이터 크기**
   - 총 용량: < 1MB (시뮬레이션 데이터)
   - Shapefile 포함 시: ~50MB

3. **라이선스**
   - 시뮬레이션 데이터: CC0 (공개 도메인)
   - 패키지 데이터: 각 패키지 라이선스 준수
   - Shapefile: 공공누리 제1유형

## 📖 데이터 변수 설명

### `health_survey.csv`

건강검진 데이터 (N=1,000)

| 변수 | 설명 | 타입 | 범위/값 |
|------|------|------|---------|
| id | 대상자 ID | integer | 1-1000 |
| age | 나이 | integer | 20-80 |
| sex | 성별 | character | Male, Female |
| height | 키 (cm) | numeric | ~150-190 |
| weight | 체중 (kg) | numeric | ~40-120 |
| bmi | 체질량지수 | numeric | 계산값 |
| sbp | 수축기혈압 | numeric | 90-180 |
| dbp | 이완기혈압 | numeric | 60-110 |
| glucose | 공복혈당 | numeric | 70+ |
| cholesterol | 총콜레스테롤 | numeric | 120+ |
| smoker | 흡연상태 | character | Never, Former, Current |
| hypertension | 고혈압 진단 | character | Yes, No |
| diabetes | 당뇨 진단 | character | Yes, No |

### `disease_incidence.csv`

월별 질병 발생률 (2019-2023)

| 변수 | 설명 |
|------|------|
| date | 날짜 (월 단위) |
| cases | 발생 건수 |
| population | 인구수 |
| rate | 인구 10만명당 발생률 |
| lower_ci, upper_ci | 95% 신뢰구간 |

### `regional_disease.csv`

시도별 결핵 발생률 (2023)

| 변수 | 설명 |
|------|------|
| region | 시도명 |
| population | 인구수 |
| cases | 결핵 환자 수 |
| incidence_rate | 발생률 |
| asr | 연령표준화발생률 |
| risk_category | 위험도 (Low/Medium/High) |

---

**문의사항**: 데이터 관련 문제는 이슈로 남겨주세요.
