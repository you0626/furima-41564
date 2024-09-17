# テーブル設計

## users テーブル

| Column               | Type     | Options                  |
| -------------------- | -------- | ------------------------ |
| nickname             | string   | null: false              |
| email                | string   | null: false, unique:true |
| encrypted_password   | string   | null: false              |
| first_name           | string   | null: false              |
| last_name            | string   | null: false              |
| first_name_katakana  | string   | null: false              |
| last_name_katakana   | string   | null: false              |
| year_id              | integer  | null: false              |
| month_id             | integer  | null: false              |
| day_id               | integer  | null: false              |

### Association

- has_many :items
- belongs_to :order


## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| explanation | text       | null: false                    |
| category_id | integer    | null: false                    |
| state_id    | integer    | null: false                    |
| spirit_id   | integer    | null: false                    |
| region_id   | integer    | null: false                    |
| days_id     | integer    | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column           | Type       | Options                        |
| ---------------- | -----------| ------------------------------ |
| postal_code      | integer    | null: false                    |
| prefectures_id   | integer    | null: false                    |
| municipality     | text       | null: false                    |
| lot_number       | text       | null: false                    |
| building_name    | text       |                                |
| telephone_number | integer    | null: false                    |
| item             | references | null: false, foreign_key: true |

### Association

- has_one :user
- belongs_to :items
