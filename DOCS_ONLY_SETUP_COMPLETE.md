# ✅ docs 전용 Git 설정 완료!

**R 기반 보건학 시각화** 프로젝트가 **docs 폴더만 Git에 커밋**하도록 설정되었습니다.

---

## 🎯 설정 요약

### 변경된 파일

1. **`.gitignore`** - 전면 재작성
   ```gitignore
   # 모든 파일 무시
   *

   # docs만 허용
   !docs/
   !docs/**

   # 필수 파일만 허용
   !.gitignore
   !.nojekyll
   !README.md
   !DEPLOY_GUIDE.md
   ```

2. **`README.md`** - docs 전용 저장소로 업데이트
   - GitHub 정보: jinhaslab/rvis
   - URL: <https://jinhaslab.github.io/rvis/>
   - 이메일: jinhaslab@gmail.com
   - 소스 코드 관련 섹션 제거
   - "빌드 결과물만 포함" 명시

3. **`_quarto.yml`** - 유지 (이미 `output-dir: docs` 설정됨)

4. **`.nojekyll`** - GitHub Pages용 (생성됨)

5. **`DEPLOY_GUIDE.md`** - 로컬 작업자용 배포 가이드 (신규)

---

## 📂 Git 저장소 구조

### GitHub에 올라가는 파일 (Public)

```
rvis/ (GitHub)
├── docs/                    ✅ 빌드된 HTML (GitHub Pages 서빙)
│   ├── index.html
│   ├── chapters/
│   └── ...
├── .gitignore               ✅ Git 설정
├── .nojekyll                ✅ GitHub Pages 설정
├── README.md                ✅ 프로젝트 설명
└── DEPLOY_GUIDE.md          ✅ 배포 가이드 (선택)
```

### 로컬에만 있는 파일 (Git 무시)

```
rvis/ (로컬)
├── _quarto.yml              ❌ Git 무시
├── index.qmd                ❌ Git 무시
├── chapters/                ❌ Git 무시
├── code/                    ❌ Git 무시
├── data/                    ❌ Git 무시
└── ...                      ❌ Git 무시
```

---

## 🚀 지금 바로 배포하기

### Step 1: 첫 빌드

```bash
# 로컬에서 책 빌드
quarto render
```

### Step 2: Git 상태 확인

```bash
git status
```

**예상 출력**:
```
On branch main
Changes not staged for commit:
  modified:   .gitignore
  modified:   README.md

Untracked files:
  .nojekyll
  DEPLOY_GUIDE.md
  docs/
```

→ 소스 코드(.qmd, code/ 등)는 **보이지 않음** ✅

### Step 3: 첫 커밋

```bash
# 모든 허용된 파일 추가
git add .

# 커밋
git commit -m "Initial docs deployment"

# GitHub에 푸시
git push origin main
```

### Step 4: GitHub Pages 활성화

1. <https://github.com/jinhaslab/rvis> → **Settings** → **Pages**
2. **Source**: Branch `main`, Folder `/docs`
3. **Save**

### Step 5: 확인

1-2분 후 → <https://jinhaslab.github.io/rvis/> 접속!

---

## 🔄 일상적인 워크플로우

챕터 수정 후:

```bash
# 1. 로컬 미리보기
quarto preview

# 2. 만족스러우면 빌드
quarto render

# 3. Git 푸시 (docs만!)
git add docs/
git commit -m "Update content"
git push
```

→ GitHub Pages 자동 업데이트!

---

## ✅ 장점

이 설정의 장점:

1. ✅ **소스 코드 비공개** - .qmd, R 스크립트 보호
2. ✅ **깔끔한 저장소** - 빌드 결과만 공개
3. ✅ **간단한 배포** - `quarto render` + `git push`
4. ✅ **GitHub Pages 완벽 호환** - `/docs` 폴더 사용

---

## ⚠️ 주의사항

### 백업 필수!

소스 코드가 Git에 없으므로 **로컬 백업 필수**:

**옵션 1**: 별도 Private 저장소

```bash
# 새 저장소 만들기
git init
git remote add origin https://github.com/jinhaslab/rvis-source-private.git
git add .
git commit -m "Source backup"
git push
```

**옵션 2**: 클라우드 백업
- Google Drive
- Dropbox
- 외장 하드

### .gitignore 보호

`.gitignore` 파일을 절대 삭제하지 마세요!
→ 삭제하면 모든 소스 코드가 Git에 노출됩니다.

---

## 📋 확인 체크리스트

배포 전:

- [ ] `.gitignore` 파일 존재 확인
- [ ] `git status`에 소스 코드 안 보임 확인
- [ ] `docs/index.html` 생성됨 확인
- [ ] 로컬 백업 설정 완료

배포 후:

- [ ] <https://jinhaslab.github.io/rvis/> 접속 확인
- [ ] 모든 챕터 링크 작동 확인
- [ ] 검색 기능 작동 확인
- [ ] 코드 복사 버튼 작동 확인

---

## 🔧 트러블슈팅

### Q: git status에 소스 코드가 보임?

```bash
# .gitignore 내용 확인
cat .gitignore

# 첫 줄이 "*" 인지 확인
# 없다면 .gitignore를 다시 생성하세요
```

### Q: docs 폴더가 Git에 추가 안 됨?

```bash
# 강제 추가
git add -f docs/

# 또는 .gitignore 확인
cat .gitignore | grep "!docs"
```

### Q: 실수로 소스를 커밋했다면?

```bash
# 마지막 커밋 취소 (로컬 파일은 유지)
git reset --soft HEAD~1

# 다시 docs만 추가
git add docs/ README.md .gitignore .nojekyll DEPLOY_GUIDE.md
git commit -m "Docs only"
```

---

## 📚 추가 문서

- **로컬 작업 가이드**: [DEPLOY_GUIDE.md](DEPLOY_GUIDE.md)
- **GitHub Pages 설정**: GitHub Settings > Pages
- **Quarto 문서**: <https://quarto.org/docs/books/>

---

## 🎉 완료!

이제 준비 완료입니다!

1. ✅ docs만 Git에 커밋되도록 설정
2. ✅ GitHub 저장소: jinhaslab/rvis
3. ✅ GitHub Pages URL: <https://jinhaslab.github.io/rvis/>
4. ✅ 이메일: jinhaslab@gmail.com

**다음 단계:**

```bash
quarto render
git add .
git commit -m "Initial deployment"
git push origin main
```

그리고 GitHub에서 Pages 설정만 하면 끝! 🚀

---

**설정 완료일**: 2024-11-18
**저장소**: <https://github.com/jinhaslab/rvis>
**웹사이트**: <https://jinhaslab.github.io/rvis/>
