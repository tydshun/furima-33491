# README

## users

| Column      | Type        | Option     |
| ------------|-------------|------------|
| nickname    | string      | null:false |
| email       | string      | null:false |
| password    | string      | null:false |
| first_name  | string      | null:false |
| family_name | string      | null:false |
| read_first  | string      | null:false |
| read_family | string      | null:false |
| birth_id    | integer     | null:false |

### Association

- has_many :items
- has_many :purchases

## items

| Column              | Type       | Option                       |
|---------------------|------------|------------------------------|
| item_name           | string     | null:false                   |
| explanation         | text       | null:false                   |
| category_id         | integer    | null:false                   | 
| condition_id        | integer    | null:false                   |
| postage_type_id     | integer    | null:false                   |
| prefectures_id      | integer    | null:false                   |
| preparation_days_id | integer    | null:false                   |
| price               | integer    | null:false                   |
| user                | references | null:false,foreign_key: true |
| purchase_info       | references | null:false,foreign_key: true |

### Association

- belongs_to :user
- has_one :purchases

## purchases

| Column | Type       | Option                       |
|--------|------------|------------------------------|
| user   | references | null:false,foreign_key: true |
| item   | references | null:false,foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shopping

## shoppings

| Column         | Type       | Option                       |
|----------------|------------|------------------------------|
| postal_code    | integer    | null:false                   |
| prefectures_id | string     | null:false                   |
| city           | integer    | null:false                   |
| address        | integer    | null:false                   |
| building_name  | integer    | null:false                   |
| phone_number   | string     | null:false                   |
| purchases      | references | null:false,foreign_key: true |

### Association
- belongs_to :purchase