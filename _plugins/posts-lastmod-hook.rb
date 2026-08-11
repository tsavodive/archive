#!/usr/bin/env ruby
#
# 글의 '수정일'(last_modified_at)을 깃 커밋 이력에서 뽑아내던 훅입니다.
#
# 2026-08-12 에 껐습니다.
#   본문을 고칠 때뿐 아니라 태그·카테고리만 손봐도 커밋이 쌓여
#   전부 '수정'으로 집계되는 것이 실제와 맞지 않았습니다.
#   오른쪽 '최근 글' 패널은 이제 게시일(front matter 의 date) 순으로 정렬됩니다.
#
# 되살리려면 아래 주석을 풀면 됩니다.
# (글 머리말의 수정일 표시는 별개입니다. _layouts/post.html 을 함께 고쳐야 합니다)

# Jekyll::Hooks.register :posts, :post_init do |post|
#
#   commit_num = `git rev-list --count HEAD "#{ post.path }"`
#
#   if commit_num.to_i > 1
#     lastmod_date = `git log -1 --pretty="%ad" --date=iso "#{ post.path }"`
#     post.data['last_modified_at'] = lastmod_date
#   end
#
# end
