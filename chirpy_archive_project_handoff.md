# Chirpy GitHub Pages 프로젝트 인수인계 노트

> 작성일: 2026-08-09  
> 목적: ChatGPT에서 진행하던 Jekyll + Chirpy + GitHub Pages 설정을 Codex에서 이어가기 위한 작업 맥락 정리

---

## 1. 프로젝트 목표

GitHub Pages에 기존 개인 페이지와 별도로 Chirpy 기반 블로그를 운영한다.

- GitHub 사용자명: `tsavodive`
- 기존 개인 페이지 저장소: `tsavodive/tsavodive.github.io`
- 기존 개인 페이지 URL: `https://tsavodive.github.io`
- 새 블로그 저장소: `tsavodive/archive`
- 목표 블로그 URL: `https://tsavodive.github.io/archive/`

즉, `archive`는 GitHub Pages의 **Project Site**로 운영한다.

---

## 2. 로컬 프로젝트 위치

Windows 환경이며 VS Code + PowerShell을 사용 중이다.

로컬 저장소 경로:

```text
C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive
```

PowerShell에서 이동:

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"
```

현재 위치 확인:

```powershell
pwd
```

---

## 3. Git 관련 초기 상황

처음에는 Git이 설치되지 않아 명령이 인식되지 않았다.

설치 안내로 사용했던 명령:

```powershell
winget install --id Git.Git -e --source winget
```

설치 후 VS Code를 재시작했다.

`archive` 저장소는 처음 clone했을 때 비어 있었는데, 이는 새 repository였기 때문에 정상이었다.

`.git` 폴더는 절대 삭제하지 않는다.

---

## 4. Jekyll 초기 설정

처음에는 기본 Jekyll 사이트를 만들고 로컬 실행을 시도했다.

UTF-8 코드 페이지 설정:

```powershell
chcp 65001
```

정상 출력:

```text
Active code page: 65001
```

과거 문서에 `650001`이라고 적힌 것은 오타였다.

기본 Jekyll 실행 시 포트 4000에서 다음 오류가 발생했다.

```text
Permission denied - bind(2) for 127.0.0.1:4000 (Errno::EACCES)
```

그래서 현재는 포트 `4001`을 사용한다.

---

## 5. Chirpy 적용

Chirpy 테마 파일을 로컬 `archive` 폴더에 복사/덮어쓰기했다.

현재는 Chirpy 테마 화면이 로컬에서 정상적으로 표시되고 있다.

옛날 Chirpy 가이드에 다음과 같은 지침이 있었으나, 현재 버전과 완전히 일치하지 않으므로 그대로 적용하지 않았다.

- `Gemfile.lock` 삭제
- `.travis.yml` 삭제
- `_posts` 삭제
- `docs` 삭제
- `.github/workflows` 정리
- `pages-deploy.yml.hook` → `pages-deploy.yml`

중요:
- 현재 Chirpy에서는 오래된 가이드를 무조건 따라 파일을 삭제하지 않는다.
- `_posts`는 실제 게시글을 넣는 폴더이므로 필요하다.
- `.github/workflows/pages-deploy.yml`은 GitHub Pages 배포에 사용되므로 함부로 삭제하지 않는다.
- `.git`은 절대 삭제하지 않는다.

---

## 6. Ruby 버전 문제와 해결

처음 설치된 Ruby는:

```text
Ruby 4.0.6
```

이었다.

Chirpy 설치 중 Bundler가 다음 오류를 냈다.

```text
Because every version of jekyll-theme-chirpy depends on Ruby ~> 3.1
and Gemfile depends on jekyll-theme-chirpy >= 0,
Ruby ~> 3.1 is required.
So, because current Ruby version is = 4.0.6,
version solving has failed.
```

`Ruby ~> 3.1`은 대략:

```text
>= 3.1, < 4.0
```

범위를 의미한다.

그래서 Ruby 4.0 대신 **Ruby+Devkit 3.4.10 x64**를 설치했다.

현재 Ruby 경로:

```text
C:\Ruby34-x64\bin\ruby.exe
```

Ruby 확인 명령:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -v
```

