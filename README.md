# README  
# アプリケーション名
"katarine"  
由来： 語り( katari ) + 音( ne )  
# アプリケーション概要
友達作りから、チャット機能・譲渡機能を一本化したコミュニティアプリ。  
掲示板機能を通じて自身の趣味や興味関心を発信、  
友達登録をした人とチャットで会話、物を譲渡することができる  
# URL  
  https://katarine.onrender.com

# Basic認証ID&パスワード  
  ID：katarine
  PASS： 3333



# テスト用アカウント
|nickname|email            |password|first_name_kanji|last_name_kanji|first_name_kana|last_name_kana|birth_day|
|--------|-----------------|--------|----------------|---------------|---------------|--------------|--------|
|test1   |test1@example.com|111aaa  |     "一郎"     |      "佐藤"    |   "イチロウ"  |   "サトウ"    |1991,1,1|
|test2   |test2@example.com|222bbb  |     "次郎"     |      "田中"    |   "ジロウ"    |   "タナカ"    |1992,2,2|
|test3   |test3@example.com|333ccc  |     "三郎"     |      "鈴木"    |   "サブロウ"  |   "スズキ"    |1993,3,3|


# 利用方法
## user新規登録  
ニックネーム、   
パスワード（６文字以上）など  
（挨拶、紹介文は任意）  
を入力すると、ユーザー登録は完了する。

## 掲示板作成・投稿
### 掲示板作成編
掲示板作成ページから、掲示板を作成・投稿できる。 
### 掲示板＆コメント編
掲示板の詳細ページで、画像または文章を入力することで、掲示板に対するコメントを送ることができる。  
## 友達登録機能 
1,ホーム画面の「友達募集一覧」に自分のデータが表示させることができる。  
2,その後、「友達募集中」のユーザー同士でお互いの合意のうえで、友達関係を成立させることができる。  
## チャット機能
ユーザー詳細画面の右側にはチャットルームの一覧があり、チャットルームの最下部にあるメッセージ入力フォームに、文章または画像を送ることができる。
## 物品譲渡機能
物品の新規出品画面で、物品を作成・公開でき、物品受け取りの希望者から一人を選んで、お互いの合意の下で受け渡しができる。  

# アプリケーション作成背景
読書会への参加を通じ、情報技術や書籍などを通じて人々が関係を広げ、深めていくことの重要性を実感した。そのため、インターネットを通じて気軽に「友達」を探し、チャットや物品の譲渡を通じて「友達」と手軽に交流することができるアプリを考えた。

# 実装した機能についての画像やGIF及びその説明

# 実装予定の機能
友達募集、物品のカテゴリーに基づく検索機能は今後実装希望。  
cssによる見やすい装飾などは現在改善中。  

# 現アプリケーション作成の改善点
学習範囲外のアプリの作成に挑んだ結果、今後の改善点として以下の点が挙げられる。
・機能実装に時間をかけすぎてしまった。  
systemテストについては今後拡充を予定。バリデーション設計やcssによる装飾は現在改善中。  
・カラム名やモデル名については、作成中に混乱しないように、詳しい内容がわかるよう設定したはずだった。しかし、item_requestなどのように、他のカラム名と重複するものが発生してしまった。もっと簡潔に設定することができたように思う。  
・友達登録機能などのように、自分の学習範囲外の機能を盛り込みすぎた。外部情報や検索機能を活用しながらアプリを実装していた。ただし、エラー解決などの時は、自分の頭で考える時間を必ず作っていた。


