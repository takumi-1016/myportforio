# アルティメットチーム専用掲示板 『Ulti』 
アルティメットチーム専用の掲示板です。<br >
アルティメットとはフリスビーを使うスポーツです。 <br >
チームごとに専用の掲示板を持ち、スレッドをたて、コメントしていくことで、練習の反省やプレーの言語化などを記録してくことができます。<br >
他のチームの掲示板も閲覧することができます。

## URL
[アルティメット掲示板　URL](https://ultimate-board2.herokuapp.com/)
＊ゲストログイン機能で簡単にログインできます。

## イメージ
<img width="1440" alt="スクリーンショット 2022-11-30 19 17 54" src="https://user-images.githubusercontent.com/105266085/204770258-143a4df0-087c-41fe-98cc-dba147846b1c.png">

![giphy](https://user-images.githubusercontent.com/105266085/204940811-2e43c634-8db4-4ed6-9511-a5722d5da7ee.gif)
![giphy-1](https://user-images.githubusercontent.com/105266085/204942031-f901bdbd-e69c-4268-95df-e12ad1fbe32e.gif)

## 制作の背景
大学で所属していたアルティメットサークルで使用していた掲示板をもっと便利にしたいと思った。
他のチームの掲示板も見れるようにすることで関東の強いチームから少しでも刺激を受けれるようにしたかった。（制作者は北海道のチームでアルティメットをしていた）
## 元の掲示板からの改善点
- スレッドではなくコメントの羅列するシステムだったので何について書いているかわかりにくい→スレッド作成機能追加してテーマをわかりやすくした
- 検索機能がフリーワードしかなかった→ユーザーやタグのカテゴリでも検索できるようにした
- いいコメントだなと思っても振り返るときにいちいち探していた→いいね機能を追加してマイページから簡単に見返されるようにした
- そのチームで閉鎖されている掲示板→チーム機能を作って他のチームの掲示板を一部見られるようにした

# こだわりポイント
- チーム機能を実装→チーム制作者がチーム認証IDを設定して、IDを持ったメンバーしかチームに参加できないように！
- チームごとに掲示板を作成したチームのアルティメットの知見などを閲覧可能に！
- タグ機能では他チームのスレッドを検索結果として閲覧できる！
- コメントにプライベートカラムを設定して他のチームに見られないコメントも作成可能！

# 使用技術
- Ruby 2.7.5
- Ruby on Rails 6.1.7
- MySQL2　8.0.31
- circleci 
- rspec  3.12

# ER図
![erd](https://user-images.githubusercontent.com/105266085/204817482-60f12c2a-a323-4096-8cce-049cda3cd2ac.png)

# 機能一覧
- ユーザー登録、ログイン機能(devise)、マイページ機能（active strage）
- チーム登録機能、チーム認証
- 投稿機能
  - プライベート投稿
  - いいね機能（Ajax）
  - タグ付け機能
    - タグ検索機能
- ページネーション機能(kaminari)
- 検索機能(ransack)

# 今後追加したい機能
- ユーザーはチームを無数に作成できるので1人1チームしか作成できないようにする
- チャット機能を追加して他チームと連絡を取り練習試合などを組めるようにする
- チームのスコア機能を追加して大会や練習試合の結果をチーム内で簡単に共有できるようにする