PATH 문제 때문에 단순히 `ruby`, `bundle`을 실행하면 과거 Ruby 실행 파일을 참조하는 문제가 있었다.

따라서 현재 가장 확실한 실행 방식은 Ruby 실행 파일을 직접 지정하는 것이다.

예:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

Bundler 설치/실행도 필요하면 다음 방식 사용 가능:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S gem install bundler
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle -v
```

Chirpy 의존성 설치 시 사용:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle install
```

GitHub Actions/Linux용 플랫폼 추가:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle lock --add-platform x86_64-linux
```

---

## 7. html-proofer 오류

Chirpy를 적용한 후:

```text
Could not find gem 'html-proofer (~> 5.0)' in locally installed gems.
Run `bundle install` to install missing gems.
```

오류가 발생했다.

원인은 Chirpy의 새 `Gemfile`에 필요한 gem들이 아직 설치되지 않았던 것이다.

`bundle install`을 다시 수행하여 해결했다.

---

## 8. Node.js / npm 설치

Chirpy 화면은 보이지만 PowerShell에 다음 오류가 반복됐다.

```text
ERROR '/assets/js/dist/theme.min.js' not found.
ERROR '/assets/js/dist/home.min.js' not found.
ERROR '/assets/js/dist/post.min.js' not found.
ERROR '/assets/js/dist/categories.min.js' not found.
ERROR '/assets/js/dist/commons.min.js' not found.
ERROR '/assets/js/dist/misc.min.js' not found.
ERROR '/assets/js/dist/page.min.js' not found.
```

원인은 Chirpy 원본 소스의 JavaScript build 결과물이 아직 생성되지 않았기 때문이었다.

Chirpy의 `package.json`에는 다음 build 과정이 있다.

- `npm run build`
- CSS build
- JS build

Node.js를 설치했다.

현재 확인된 Node.js 버전:

```text
v24.19.0
```

Node.js 설치 중 Visual Studio Build Tools 관련 추가 설치도 실행된 것으로 보였으나, Chirpy 작업에 핵심적인 것은 Node.js + npm이다.

---

## 9. PowerShell npm 실행 정책 문제

PowerShell에서:

```powershell
npm -v
```

실행 시 다음 오류가 발생했다.

```text
npm : 이 시스템에서 스크립트를 실행할 수 없으므로
C:\Program Files\nodejs\npm.ps1 파일을 로드할 수 없습니다.

