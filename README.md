# README

# users

| Column               | Type       | Option                 |
|----------------------|------------|------------------------|
|nickname              |string      |null:false              |
|email                 |string      |null:false              |
|password              |string      |null:false              |
|first_name            |string      |null:false              |
|family_name           |string      |null:false              |
|read_first            |string      |null:false              |
|read_family           |string      |null:false              |
|birth_year_id         |integer     |null:false              |
|birth_month_id        |integer     |null:false              |
|birth_day_id          |integer     |null:false              |

### Association

- has_many :items
- has_many :purchase_info

## items

| Column               | TYpe       | Option                     |
|----------------------|------------|----------------------------|
|item_name             |string      |null:false                  |
|explanation           |text        |null:false                  |
|category_id           |integer     |null:false                  | 
|condition_id          |integer     |null:false                  |
|postage_type_id       |integer     |null:false                  |
|prefectures_id        |integer     |null:false                  |
|preparation_days_id   |integer     |null:false                  |
|price                 |integer     |null:false                  |
|user                  |references  |null:false,foreign_key: true|
|purchase_info         |references  |null:false,foreign_key: true|

### Association

- has_one :purchase_info
- belongs_to :user

## purchase_info

| Column               | Type       | Option                     |
|----------------------|------------|----------------------------|
|user                  |references  |null:false,foreign_key: true|
|item                  |references  |null:false,foreign_key: true|

### Association
- has_one :shopping_address
- belongs_to :item
- belongs_to :user

## shopping_address

| Column               | Type       | Option                     |
|----------------------|------------|----------------------------|
|postal_code           |integer     |null:false                  |
|prefectures_id        |string      |null:false                  |
|city                  |integer     |null:false                  |
|address               |integer     |null:false                  |
|building_name         |integer     |null:false                  |
|phone_number          |string      |null:false                  |
|purchase_info         |references  |null:false,foreign_key: true|

### Association
belongs_to :purchase_info