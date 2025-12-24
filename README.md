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

###Association
-has_many :items
-has_many :give
-has_many :take

-has_one_attached:user-image

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
|item|references| null: false, foreign_key|
|user|references|null: false, foreign_key|

###Association
-belongs_to :user
-belongs_to :item


## takes table
|Column |Type |Options|
|-------|-----|-------|
|item|references| null: false, foreign_key|
|user|references|null: false, foreign_key|

###Association
-belongs_to :user
-belongs_to :item
-has_one :address

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


