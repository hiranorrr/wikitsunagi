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
# wikitsunagi
### データベースの作成方法
+ モデルの作成(shell scriptか何かに追記したい)
```
$ docker-compose run --rm api rails generate scaffold Word content:text category:text
$ docker-compose run --rm api rails db:create
$ docker-compose run --rm api rails db:migrate
```
+ 元データを保存
    + publicディレクトリにdataを保存
+ データベースに登録
    + questionsコントローラのregisterを実行(routes.rbにてコメントアウトされているので適宜外す)
