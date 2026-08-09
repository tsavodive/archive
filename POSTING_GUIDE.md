# 블로그 사용 설명서

이 저장소는 Jekyll + Chirpy 테마로 만든 블로그입니다.
공개 주소: <https://tsavodive.github.io/archive/>

---

## 1. 가장 자주 하는 일: 새 글 쓰기

### 1단계 — 파일 만들기

`_posts` 폴더 안에 아래 규칙대로 파일을 만듭니다.

```text
_posts/2026-08-15-my-first-case.md
```

파일 이름 규칙:

- 반드시 `연도-월-일-제목.md` 형식 (`2026-08-15-...`)
- **제목 부분은 영문 소문자와 하이픈(-)** 을 쓰세요.
  주소창에 그대로 들어가기 때문에 한글은 깨져 보입니다.
  (글 제목 자체는 한글로 씁니다. 파일 이름만 영문입니다.)

가장 쉬운 방법은 `_drafts/00-글-템플릿.md` 를 복사해서
`_posts` 폴더에 붙여넣고 이름을 바꾸는 것입니다.

### 2단계 — 글 내용 쓰기

파일 맨 위 `---` 사이 부분을 **front matter** 라고 합니다. 여기가 글의 설정입니다.

```markdown
---
title: 이혼 소송에서 재산분할은 어떻게 정해지나
date: 2026-08-15 14:00:00 +0900
categories: [법률, 가사]
tags: [이혼, 재산분할]
description: 재산분할 비율이 정해지는 기준을 정리했습니다.
---

여기부터 본문입니다.
```

| 항목 | 뜻 |
| --- | --- |
| `title` | 글 제목 (한글 그대로) |
| `date` | 작성 시각. `+0900`은 한국 시간 |
| `categories` | 최대 2단계. `[대분류, 소분류]` |
| `tags` | 개수 제한 없음. 소문자 권장 |
| `description` | 목록·검색에 보이는 한 줄 요약 |
| `pin: true` | 홈 맨 위에 고정 (선택) |

### 3단계 — 내 컴퓨터에서 확인

PowerShell을 열고:

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

브라우저에서 <http://127.0.0.1:4001/archive/> 를 엽니다.

- 글을 고치고 저장하면 자동으로 다시 만들어집니다. 새로고침만 하면 됩니다.
- **단, `_config.yml`을 고쳤을 때는** `Ctrl + C`로 끄고 위 명령을 다시 실행해야 합니다.
- 끝낼 때는 `Ctrl + C`.

### 4단계 — 인터넷에 올리기

```powershell
git add .
git commit -m "새 글: 재산분할 기준 정리"
git push
```

푸시하고 나면 GitHub가 자동으로 사이트를 다시 만듭니다.
**2~4분 정도 뒤에** <https://tsavodive.github.io/archive/> 에 반영됩니다.

진행 상황은 GitHub 저장소의 **Actions** 탭에서 볼 수 있습니다.
초록색 체크(✓)면 성공, 빨간색 X면 실패입니다.

---

## 2. 글 수정하기 / 지우기

- **수정**: `_posts` 안의 해당 `.md` 파일을 고치고 → 3·4단계 반복
- **삭제**: 파일을 지우고 → 3·4단계 반복
- **임시 보관**: 파일을 `_posts`에서 `_drafts`로 옮기면 사이트에서 사라집니다.
  (파일은 그대로 남아 있어 나중에 되돌릴 수 있습니다.)

`_drafts` 안의 글을 미리 보려면:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001 --drafts
```

---

## 3. 이미지 넣기

1. 이미지 파일을 `assets/img/posts/` 폴더에 넣습니다. (폴더가 없으면 새로 만드세요)
2. 글 본문에서 이렇게 씁니다.

```markdown
![설명](/assets/img/posts/사진이름.png)
```

대표 이미지(목록·SNS 공유에 뜨는 그림)로 지정하려면 front matter에:

```yaml
image:
  path: /assets/img/posts/사진이름.png
  alt: 사진 설명
