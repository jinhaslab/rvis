# 📘 GitHub Pages 배포 가이드

이 문서는 Quarto Book을 GitHub Pages로 배포하는 방법을 설명합니다.

---

## ✅ 설정 완료 사항

프로젝트는 이미 GitHub Pages 배포를 위해 설정되었습니다:

1. ✅ `_quarto.yml` - `output-dir: docs` 설정
2. ✅ `.gitignore` - `docs/` 폴더 커밋 허용
3. ✅ `.nojekyll` - Jekyll 비활성화

---

## 🚀 배포 단계

### Step 1: Quarto Book 빌드

```bash
# 프로젝트 루트에서 실행
quarto render
```

이 명령은 `docs/` 폴더에 HTML 파일을 생성합니다:

```
docs/
├── index.html
├── chapters/
│   ├── 01-introduction.html
│   ├── 02-ggplot2-basics.html
│   └── ...
├── search.json
├── site_libs/
└── ...
```

### Step 2: Git에 커밋

```bash
# 변경사항 확인
git status

# docs 폴더 포함 모든 파일 추가
git add .

# 커밋
git commit -m "Build Quarto Book for GitHub Pages"

# GitHub에 푸시
git push origin main
```

### Step 3: GitHub Pages 활성화

1. **GitHub 저장소 페이지** 방문
   - `https://github.com/YOUR_USERNAME/rvis`

2. **Settings** 탭 클릭

3. 왼쪽 메뉴에서 **Pages** 클릭

4. **Source** 섹션에서:
   - Branch: `main` 선택
   - Folder: `/docs` 선택
   - **Save** 클릭

5. 몇 분 후 배포 완료!
   - URL: `https://YOUR_USERNAME.github.io/rvis/`

---

## 🔄 업데이트 워크플로우

책 내용을 수정한 후:

```bash
# 1. 변경사항 저장
git add chapters/01-introduction.qmd
git commit -m "Update Chapter 1"

# 2. Quarto Book 다시 빌드
quarto render

# 3. 빌드 결과 커밋
git add docs/
git commit -m "Rebuild book"

# 4. GitHub에 푸시
git push origin main
```

→ GitHub Pages가 자동으로 업데이트됩니다! (1-2분 소요)

---

## 🛠️ GitHub Actions로 자동화 (선택)

매번 수동으로 빌드하기 번거롭다면, GitHub Actions로 자동화할 수 있습니다.

### `.github/workflows/publish.yml` 생성

```yaml
name: Publish Quarto Book

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  build-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2

      - name: Set up R
        uses: r-lib/actions/setup-r@v2
        with:
          r-version: '4.3.0'

      - name: Install R dependencies
        run: |
          Rscript code/setup.R

      - name: Render Quarto Book
        run: quarto render

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

이렇게 하면 `main` 브랜치에 푸시할 때마다 자동으로 빌드 및 배포됩니다!

---

## 📋 체크리스트

배포 전 확인:

- [ ] `quarto render` 정상 실행
- [ ] `docs/` 폴더에 HTML 생성 확인
- [ ] `.nojekyll` 파일 존재 확인
- [ ] `docs/` 폴더가 Git에 추가되었는지 확인
- [ ] GitHub 저장소가 **Public**인지 확인 (Private은 Pro 필요)
- [ ] GitHub Pages 설정에서 `/docs` 선택 확인

---

## 🔍 문제 해결

### Q: 페이지가 404 에러?

**원인**: GitHub Pages 설정이 잘못되었거나 빌드 파일이 없음

**해결**:
1. `docs/index.html` 파일 존재 확인
2. GitHub Settings > Pages에서 Source가 `main` 브랜치, `/docs` 폴더인지 확인
3. 저장소가 Public인지 확인

### Q: CSS/JS가 로드 안 됨?

**원인**: 상대 경로 문제

**해결**: `_quarto.yml`에 추가

```yaml
website:
  site-url: "https://YOUR_USERNAME.github.io/rvis/"
```

### Q: 빌드는 되는데 페이지가 업데이트 안 됨?

**원인**: GitHub Pages 캐시

**해결**:
1. 브라우저 캐시 삭제 (Ctrl+F5)
2. 1-2분 대기
3. GitHub Actions 탭에서 배포 상태 확인

---

## 🌐 배포 후 확인사항

✅ **필수 확인**:

1. 홈페이지 로딩 확인
   - `https://YOUR_USERNAME.github.io/rvis/`

2. 모든 챕터 링크 작동 확인
   - 사이드바 네비게이션
   - 챕터 간 이동

3. 검색 기능 작동 확인
   - 우측 상단 검색창

4. 코드 블록 작동 확인
   - 코드 복사 버튼
   - 코드 접기/펼치기

5. 반응형 디자인 확인
   - 모바일에서도 잘 보이는지

---

## 📝 커스텀 도메인 (선택)

자신의 도메인을 사용하려면:

1. **DNS 설정**:
   - A 레코드: GitHub Pages IP 주소
   - CNAME 레코드: `YOUR_USERNAME.github.io`

2. **GitHub 설정**:
   - Settings > Pages > Custom domain
   - 도메인 입력 후 Save

3. **docs/CNAME 파일** 생성:
   ```
   your-domain.com
   ```

자세한 내용: [GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)

---

## 🎉 완료!

이제 여러분의 Quarto Book이 전 세계에 공개되었습니다!

URL을 논문, 이력서, SNS에 공유하세요:

**🔗 `https://YOUR_USERNAME.github.io/rvis/`**

---

**작성일**: 2024-11-18
**버전**: 1.0
