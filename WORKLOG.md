# 작업 기록

> 다음 작업을 시작할 때 이 파일부터 읽으면 됩니다.
> 일하는 방법은 [POSTING_GUIDE.md](POSTING_GUIDE.md) 에 정리되어 있습니다.

---

## 현재 상태 (2026-08-10 기준)

- 사이트: <https://tsavodive.github.io/archive/> — 정상 동작
- 저장소: `tsavodive/archive` (**공개 저장소**), 브랜치 `main`
- 로컬 경로: `C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive`
- push하면 GitHub Actions가 2~4분 뒤 사이트를 갱신함

## 2026-08-10 에 한 일

1. **메뉴 이름 변경** — `_data/locales/ko-KR.yml`
   홈/카테고리/태그/아카이브/정보 → **전체 글 / 주제별 보기 / 키워드별 보기 / 날짜별 보기 / 소개**
2. **프로필 사진 적용** — `assets/img/avatar.jpg` + `_config.yml` 의 `avatar` 경로 지정
   (깃허브 웹에서 `assets/avatar.jpg` 로도 올라갔던 중복 파일은 삭제함)
3. **연락처 아이콘 정리** — `_data/contact.yml`
   깃허브 아이콘 삭제, 개인 홈페이지(지구본)·유튜브 추가. 푸터 저작권 링크도 홈페이지로 변경
4. **글 초안 9개 생성** — `_drafts/` (아래 참고)
5. **초안을 로컬 전용으로 전환** — `.gitignore` 에 `_drafts/` 추가하고 기존 추적 파일 5개 추적 해제
6. **POSTING_GUIDE.md 보강** — 분류 체계 절, 초안 공개 범위 절 추가

## 다음에 할 일

- [ ] `_tabs/about.md` 의 `[대괄호]` 채우기 (이력·취급 분야·연락처). 지금은 템플릿 상태
- [ ] `_posts/2026-08-09-blog-open.md` (첫 글) 내용 채우기. 지금은 템플릿 상태이고 홈 상단에 고정(`pin: true`)되어 있음
- [ ] `_drafts/` 초안 9개 중 완성한 것부터 `_posts/` 로 옮기기
- [ ] 사무실 주소·전화번호 확정되면 `_data/contact.yml` 의 주석 처리된 전화·지도 항목 활성화
- [ ] 인스타그램 계정 주소 확정되면 `_data/contact.yml:22-24` 주석 해제
- [ ] (선택) 파비콘이 아직 Chirpy 기본값 — `assets/img/favicons/`

## 초안 9개 (로컬에만 있음, 깃허브에 없음)

| 파일 | 분류 |
| --- | --- |
| `_drafts/2026-08-02-civil-damages.md` | 수행기록 › 민사 |
| `_drafts/2026-08-03-criminal-defense.md` | 수행기록 › 형사 |
| `_drafts/2026-08-04-family-divorce.md` | 수행기록 › 가사 |
| `_drafts/2026-08-05-administrative-case.md` | 수행기록 › 행정 |
| `_drafts/2026-08-06-before-lawyer.md` | 이력 › 변호사가 되기까지 |
| `_drafts/2026-08-07-law-school-days.md` | 이력 › 변호사가 되기까지 |
| `_drafts/2026-08-08-my-work-today.md` | 이력 › 지금 하는 일 |
| `_drafts/2026-08-09-career-interview.md` | 단상 › 진로 |
| `_drafts/2026-08-10-first-visit-to-lawyer.md` | 단상 › 상담실에서 |

각 파일 맨 위 `<!-- -->` 안에 그 글을 쓸 때의 주의사항이 적혀 있습니다(사이트에는 안 보임).

## 꼭 기억할 것

- **저장소가 공개(public)입니다.** `_posts` 에 넣고 push하면 곧바로 전 세계에 공개됩니다.
  의뢰인이 특정될 수 있는 내용(이름·상호·정확한 날짜·금액·사건번호)은 옮기기 전에 반드시 지울 것
- **`_drafts` 는 이 컴퓨터에만 있습니다.** 백업되지 않으니 오래 쓰는 글은 따로 복사해 둘 것
- **깃허브 웹에서 직접 수정하지 말 것.** 로컬과 어긋나 충돌이 납니다. 작업 전 `git pull` 습관화

## 자주 쓰는 명령

```powershell
cd "C:\Users\mln\Desktop\장기프로젝트\개인페이지\archive"

# 미리보기 (초안까지 보려면 --drafts)
& "C:\Ruby34-x64\bin\ruby.exe" -S bundle exec jekyll serve --port 4001 --drafts
# → http://127.0.0.1:4001/archive/

# 올리기
git pull
git add . ; git commit -m "설명" ; git push
```

`_config.yml` 을 고쳤을 때만 서버를 껐다 켜야 합니다(`Ctrl + C` 후 재실행).