PSSecurityException
UnauthorizedAccess
```

이는 npm이 없는 문제가 아니라 PowerShell Execution Policy가 `npm.ps1` 실행을 막은 것이다.

Execution Policy를 변경하지 않고 **`npm.cmd`를 사용**하기로 했다.

확인:

```powershell
npm.cmd -v
```

앞으로 npm 명령은 PowerShell에서 다음처럼 사용할 수 있다.

```powershell
npm.cmd install
npm.cmd run build
```

---

## 10. Chirpy JavaScript build 성공

프로젝트 폴더에서 실행:

```powershell
npm.cmd install
npm.cmd run build
```

그 후 확인:

```powershell
Get-ChildItem .\assets\js\dist
```

현재 실제로 생성된 파일:

```text
app.min.js
categories.min.js
commons.min.js
home.min.js
misc.min.js
page.min.js
post.min.js
sw.min.js
theme.min.js
```

즉 이전의:

```text
/assets/js/dist/theme.min.js not found
/assets/js/dist/home.min.js not found
...
```

문제는 해결된 상태다.

---

## 11. 현재 로컬 서버 실행 방법

현재 추천 실행 명령:

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"

& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

서버를 종료하려면:

```text
Ctrl + C
```

컴퓨터를 재부팅하거나 PowerShell을 닫으면 서버도 종료된다.

다시 작업할 때는 위 명령으로 새로 서버를 켜면 된다.

---

## 12. `_config.yml` 관련 현재 핵심 이슈

처음 `_config.yml`에는 다음처럼 되어 있었다.

```yaml
url: "https://tsavodive.github.io/archive"
```

그리고 `baseurl`은 작성되어 있지 않았다.

이 설정은 GitHub Pages Project Site에 적절하지 않다.

최종 목표가:

```text
https://tsavodive.github.io/archive/
```

이므로 설정은 다음처럼 분리하는 방향으로 수정하기로 했다.

```yaml
url: "https://tsavodive.github.io"
baseurl: "/archive"
```

즉:

```text
url     = https://tsavodive.github.io
baseurl = /archive
```

합쳐져 실제 배포 URL:

```text
https://tsavodive.github.io/archive/
```

가 된다.

### 중요

이 대화의 마지막 상태에서는 사용자가 `_config.yml`의 URL/baseurl을 위와 같이 수정하라는 안내를 받은 상태다.

수정 여부는 Codex에서 실제 `_config.yml` 파일을 열어 확인할 것.

---

## 13. baseurl 관련 최근 로컬 증상

로컬에서 다음 주소는 열렸다.

```text
http://127.0.0.1:4001/archives/
```

하지만 PowerShell에서:

```text
ERROR '/archive/' not found.
```

가 발생했다.

당시 `_config.yml`을 확인해보니:

```yaml
url: "https://tsavodive.github.io/archive"
```

였고 `baseurl`은 없었다.

따라서 위 설정을 다음으로 바꾸기로 했다.

```yaml
url: "https://tsavodive.github.io"
baseurl: "/archive"
```

수정 후에는 `_config.yml` 변경이므로 Jekyll 서버를 재시작해야 한다.

```text
Ctrl + C
```

후:

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

그 후 PowerShell에 출력되는 `Server address`를 그대로 브라우저에서 열어 확인한다.

예상 주소는 설정에 따라:

```text
http://127.0.0.1:4001/archive/
```

형태가 될 수 있다.

단, Codex에서는 실제 현재 Jekyll/Chirpy 버전과 `_config.yml`을 보고 로컬 baseurl 동작을 다시 확인하는 것이 좋다.

---

## 14. `_config.yml`에서 관리할 주요 설정

Chirpy의 기본 설정 구조는 대략 다음과 같다.

```yaml
lang: ko-KR
timezone: Asia/Seoul

title: 블로그 제목
tagline: 블로그 부제

description: >-
  검색엔진과 피드 등에 사용할 블로그 설명

url: "https://tsavodive.github.io"
baseurl: "/archive"

github:
  username: tsavodive

social:
  name: 표시할 이름
  email: 이메일 주소
  links:
    - https://github.com/tsavodive

theme_mode:

avatar:
social_preview_image:

toc: true
```

### `description: >-`

`>-`는 YAML folded block scalar다.

여러 줄로 작성해도 최종적으로 한 문자열처럼 처리되며 마지막 개행을 제거한다.

`description`은 주로:
- SEO meta description
- Atom feed subtitle

등에 사용된다.

`tagline`은 Chirpy 화면에서 보이는 부제 성격이다.

---

## 15. 블로그에서 주로 수정할 파일/폴더

프로젝트 구조에서 주로 직접 수정할 곳:

```text
archive
├─ _config.yml
├─ _posts/
├─ _tabs/
│  └─ about.md
├─ _data/
│  ├─ contact.yml
│  └─ share.yml
└─ assets/
   └─ img/
