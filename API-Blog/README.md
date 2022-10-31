#  API-Blogアプリ

- CRUDつくる
- Alamofire,KeychainAccess,Kingfisher使う
- それからOAuth認証まわり
- 画面の向きはPortrait固定
<!-- - SwiftUI の preview機能 使うかも? -->

## 画面

###  index(ブログ記事一覧画面)
  - Navigation ControllerをEmbed in
  - TableView(TableViewCell)
    - Label
      - 記事タイトル
      - 投稿ユーザー名
      - 投稿日時
      - 本文(タップしたらShowへ)
    - ImageView
      - 記事の画像(タップしたらShowへ)
    - Button
      - 投稿ボタン(Createへ)(どこに入れよう???)

### show (ブログ記事詳細画面)
 - Label
   - 記事タイトル
   - 投稿ユーザー名
   - 投稿日時
   - 本文
 - ImageView
   - 投稿画像
 - TableView
   - コメント一覧(自分のだと削除できるように)
     - コメント本文
     - コメント投稿者名
     - (できれば投稿日)
 - Button
   - 編集
   - 削除
   - コメント投稿


### create(投稿記事作成画面)
- Label
  - タイトル
  - 本文
  - 画像
- TextField
  - タイトル
- TextView
  - 本文
- Button
  - 投稿
  - 画像選択?(それか画像タップ)


### edit(投稿記事編集画面)

- Label
  - タイトル
  - 本文
  - 画像
- TextField
  - タイトル
- TextView
  - 本文
- Button
  - 更新
  - 画像選択?(それか画像タップ)

### ログイン画面
- ログインボタン(OAuth認証に飛ぶ)


### コメントcreate
- Label
  - コメントを付ける記事のタイトル
  - コメントを付ける記事本文
  - コメント
- TextView
  - コメント本文
- ImageView
  - コメントを付ける記事の画像

- Button
  - コメント投稿


### コメントedit

- Label
  - コメントを付ける記事のタイトル
  - コメントを付ける記事本文
  - コメント
- TextView
  - コメント本文
- ImageView
  - コメントを付ける記事の画像

- Button
  - コメント更新



