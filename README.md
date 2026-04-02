# README  
# アプリケーション名
"katarine"  
由来： 語り( katari ) + 音( ne )  
# アプリケーション概要
掲示板機能を通じて自身の趣味や興味関心を発信し、  
友達登録をした人とチャットで話したり、無料で物を譲渡することができる  
# URL  
(情報保護のため、隠してます)

# Basic認証ID&パスワード  
(情報保護のため、隠してます)


# テスト用アカウント
|nickname|email|password|
|-----|---------|------|
|(情報保護のため、隠してます)
|test1|test1@com|111aaa|
|test2|test2@com|222bbb|
|test3|test3@com|333ccc|
|test4|test4@com|444ddd|


# 利用方法
## user新規登録
ヘッダー上の"新規登録"をクリックすると、ユーザーの新規登録画面に移動する。  
新規登録画面で、  
ニックネーム、  
メールアドレス、  
パスワード（６文字以上）、  
漢字での苗字、漢字の名前、  
カタカナの苗字、カタカナの名前、  
誕生日、  
イメージ画像を入力する。  
（挨拶、紹介文は任意）  
登録ボタンを押すことで、ユーザー登録は完了する。

## 掲示板作成・投稿
### 掲示板作成編
１，サインイン後、ホーム画面の掲示板リストの部分から"掲示板作成"のリンクをクリック。  
２，掲示板のタイトル、説明文を記入後、送信ボタンを押す。  
３，作成した掲示板が、ホーム画面の掲示板リストに掲載される。  
### 掲示板コメント編
1, 作成した掲示板の「詳しくはこちら」をクリックすることで、掲示板の詳細ページに移動できる  
2,掲示板の詳細ページのコメント入力フォームから、画像または文章を入力し、送信ボタンを押すことで、掲示板に対するコメントを送ることができる。  
## 友達登録機能
1,test1でサインイン後、ヘッダー上の"test1"をクリックすることで、ユーザー詳細画面に移動できる。  
2,ユーザー詳細画面から、「友達募集」のボタンをクリックすることで、ホーム画面の「友達募集一覧」にtest1のデータが表示される。
（もう一度ボタンを押すことで、友達募集を停止することができ、ホーム画面に表示されなくなる。）  
３,test2が「友達募集中」の場合、ホーム画面上に表示されているtest1の「詳しくはこちら」リンクをクリックすることでtest1の詳細ページに移動することができる。  
4,test2がtest1の詳細ページにある「この人と友達になる」ボタンを押すことで、test1に対するtest2からの「友達になりたい」意思表示を送ることができる。  
５,その後、test1が自身の詳細画面からtest2からの意思表示を確認し、承認することでtest2とは友達関係として登録される。  
一方、拒否をすることで関係を拒否され、その後改めてtest2とは登録することはできなくなる
## チャット機能
1,test1としてサインイン後、ユーザー詳細画面の右側にはチャットルームの一覧があり、友達登録をした人とのチャットルームが自動的に作成されている。  
2,test2の「この人と会話する」をクリックすることで、test2とのチャットルームに移動する。  
3,チャットルームの最下部にあるメッセージ入力フォームに、文章または画像を記載し、送信ボタンを押すことで、チャットルームの画面上に作成したメッセージが表示される。
## 物品譲渡機能
1,test1としてサインイン後、ユーザー詳細画面の"物品譲渡記録はこちら"をクリックすることで、test1の物品の作成・譲渡の記録を確認することができる。
2,物品の作成・譲渡の記録ページの「物品の新規作成」をクリックすることで、物品の新規出品画面に移動する
3,出品画面で
物品名,  
物品の説明文，  
カテゴリー，  
状態，  
発送元都道府県,  
物品画像  
を入力し、"作成"ボタンを押す。  
４，ホーム画面に、test1が作成した物品が表示される。（以下itemと表記する）  
５、test2がホーム画面に表示された物品の「詳しい情報はこちら」をクリックすることで、物品の詳細画面に移動することができる  
６，物品の詳細画面で、「この物品を受け取る」をクリックすることで、test1に「受け取り希望」の意思表示をすることができる。  
7,test1がitemの詳細画面に表示された「受け取り希望」のuser一覧の中から、itemを渡したい人を選択し(今回の場合はtest2)
、test2の「この人に渡す」をクリックすることで、itemの受け渡しが暫定で決定する。  
（他のtest3などは受け取りが見送られたとして表示され、test1が受け渡しを取り消すまで、itemに受け渡し申請ができない）  
8, test1とtest2はチャットを通じて、受け渡しの方法、場所や日時などを連絡しあう。  
9,test2はtest1からitemを受け取ったら、「受け取りましたか？」をクリックすることで譲渡は確定となる。  
この時点で、test3などはitemへの申請をできないことが確定する。  



# アプリケーション作成背景
１，読書会への参加を通じ、情報技術や書籍などを通じて人々が関係を広げ、深めていくことの重要性を実感した。  
２，感染症拡大やインターネットの普及により、一人で過ごす機会の増加や、人と会うことが難しくなったことを知る。  
３，音楽やアニメーションにおける「推しごと」の広がりによる、人々が苦痛を避けて快適な環境を求めることによる「人々の興味関心の過剰な細分化」「集団の蛸壺化」により、人々が人間関係を新たに構築し、深めることが難しくなっていることを知る。  
 
上記の理由により、インターネットを通じてもっと気軽に「友達」を探すこと、チャットや物品の譲渡を通じて「友達」と手軽に交流することを可能にするアプリを考えた。

# 実装した機能についての画像やGIF及びその説明

# 実装予定の機能
友達募集、物品のカテゴリーに基づく検索機能は今後実装希望  
cssによる見やすい装飾などは現時点で途中

# 現アプリケーション作成の改善点
・機能実装に時間をかけすぎてしまい、systemテスト、バリデーション設計やcssによる装飾を大きく割愛してしまったこと。  
・カラム名やモデル名については、作成中に混乱しないように、詳しい内容がわかるよう設定したはずだった。しかし、item_requestなどのように、他のカラム名と重複するものが発生してしまった。もっと簡潔に設定することができたように思う。  
・友達登録機能などのように、自分の学習範囲外の機能を盛り込みすぎ。自分で調べながら、chat-gptによる補助を大幅に借りていた。ただし、エラー解決の時は、「あくまで具体的な解答は出さずに、ヒントを出す形で」調べていたため、自分の頭で考える部分を作っていたのはまだ良かったように思う。


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
## 掲示板・コメント作成による、情報発信から人とつながり、友達同士の交流に至る動線の作成  
地元の情報や物品をやり取りするジモティーやメルカリにヒントを得て、無料で物品を譲渡するアプリを考えました。
掲示板＋友達登録＋チャット機能＋物品譲渡を組み合わせることで、
利用者の人間関係の拡大から交流に至る過程を可能とし、他のアプリとの差別化を図りました。

## 友達登録の実装について
友達登録機能については、難解かつ自分が学んできたことでは限界があり、Chat-gptによる情報収集に大きく助けられてきました。
最初は片方向でfriend_shipを作成し、承認後は両方向でfriend_shipが存在する形式を採用しました。また、sortによるuser_idの固定によりどちらのユーザーも、メッセージ投稿が可能になるような設計にしています。その結果、双方向のユーザーで同様のアプリの使用が可能になりました。このfriend_shipの構造で、チャット機能・物品譲渡機能も双方のユーザーにとっての同じような利用が可能になっています。

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