```

### 프로필 사진

1. 사진을 `assets/img/avatar.jpg` 로 저장합니다.
2. `_config.yml`에서 `avatar:` 줄을 이렇게 바꿉니다.

```yaml
avatar: /assets/img/avatar.jpg
```

3. 서버를 재시작합니다.

---

## 4. 자주 쓰는 마크다운 문법

```markdown
## 큰 제목
### 작은 제목

**굵게**  *기울임*  ~~취소선~~

- 목록
- 목록
  - 하위 목록

1. 번호 목록
2. 번호 목록

> 인용문

[링크 이름](https://example.com)

| 표 머리 | 표 머리 |
| --- | --- |
| 내용 | 내용 |
```

Chirpy 전용 강조 상자:

```markdown
> 알아두면 좋은 정보
{: .prompt-info }

> 유용한 팁
{: .prompt-tip }

> 주의할 점
{: .prompt-warning }

> 위험 / 경고
{: .prompt-danger }
```

더 많은 예시는 `_drafts/2019-08-08-text-and-typography.md` 와
`_drafts/2019-08-08-write-a-new-post.md` 에 들어 있습니다. (Chirpy 공식 문서, 영문)

---

## 5. 블로그 설정 바꾸기 (`_config.yml`)

| 항목 | 설명 |
| --- | --- |
| `title` | 블로그 제목 |
| `tagline` | 제목 아래 부제 |
| `description` | 검색엔진에 보이는 설명 |
| `url` / `baseurl` | 주소 설정. **건드리지 마세요** |
| `social.name` / `social.email` | 작성자 이름·이메일 |
| `avatar` | 프로필 사진 경로 |
| `theme_mode` | `light`, `dark`, 또는 비우면 방문자가 선택 |

수정 후에는 반드시 서버를 재시작해야 반영됩니다.

### 메뉴(탭) 수정

`_tabs/` 폴더 안의 파일들입니다.

- `about.md` — 소개 페이지 (자유롭게 수정)
- `categories.md`, `tags.md`, `archives.md` — 자동 생성 페이지 (수정 불필요)

`order` 숫자가 작을수록 메뉴에서 위에 표시됩니다.

---

## 6. 건드리지 말아야 할 것

| 대상 | 이유 |
| --- | --- |
| `.git/` | 버전 관리 정보. 지우면 전부 날아갑니다 |
| `_site/`, `.jekyll-cache/` | 빌드 결과물. 자동 생성됩니다 |
| `_layouts/`, `_includes/`, `_sass/`, `_javascript/` | 테마 코드 |
| `.github/workflows/pages-deploy.yml` | 자동 배포 설정 |
| `node_modules/` | 라이브러리 |

---

## 7. 문제가 생겼을 때

### 서버가 안 켜질 때

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle install
npm.cmd install
npm.cmd run build
```

를 차례로 실행한 뒤 다시 서버를 켜 보세요.

### 화면이 이상하게(스타일 없이) 나올 때

JS/CSS 빌드 결과물이 없는 경우입니다.

```powershell
npm.cmd run build
```

### 포트가 이미 사용 중이라고 할 때

`--port 4002` 처럼 다른 번호를 쓰면 됩니다.

### GitHub Actions가 빨간 X로 실패할 때

Actions 탭 → 실패한 항목 클릭 → 빨간 단계를 펼쳐 오류 메시지를 확인합니다.
글 안에 존재하지 않는 이미지나 링크가 있으면 `Test site` 단계에서 실패합니다.

### npm 명령이 안 될 때

PowerShell에서는 `npm` 대신 **`npm.cmd`** 를 쓰세요.

---

## 8. 명령어 요약

```powershell
# 프로젝트로 이동
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"

# 로컬 서버 켜기 (→ http://127.0.0.1:4001/archive/)
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001

# 임시글까지 같이 보기
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001 --drafts

# 인터넷에 올리기
git add .
git commit -m "설명"
git push

# 라이브러리 재설치가 필요할 때
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle install
npm.cmd install
npm.cmd run build
```
