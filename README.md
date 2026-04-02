# README

## users table
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

###Association
-has_many: boards
-has_many: comments

-has_many:friend_ship
-has_many:friend,through:friend_ship
-has_many:messages

-has_many :items
-has_many :gives
-has_many :takes

-has_one_attached:user-image

## COMMENT_BOARD
## board
|Column |Type |Options|
|-------|-----|-------|
|name|string|null:false|
|description|text| |
|user|references|null: false, foreign_key|
###Association
-belongs_to: user
-has_many:comments 



## comment
|Column |Type |Options|
|-------|-----|-------|
|content|text|null:false|
|user|references|null: false, foreign_key|
|board|references|null: false, foreign_key|
###Association
-belongs_to: user
-belongs_to: board

-has_one_attached:item-image

## FRIEND_CHAT
## friend_ship
|Column |Type |Options|
|-------|-----|-------|
|user|references|null: false, foreign_key|
|message|references|null: false, foreign_key|
|friend|references|null: false, foreign_key|

###Association
-belongs_to: user
-belongs_to: friend,class_name:'User'

## chat_room
|Column |Type |Options|
|-------|-----|-------|
|user1|references|null: false, foreign_key|
|user2|references|null: false, foreign_key|

##Association
-belongs_to: user1
-belongs_to: user2
-has_many: messages

## message
|Column |Type |Options|
|-------|-----|-------|
|content|text|null: false|
|user|references|null: false, foreign_key|
|chat_room|references|null: false, foreign_key|

###Association
-belongs_to: user
-belongs_to: friend,class_name:'User'

## ITEM
## items table
|Column |Type |Options|
|-------|-----|-------|
|item_name|string|null:false|
|item_script|text|null:false|
|category_id|integer|null: false|
|item_state_id|integer|null: false|
|prefecture_id|integer|null: false|
|reservation|integer|null: false, default:0|
|user|references|null: false, foreign_key|


###Association
-has_many: item_requests
-belongs_to: user

-has_one_attached:item-image

## item_requests table
|Column |Type |Options|
|-------|-----|-------|
|sender_id|references|null: false, foreign_key|
|item_id|references| null: false, foreign_key|
|transfer|integer|null: false, default:0|

##Association
-belongs_to:sender,class_name:'User'
-belongs_to:item

