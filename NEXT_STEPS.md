# 🎯 다음 단계 (Next Steps)

**프로젝트 상태**: ✅ 설정 완료, Quarto 설치 필요

---

## ✅ 완료된 작업

1. **프로젝트 구조 생성**
   - ✅ 8개 챕터 템플릿 (chapters/)
   - ✅ 패키지 설치 스크립트 (code/setup.R)
   - ✅ 데이터 시뮬레이션 스크립트 (code/data-simulation.R)
   - ✅ Quarto 설정 파일 (_quarto.yml)

2. **Git 저장소 설정**
   - ✅ Git 초기화 완료
   - ✅ Remote 설정: https://github.com/jinhaslab/rvis.git
   - ✅ 브랜치: main
   - ✅ 사용자: jinhaslab <jinhaslab@gmail.com>
   - ✅ 첫 커밋 완료 (설정 파일들)

3. **docs 전용 Git 전략**
   - ✅ `.gitignore` 설정: 소스 코드 제외, docs만 허용
   - ✅ `.nojekyll` 생성: GitHub Pages용
   - ✅ 문서 작성: README.md, DEPLOY_GUIDE.md

4. **현재 Git 상태**
   ```
   On branch main
   Committed files: .gitignore, .nojekyll, README.md, DEPLOY_GUIDE.md
   Ignored files: 모든 소스 코드 (.qmd, code/, data/, _quarto.yml 등)
   ```

---

## 🔧 필수 설치 항목

### 1. Quarto 설치 (미설치)

**다운로드**: https://quarto.org/docs/get-started/

```bash
# Linux
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-amd64.deb
sudo dpkg -i quarto-1.4.550-linux-amd64.deb

# macOS
brew install quarto

# Windows
# 위 URL에서 Windows installer 다운로드
```

**설치 확인**:
```bash
quarto --version  # 1.4.0 이상 필요
```

### 2. R 버전 확인

```bash
R --version
```

**현재 상태**: ✅ R 4.5.2 설치됨 (필요: ≥4.3.0)

---

## 📋 다음 작업 순서

### Step 1: Quarto 설치

위의 방법으로 Quarto를 설치하세요.

### Step 2: R 패키지 설치 (10-20분)

```bash
cd /home/rag/lecture/rvis
Rscript code/setup.R
```

이 스크립트는 다음 패키지들을 설치합니다:
- tidyverse, ggplot2, dplyr
- incidence2, outbreaks (역학)
- sf, tmap, leaflet (공간 분석)
- survival, ggsurvfit, metafor (임상 통계)
- plotly, shiny (인터랙티브)
- 총 40+ 패키지

### Step 3: 시뮬레이션 데이터 생성 (1-2분)

```bash
Rscript code/data-simulation.R
```

다음 데이터셋이 생성됩니다:
1. `health_survey.csv` - 건강 설문조사 (N=1000)
2. `disease_incidence.csv` - 질병 발생률 (월별)
3. `regional_disease.csv` - 지역별 질병 (17개 시도)
4. `clinical_trial.csv` - 임상시험 (N=500)
5. `meta_analysis.csv` - 메타분석 (15개 연구)
6. `covid_timeseries.csv` - COVID 시계열 (~1400일)

### Step 4: Quarto 빌드 (첫 빌드)

```bash
quarto render
```

**결과**: `docs/` 폴더 생성 (HTML 파일들)

### Step 5: docs 폴더 커밋

```bash
# Git 상태 확인 (docs만 보여야 함)
git status

# docs 추가
git add docs/

# 커밋
git commit -m "Initial book build"

# GitHub에 푸시
git push -u origin main
```

### Step 6: GitHub Pages 활성화

1. https://github.com/jinhaslab/rvis 접속
2. **Settings** → **Pages**
3. **Source** 설정:
   - Branch: `main`
   - Folder: `/docs`
4. **Save** 클릭

### Step 7: 배포 확인 (1-2분 후)

웹사이트 접속: **https://jinhaslab.github.io/rvis/**

---

## 🎯 빠른 체크리스트

배포 전 확인:

- [ ] Quarto 설치됨 (`quarto --version` 확인)
- [ ] R 패키지 설치됨 (`code/setup.R` 실행)
- [ ] 시뮬레이션 데이터 생성됨 (`code/data-simulation.R` 실행)
- [ ] `quarto render` 성공 (에러 없음)
- [ ] `docs/index.html` 파일 존재
- [ ] `git status`에 docs만 보임 (소스 코드 안 보임)
- [ ] Git 푸시 완료
- [ ] GitHub Pages 활성화

배포 후 확인:

- [ ] https://jinhaslab.github.io/rvis/ 접속 가능
- [ ] 모든 챕터 링크 작동
- [ ] 검색 기능 작동
- [ ] 페이지 이동 정상

---

## 💡 팁

### 미리보기 모드 (빌드 전 확인)

```bash
# 로컬 서버 시작 (자동 새로고침)
quarto preview

# 브라우저에서 http://localhost:XXXX 자동 열림
```

### 일상적인 워크플로우

챕터를 수정한 후:

```bash
# 1. 로컬 미리보기
quarto preview

# 2. 만족하면 빌드
quarto render

# 3. Git 푸시
git add docs/
git commit -m "Update content"
git push
```

→ 1-2분 후 GitHub Pages 자동 업데이트!

---

## 🔍 문제 해결

### Q: `quarto render` 실행 시 에러?

**원인**: 필요한 R 패키지가 설치되지 않음

**해결**:
```bash
Rscript code/setup.R
```

### Q: Git에 소스 코드가 보임?

**원인**: .gitignore 설정 문제

**확인**:
```bash
cat .gitignore | head -10
# 첫 줄이 "*" (모든 파일 무시)여야 함
```

### Q: docs 폴더가 Git에 추가 안 됨?

**해결**:
```bash
git add -f docs/
```

---

## 📞 도움말

- **Quarto 문서**: https://quarto.org/docs/books/
- **GitHub Pages 가이드**: https://docs.github.com/pages
- **이슈 생성**: https://github.com/jinhaslab/rvis/issues
- **이메일**: jinhaslab@gmail.com

---

## 📂 현재 프로젝트 구조

```
rvis/
├── .git/                    ✅ Git 초기화 완료
├── .gitignore               ✅ docs 전용 설정
├── .nojekyll                ✅ GitHub Pages 설정
├── README.md                ✅ 프로젝트 설명
├── DEPLOY_GUIDE.md          ✅ 배포 가이드
│
├── _quarto.yml              📝 (로컬 전용, Git 무시)
├── index.qmd                📝 (로컬 전용, Git 무시)
├── chapters/                📝 (로컬 전용, Git 무시)
│   ├── 01-introduction.qmd
│   ├── 02-ggplot2-basics.qmd
│   └── ...
├── code/                    📝 (로컬 전용, Git 무시)
│   ├── setup.R              → 실행 필요
│   └── data-simulation.R    → 실행 필요
├── data/                    📝 (로컬 전용, Git 무시)
│   └── (시뮬레이션 데이터가 여기 생성됨)
│
└── docs/                    ⏳ (quarto render 후 생성, Git 푸시 대상)
    └── (아직 생성 안 됨)
```

---

**현재 상태**: Git 설정 완료, Quarto 설치만 하면 빌드 가능!

**다음 단계**: Quarto 설치 → 패키지 설치 → 빌드 → 푸시 → GitHub Pages 활성화

---

**작성일**: 2025-11-18
**저장소**: https://github.com/jinhaslab/rvis
**목표 URL**: https://jinhaslab.github.io/rvis/
