#  API-Blogアプリ(iOS側)
作業ブランチは`feature ブランチです。
pod install`してから **workspace** のファイルを開いてビルド⌘+Bしてください。

- 画面の向きはPortrait固定
- CRUDつくる
- Alamofire,KeychainAccess,Kingfisher使う
- それからOAuth認証まわり
<!-- - SwiftUI の preview機能 使うかも? -->





## 画面

###  画面構成

| クラス名                    | Storyboard ID | 画面の概要                           | 
| --------------------------- | ------------- | ------------------------------------ | 
| LoginViewController         | Login         | ログイン画面                         | 
| IndexViewController         | Index         | 記事一覧を表示する画面               | 
| DetailViewController        | Detail        | 記事の詳細とコメントを表示する画面   | 
| CreateViewController        | Create        | 投稿する記事の内容を入力する画面     | 
| EditViewController          | Edit          | 自分が投稿した記事を編集する画面     | 
| CreateCommentViewController | CreateComment | 投稿に対してのコメントを入力する画面 | 
| EditCommentViewController   | EditComment   | 自分がしたコメントを編集する画面     | 


### APIのURL

| API内容      | Method URL                               | 
| ------------ | ---------------------------------------- | 
| OAuth認証    | GET oauth/authorization                  | 
| Token発行    | POST oauth/token                         | 
| 詳細         | GET api/posts/{post}                     | 
| 一覧         | GET api/posts                            | 
| 投稿         | POST api/posts                           | 
| 更新         | PUT/PATCH api/posts/{post}               | 
| 削除         | DELETE api/posts/{post}                  | 
| コメント投稿 | POST api/posts/{post}/comments           | 
| コメント削除 | POST api/posts/{post}/comments/{comment} | 


###  index(ブログ記事一覧画面)

- Navigation ControllerをEmbed in
- セルが選択されたらcellForRowAtでshowへ
- TableView(TableViewCell)
  - Label
    - 記事タイトル
    - 投稿ユーザー名
    - 投稿日時
  - ImageView
    - 記事の画像
  - Lable
    - 本文
  - Button
    - 投稿ボタン(Createへ)(どこに入れよう???)

#### 制約
- 全て左右から10
- 部品それぞれの間隔が全て10
- Labelの高さ(Height)
  - Title 24以上
  - Author 20以上
  - created at  14 固定
  - body 20以上 (Content Hugging Priority Vertical をマイナス1して250にすることで制約が決まる)

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



