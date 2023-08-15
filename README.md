# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


【Users Table】

| Type                | Column              | Options        | Description                             |
| ------------------- | ------------------- | -------------- | ----------------------------------------|
| integer             | id                  |                | ユーザーの一意の識別子                      |
| string              | nickname            | null:false     | ユーザーのニックネーム                      |
| string              | email               | null:false, unique:true     | ユーザーのメールアドレス       |
| string              | password            | null:false     | ユーザーのパスワード                       |
| string              | kanji_last_name     | null:false     | ユーザーの漢字表記の姓                      |
| string              | kanji_first_name    | null:false     | ユーザーの漢字表記の名                      |
| string              | kana_last_name      | null:false     | ユーザーのカナ表記の姓                      |
| string              | kana_first_name     | null:false     | ユーザーのカナ表記の名                      |
| date                | birthday_yyyy_mm_dd | null:false     | ユーザーの誕生日（年月日形式）               |

##Association
has_many: items
has_many: orders


【items Table】

| Type                 | Column              | Options        | Description                                  |
| -------------------  | ------------------- | ---------------------------------- | -------------------------|
| integer              | id                  |                                    | アイテムの一意の識別子       |
| string               | name                | null:false                         | アイテムの名前              |
| text                 | description         | null:false                         | アイテムの詳細説明           |
| integer              | category_id         | null:false                         | アイテムのカテゴリ           |
| integer              | condition_id        | null:false                         | アイテムの状態              |
| integer              | delivery_fee_type_id| null:false                         | 配送料のタイプ              |
| integer              | prefecture_id       | null:false                         | 都道府県                   |
| integer              | shipping_date_id    | null:false                         | 出荷予定日                 |
| integer              | price               | null:false                         | 価格                      |
| references           | user                | null:false,,foreign_key: true      | アイテムを登録したユーザーのID|   

##Association
belongs_to: user
has_one: order
-belongs_to_active_hash :category_id
-belongs_to_active_hash :condition_id
-belongs_to_active_hash :delivery_fee_type_id
-belongs_to_active_hash :prefecture_id
-belongs_to_active_hash :shipping_date_id



【Orders Table】

| Type                | Column              | Options                         | Description            |
| ------------------- | ------------------- | --------------------------------| -----------------------|
| integer             | id                  |                                 | 注文の一意の識別子        |
| references          | user                | null:false,foreign_key: true    | 注文を行ったユーザーのID   |
| references          | item                | null:false,foreign_key: true    | 注文されたアイテムのID     |

##Association
belongs_to: user
belongs_to: item
has_one: address


【Addresses Table】

| Type                | Column              | Options        | Description                             |
| ------------------- | ------------------- | -------------- | ----------------------------------------|
| integer             | id                  |                | 住所の一意の識別子                        |
| string              | postal_code         | null:false     | 郵便番号                                 |
| integer             | prefecture_id       | null:false     | 都道府県                                 |
| string              | city                | null:false     | 市区町村                                 |
| string              | house_num           | null:false     | 番地                                     |
| string              | building_name       |                | 建物名                                   |
| string              | phone_num           | null:false     | 電話番号                                 |
| references          | order               | null:false     | 注文に関連するID                          |

##Association
belongs_to: order
-has_one_active_hash :prefecture_id

