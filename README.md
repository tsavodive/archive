# archive

[Jekyll](https://jekyllrb.com/) + [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 테마로 만든 개인 블로그입니다.

공개 주소: <https://tsavodive.github.io/archive/>

## 글쓰기 · 운영 방법

**[POSTING_GUIDE.md](POSTING_GUIDE.md)** 를 참고하세요.
새 글 작성부터 배포까지 전 과정이 한국어로 정리되어 있습니다.

## 빠른 시작

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001
```

→ <http://127.0.0.1:4001/archive/>

## 배포

`main` 브랜치에 push하면 GitHub Actions가 자동으로 빌드·배포합니다.
설정은 [.github/workflows/pages-deploy.yml](.github/workflows/pages-deploy.yml) 에 있습니다.

## 라이선스

테마: MIT ([LICENSE](LICENSE)) — © 2019 Cotes Chung
