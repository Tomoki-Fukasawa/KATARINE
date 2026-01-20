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
-has_many:messages

## message
|Column |Type |Options|
|-------|-----|-------|
|content|text|null: false|
|user|references|null: false, foreign_key|
|friend_ship|references|null: false, foreign_key|
###Association
-belongs_to: user
-belongs_to: friend,class_name:'User'
-belongs_to: friend_ship

## ITEM_GIVE_TAKE
## items table
|Column |Type |Options|
|-------|-----|-------|
|item_name|string|null:false|
|item_script|text|null:false|
|category_id|integer|null: false|
|item_state_id|integer|null: false|
|prefecture_id|integer|null: false|
|deliver_day_id|integer|null: false|
|user|references|null: false, foreign_key|


###Association
-has_one:give
-has_one:take
-belongs_to:user

-has_one_attached:item-image

## gives table
|Column |Type |Options|
|-------|-----|-------|
|sender_id|references|null: false, foreign_key|
|receiver_id|references|null: false, foreign_key|
|item_id|references| null: false, foreign_key|

##Association
-belongs_to:sender,class_name:'User'
-belongs_to:receiver,class_name:'User'
-belongs_to:item


## takes table
|Column |Type |Options|
|-------|-----|-------|
|receiver_id|references|null: false, foreign_key|
|item_id|references| null: false, foreign_key|

##Association
-belongs_to:receiver,class_name:'User'
-belongs_to:item
-has_one: address

## addresses table
|Column |Type |Options|
|-------|-----|-------|
|postcode|string|null:false|
|local|string|null:false|
|house_number|string|null:false|
|building|string|
|phone_number|integer|null:false|
|buyer|references|null: false, foreign_key|
|region_id|integer|null:false|

##Association
-belongs_to :take

