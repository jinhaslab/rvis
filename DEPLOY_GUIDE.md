# 📘 배포 가이드 (로컬 작업자용)

이 문서는 **로컬에서 책을 수정하고 GitHub에 배포**하는 작업자를 위한 가이드입니다.

---

## 📌 중요사항

이 저장소는 **docs 폴더만 Git에 커밋**합니다:
- ✅ `docs/` - 빌드된 HTML 파일 (GitHub Pages 배포용)
- ❌ 소스 코드(.qmd, code/, data/) - Git에 미포함

소스 코드는 **로컬에서만 관리**합니다.

---

## 🔧 로컬 환경 설정

### 1. 프로젝트 폴더 구조

로컬에는 전체 소스가 있어야 합니다:

```
rvis/ (로컬)
├── _quarto.yml
├── index.qmd
├── chapters/
├── code/
├── data/
└── docs/        ← 빌드 결과 (이것만 Git에 푸시)
```

### 2. 필수 도구 설치

- **R** ≥ 4.3.0
- **RStudio** (권장)
- **Quarto** ≥ 1.4.0

### 3. R 패키지 설치

```r
# code/setup.R 실행
source("code/setup.R")
```

⏱️ 소요 시간: 10-20분 (최초 1회)

### 4. 데이터 생성

```r
# code/data-simulation.R 실행
source("code/data-simulation.R")
```

⏱️ 소요 시간: 1-2분

---

## ✍️ 작업 워크플로우

### 1. 챕터 편집

```r
# RStudio에서 편집
chapters/01-introduction.qmd
```

### 2. 로컬 미리보기

```bash
# 터미널에서 실행
quarto preview
```

→ 브라우저에서 `http://localhost:XXXX` 자동 열림
→ 파일 수정 시 자동 새로고침

### 3. 최종 빌드

```bash
# docs/ 폴더에 HTML 생성
quarto render
```

### 4. Git 커밋 및 푸시

```bash
# Git 상태 확인 (docs만 보여야 함)
git status

# docs 폴더 추가
git add docs/

# 커밋
git commit -m "Update Chapter 1"

# GitHub에 푸시
git push origin main
```

### 5. GitHub Pages 확인

1-2분 후 <https://jinhaslab.github.io/rvis/> 에서 확인

---

## 🔄 일상적인 작업 흐름

```bash
# 1. 챕터 수정 (RStudio)
vim chapters/02-ggplot2-basics.qmd

# 2. 미리보기로 확인
quarto preview

# 3. 만족스러우면 빌드
quarto render

# 4. Git 푸시 (docs만!)
git add docs/
git commit -m "Update ggplot2 chapter"
git push
```

---

## 📁 .gitignore 설정 확인

현재 `.gitignore` 설정:

```gitignore
# 모든 파일 무시
*

# docs 폴더만 허용
!docs/
!docs/**

# 필수 파일만 허용
!.gitignore
!.nojekyll
!README.md
```

이 설정으로 `git status` 실행 시 소스 코드는 보이지 않고, **docs 폴더만** 추적됩니다.

---

## ⚠️ 주의사항

### DO ✅

- 로컬에서 자유롭게 소스 코드 수정
- `quarto render` 후 **docs만** 커밋
- README.md, .nojekyll도 커밋 가능

### DON'T ❌

- 소스 코드(.qmd, .R, .yml)를 Git에 푸시하지 마세요
- docs 폴더를 수동으로 편집하지 마세요 (자동 생성됨)
- .gitignore 설정을 변경하지 마세요

---

## 🔍 문제 해결

### Q: git status에 소스 코드가 보임?

**.gitignore가 제대로 설정되지 않았습니다:**

```bash
# .gitignore 확인
cat .gitignore

# 첫 줄이 "*" (모든 파일 무시)여야 함
```

### Q: docs 폴더가 Git에 추가 안 됨?

**강제로 추가:**

```bash
git add -f docs/
```

### Q: GitHub Pages가 404?

**체크리스트:**
1. `docs/index.html` 존재 확인
2. GitHub Settings > Pages > Source = `main` 브랜치, `/docs` 폴더
3. 저장소가 Public인지 확인

---

## 📂 백업 전략 (권장)

소스 코드는 Git에 없으므로, 로컬 백업이 중요합니다:

### 옵션 1: 별도 저장소

```bash
# 소스 코드용 별도 private 저장소
git init
git remote add origin https://github.com/jinhaslab/rvis-source.git
git add .
git commit -m "Source code backup"
git push
```

### 옵션 2: 클라우드 백업

- Google Drive
- Dropbox
- OneDrive

---

## 🎯 배포 체크리스트

배포 전 확인:

- [ ] `quarto preview`로 로컬 확인
- [ ] 모든 챕터 링크 작동 확인
- [ ] 코드 블록 실행 확인
- [ ] `quarto render` 에러 없이 완료
- [ ] `docs/index.html` 생성 확인
- [ ] `git status`에 docs만 보임
- [ ] Git 커밋 및 푸시
- [ ] 1-2분 후 GitHub Pages 확인

---

## 📞 도움말

문제가 생기면:

1. **Quarto 문서**: <https://quarto.org/docs/books/>
2. **GitHub Pages 문서**: <https://docs.github.com/pages>
3. **이슈 생성**: <https://github.com/jinhaslab/rvis/issues>
4. **이메일**: jinhaslab@gmail.com

---

**마지막 업데이트**: 2024-11-18
**작성자**: Claude Code