# データベース設計(ER図)
[![Image from Gyazo](https://i.gyazo.com/cc6b01671233b782f450e26075318876.png)](https://gyazo.com/cc6b01671233b782f450e26075318876)

# 画面遷移図  
[![Image from Gyazo](https://i.gyazo.com/bdb5d78841adfb45fbc80816cd619041.png)](https://gyazo.com/bdb5d78841adfb45fbc80816cd619041)

# 開発環境
## 使用言語
ruby-on-rails, ruby, HTML,CSS
## 開発環境
VS-CODE,chat-gptによる指導補助を受けながらの実装

# ローカルでの動作方法
以下のコマンドを順に実行
% git clone  
% cd katarine  
% bundle install  
% rails db:create  
% rails db:migrate  

# 工夫したポイント
## 掲示板→友達探し→チャット→譲渡の流れを一貫して設計した点  
地元の情報や物品をやり取りするジモティーやメルカリにヒントを得て、無料で物品を譲渡するアプリを考えた。
掲示板＋友達登録＋チャット機能＋物品譲渡を組み合わせることで、
利用者の人間関係の拡大から交流に至る過程を可能とし、他のアプリとの差別化を図った。

## お互いに利用しやすい友達登録機能の実装
友達登録機能については、難解かつ自分が学んできたことでは限界があり、Chat-gptによる情報収集に大きく助けられてきた。
最初は片方向でfriend_shipを作成し、承認後は両方向でfriend_shipが存在する形式を採用した。また、sortによるuser_idの固定によりどちらのユーザーも、メッセージ投稿が可能になるような設計にしている。その結果、双方向のユーザーで同様のアプリの使用が可能になった。このfriend_shipの構造で、チャット機能・物品譲渡機能も双方のユーザーにとっての同じような利用が可能になっている。

# 製作期間
 最初のcommit: 2025/12/26  
 アプリケーション作成完了: 2026/3/30  
 合計: 約２か月２週間ほど

# 各Model&Association設計
## user
### users table
|Column |Type |Options|
|-------|-----|-------|
|nickname|string|null: false|
|email|string| null: false, unique: true|
|encrypted_password | string | null: false |
|first_name_kanji|string|null:false|
|last_name_kanji|string|null:false|
|first_name_kana|string|null:false|
|last_name_kana|string|null:false|
|birth_day|date|null:false|
|friend_want|boolean| default: false, null: false|

#### Association  
-has_many: boards  
-has_many: comments  
-has_many: friend_ship  
-has_many: friend, through: friend_ship  
-has_many: messages  
-has_many: items  
-has_many: item_requests  
-has_one_attached: user-image  

## COMMENT_BOARD
### board
|Column |Type |Options|
|-------|-----|-------|
|name|string|null:false|
|description|text| |
|user|references|null: false, foreign_key|

#### Association  
-belongs_to: user  
-has_many:comments   

### comment
|Column |Type |Options|
|-------|-----|-------|
|content|text|null:false|
|user|references|null: false, foreign_key|
|board|references|null: false, foreign_key|

#### Association  
-belongs_to: user  
-belongs_to: board  
-has_one_attached:image  

## FRIEND
### friend_ship
|Column |Type |Options|
|-------|-----|-------|
|user|references|null: false, foreign_key|
|message|references|null: false, foreign_key|
|friend|references|null: false, foreign_key|

#### Association  
-belongs_to: user  
-belongs_to: friend,class_name:'User'  

## Chat
### chat_room
|Column |Type |Options|
|-------|-----|-------|
|user1|references|null: false, foreign_key|
|user2|references|null: false, foreign_key|

#### Association  
-belongs_to: user1  
-belongs_to: user2  
-has_many: messages  

### message
|Column |Type |Options|
|-------|-----|-------|
|content|text|null: false|
|user|references|null: false, foreign_key|
|chat_room|references|null: false, foreign_key|

#### Association  
-belongs_to: user  
-belongs_to: friend,class_name:'User'  

## ITEM
### items table
|Column |Type |Options|
|-------|-----|-------|
|item_name|string|null:false|
|item_script|text|null:false|
|category_id|integer|null: false|
|item_state_id|integer|null: false|
|prefecture_id|integer|null: false|
|reservation|integer|null: false, default:0|
|user|references|null: false, foreign_key|

#### Association  
-has_many: item_requests  
-belongs_to: user  
-has_one_attached:item-image

### item_requests table
|Column |Type |Options|
|-------|-----|-------|
|sender_id|references|null: false, foreign_key|
|item_id|references| null: false, foreign_key|
|transfer|integer|null: false, default:0|

#### Association  
-belongs_to:sender,class_name:'User'  
-belongs_to:item  