```

### `_config.yml`

전체 사이트 설정:
- title
- tagline
- description
- URL/baseurl
- GitHub 사용자명
- 언어
- 시간대
- 프로필 이미지
- 소셜 정보

### `_posts/`

블로그 글 저장.

파일명 예:

```text
2026-08-09-first-post.md
```

예시:

```markdown
---
title: 첫 번째 글
date: 2026-08-09 22:00:00 +0900
categories: [Blog]
tags: [jekyll, chirpy]
description: 첫 번째 테스트 게시글
---

본문
```

### `_tabs/about.md`

About / 정보 페이지.

기본 front matter는 가급적 유지:

```yaml
---
icon: fas fa-info-circle
order: 4
---
```

그 아래 Markdown으로 소개 작성.

### `_data/contact.yml`

사이드바 하단 GitHub/X/email/RSS 등의 연락처 아이콘 설정.

### `_data/share.yml`

게시물 하단 공유 버튼 설정.

### `assets/img/`

프로필 이미지 및 게시글 이미지 저장.

---

## 16. 한국어 설정

Chirpy에는 한국어 locale 파일이 있다.

`_config.yml`:

```yaml
lang: ko-KR
timezone: Asia/Seoul
```

로 설정하면 메뉴 등이 한국어로 표시될 수 있다.

한국어 locale에는 다음 메뉴 번역이 존재한다.

- 홈
- 카테고리
- 태그
- 아카이브
- 정보

---

## 17. 프로필 이미지 예시

파일:

```text
assets/img/avatar.png
```

설정:

```yaml
avatar: /assets/img/avatar.png
```

대표 공유 이미지 예:

```text
assets/img/site-preview.png
```

```yaml
social_preview_image: /assets/img/site-preview.png
```

---

## 18. 절대 직접 수정하지 않는 것이 좋은 곳

일반적인 운영 중 다음은 직접 수정하지 않는 것이 좋다.

```text
_site/
.jekyll-cache/
Gemfile.lock
.github/workflows/pages-deploy.yml
```

### `_site`

Jekyll build 결과물.

직접 수정해도 다음 build 때 덮어쓴다.

### `.jekyll-cache`

Jekyll 캐시.

### `Gemfile.lock`

gem 의존성 버전 고정 파일.

문제 해결 목적으로 한 번 삭제할 수는 있지만 평소 임의 수정하지 않는다.

### `.github/workflows/pages-deploy.yml`

GitHub Pages Actions 배포 설정.

버전별 Chirpy 설정을 확인하고 수정해야 하므로 함부로 삭제/교체하지 않는다.

---

## 19. `.gitignore` 관련 주의

Chirpy 원본 `.gitignore`에는 버전에 따라 다음이 들어 있을 수 있다.

```text
_sass/vendors
assets/js/dist
```

과거 대화에서 이를 제거/주석 처리하자는 안내도 있었으나, 이후 검토 결과:

**현재는 당장 `.gitignore`를 수정하지 않기로 했다.**

이유:
- 로컬 실행부터 정상화하는 것이 우선
- Chirpy 버전/배포 방식에 따라 `assets/js/dist` 처리 방식이 달라질 수 있음
- GitHub Actions에서 build할지, 생성 파일을 repo에 넣을지 확인 후 결정해야 함

Codex에서 실제 현재 Chirpy 버전과 `.github/workflows/pages-deploy.yml`, `.gitignore`를 함께 보고 결정할 것.

---

## 20. favicon 오류

로컬 서버에서 다음 오류도 있었다.

```text
ERROR '/favicon.ico' not found.
```

이 오류는 JS 파일 누락과 달리 사이트 핵심 기능을 막는 오류는 아니다.

브라우저 탭 아이콘 관련 문제라 우선 무시하고, 나중에 favicon 커스터마이징 단계에서 해결 가능하다.

---

## 21. 현재까지 확인된 성공 상태

다음은 이미 성공했다.

- Git 설치
- `archive` repository 로컬 작업
- Jekyll 설치
- Chirpy 테마 적용
- Ruby 4.0 → Ruby 3.4.10 전환
- Chirpy gem dependencies 설치
- Node.js 설치 (`v24.19.0`)
- npm 사용 가능 (`npm.cmd`)
- `npm.cmd install`
- `npm.cmd run build`
- `assets/js/dist/*.min.js` 정상 생성
- Chirpy 화면 표시
- Categories / Tags / Archives / About 메뉴 화면 표시

현재 남은 핵심 확인 사항은 **GitHub Pages Project Site용 URL/baseurl 설정**이다.

---

## 22. Codex에서 가장 먼저 할 일

### 1) 실제 `_config.yml` 확인

특히:

```yaml
url:
baseurl:
```

현재 값 확인.

목표:

```yaml
url: "https://tsavodive.github.io"
baseurl: "/archive"
```

### 2) 서버 재실행

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"

& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

### 3) PowerShell의 `Server address` 확인

그 주소를 그대로 브라우저에서 열 것.

### 4) 다음 오류가 사라졌는지 확인

```text
ERROR '/archive/' not found.
```

### 5) 메뉴 링크 확인

- Home
- Categories
- Tags
- Archives
- About

각 링크가 `/archive/...` 기준으로 올바르게 생성되는지 확인.

### 6) 이후 Git 상태 확인

```powershell
git status
```

현재 변경 파일과 untracked 파일 확인.

특히:
- `_config.yml`
- `package-lock.json`
- `assets/js/dist`
- 기타 Chirpy 파일

어떤 파일을 commit해야 하는지는 현재 workflow/build 구조를 확인한 뒤 결정할 것.

---

## 23. 향후 GitHub 배포 목표

최종적으로:

```text
https://tsavodive.github.io/archive/
```

에서 Chirpy 블로그가 정상 작동해야 한다.

기존:

```text
https://tsavodive.github.io
```

개인 페이지는 그대로 유지해야 한다.

따라서 `tsavodive.github.io` 저장소를 덮어쓰지 않고 `tsavodive/archive` 프로젝트 저장소에서만 작업한다.

---

## 24. PowerShell 작업 치트시트

### 프로젝트로 이동

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"
```

### 위치 확인

```powershell
pwd
```

### Ruby 확인

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -v
```

### Node 확인

```powershell
node -v
```

### npm 확인

PowerShell에서는:

```powershell
npm.cmd -v
```

### Node 의존성 설치

```powershell
npm.cmd install
```

### Chirpy JS/CSS build

```powershell
npm.cmd run build
```

### JS build 결과 확인

```powershell
Get-ChildItem .\assets\js\dist
```

### Ruby/Jekyll 의존성 설치

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle install
```

### 로컬 Jekyll 서버

```powershell
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

### 서버 종료

```text
Ctrl + C
```

### Git 상태 확인

```powershell
git status
```

---

## 25. 현재 환경 요약

```text
OS: Windows
Editor: VS Code
Shell: PowerShell

GitHub user: tsavodive
Repo: tsavodive/archive

Local project:
C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive

Ruby:
3.4.10
C:\Ruby34-x64\bin\ruby.exe

Node.js:
v24.19.0

npm:
PowerShell ExecutionPolicy 때문에 `npm` 대신 `npm.cmd` 사용

Jekyll local port:
4001

Target public URL:
https://tsavodive.github.io/archive/
```

---

## 26. Codex에 전달할 한 줄 요약

> Windows/VS Code 환경에서 `tsavodive/archive`를 Jekyll Chirpy 기반 GitHub Pages Project Site로 만드는 중이다. Ruby 3.4.10, Node 24.19.0 설치 및 Chirpy JS build까지 완료했고 `assets/js/dist` 파일도 생성됐다. 현재 `_config.yml`의 `url`/`baseurl`을 Project Site 방식(`url: https://tsavodive.github.io`, `baseurl: /archive`)으로 바로잡고 로컬/배포 링크가 정상인지 확인하는 단계다.
