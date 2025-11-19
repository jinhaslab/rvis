# ✅ GitHub Pages 배포 준비 완료!

**R 기반 보건학 시각화** 프로젝트가 GitHub Pages 배포를 위해 완벽하게 설정되었습니다.

---

## 🎯 변경 사항 요약

### 1. `_quarto.yml` 수정
```yaml
# 변경 전
output-dir: _book

# 변경 후
output-dir: docs  # ← GitHub Pages용!
```

### 2. `.gitignore` 수정
```gitignore
# docs 폴더를 Git에 커밋할 수 있도록 허용
!docs/

# 루트 레벨의 html/pdf만 무시 (docs 내부는 허용)
/*.html
/*.pdf
```

### 3. `.nojekyll` 생성
- GitHub Pages가 Jekyll을 사용하지 않도록 설정
- Quarto 빌드 결과를 그대로 서빙

### 4. 문서 추가
- ✅ `GITHUB_PAGES_SETUP.md` - 상세한 배포 가이드
- ✅ `README.md` 업데이트 - 빠른 시작에 배포 정보 추가

---

## 🚀 배포하는 방법 (3단계)

### Step 1: 빌드
```bash
quarto render
```

→ `docs/` 폴더에 HTML 생성됨

### Step 2: Git 푸시
```bash
git add .
git commit -m "Initial Quarto Book build"
git push origin main
```

### Step 3: GitHub 설정
1. GitHub 저장소 → **Settings** → **Pages**
2. **Source**:
   - Branch: `main`
   - Folder: `/docs`
3. **Save**

완료! 몇 분 후 `https://YOUR_USERNAME.github.io/rvis/` 에서 확인 가능

---

## 📁 빌드 후 폴더 구조

```
rvis/
├── docs/                    ← GitHub Pages가 서빙할 폴더!
│   ├── index.html
│   ├── chapters/
│   │   ├── 01-introduction.html
│   │   ├── 02-ggplot2-basics.html
│   │   └── ...
│   ├── search.json
│   ├── site_libs/
│   └── ...
│
├── .nojekyll               ← Jekyll 비활성화
├── _quarto.yml             ← output-dir: docs
└── ...
```

---

## 🔄 일상적인 워크플로우

챕터를 수정한 후:

```bash
# 1. 챕터 편집
vim chapters/01-introduction.qmd

# 2. 변경사항 커밋
git add chapters/01-introduction.qmd
git commit -m "Update Chapter 1"

# 3. 책 다시 빌드
quarto render

# 4. 빌드 결과 커밋 및 푸시
git add docs/
git commit -m "Rebuild book"
git push origin main
```

→ 1-2분 후 GitHub Pages 자동 업데이트!

---

## ✅ 배포 전 체크리스트

빌드 및 배포하기 전에 확인:

- [ ] `quarto render` 실행 → 에러 없이 완료
- [ ] `docs/index.html` 파일 존재 확인
- [ ] `.nojekyll` 파일 존재 확인
- [ ] GitHub 저장소가 **Public**인지 확인
- [ ] Git에 `docs/` 폴더가 추가되었는지 확인

```bash
# 확인 명령어
ls -la docs/index.html
ls -la .nojekyll
git status  # docs/ 폴더가 staged/committed 되었는지
```

---

## 🎨 자동화 (선택사항)

매번 수동으로 `quarto render`하기 번거롭다면, GitHub Actions를 설정하세요.

**`.github/workflows/publish.yml`** 생성:

```yaml
name: Publish Quarto Book

on:
  push:
    branches: [main]

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2

      - name: Set up R
        uses: r-lib/actions/setup-r@v2

      - name: Install R packages
        run: Rscript code/setup.R

      - name: Render Book
        run: quarto render

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

이렇게 하면 코드 푸시만으로 자동 빌드 및 배포!

---

## 🌐 배포 후 URL

배포 완료 후 다음 URL에서 책을 볼 수 있습니다:

**🔗 `https://YOUR_USERNAME.github.io/rvis/`**

(YOUR_USERNAME을 실제 GitHub 사용자명으로 변경)

### URL 예시:
- GitHub 사용자명이 `johndoe`인 경우
- → `https://johndoe.github.io/rvis/`

---

## 📝 문제 해결

### Q: `quarto render` 실행 시 에러?

**해결**:
```bash
# Quarto 버전 확인
quarto --version  # 1.4.0 이상 필요

# 업데이트
# https://quarto.org/docs/get-started/ 방문
```

### Q: docs 폴더가 비어있음?

**해결**:
```bash
# .gitignore 확인
cat .gitignore | grep docs

# 다음이 있어야 함:
# !docs/

# 강제 추가
git add -f docs/
```

### Q: GitHub Pages에서 404?

**해결**:
1. `docs/index.html` 존재 확인
2. GitHub Settings > Pages > Source가 `/docs` 인지 확인
3. 저장소가 Public인지 확인
4. 1-2분 대기 후 재확인

---

## 🎉 완료!

모든 설정이 완료되었습니다!

이제:
1. `quarto render` 실행
2. Git 푸시
3. GitHub Pages 활성화

하면 여러분의 Quarto Book이 전 세계에 공개됩니다! 🌍

**상세 가이드**: [GITHUB_PAGES_SETUP.md](GITHUB_PAGES_SETUP.md)

---

**설정 완료일**: 2024-11-18
**버전**: 1.0
