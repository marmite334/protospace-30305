# テーブル設計

## usersテーブル

| Column      | Type   | Options    |
|-------------|--------|------------|
| email       | string | null:false |
| password    | string | null:false |
| name        | string | null:false |
| profile     | text   | null:false |
| occupation  | text   | null:false |
| position    | text   | null:false |

### Association
_ has_many :prototypes
_ has_many :comments

## prototypesテーブル

| Column     | Type       | Options    |
|------------|------------|------------|
| title      | string     | null:false |
| catch_copy | text       | null:false |
| concept    | text       | null:false |
| user       | references |            |

### Association
_ belongs_to :users
_ has_many   :comments

## commentsテーブル

| Column     | Type       | Options    |
|------------|------------|------------|
| text       | text       | null:false |
| user       | references |            |
| prototype  | references |            |

### Association
_ belongs_to :users
_ belongs_to :prototypes

