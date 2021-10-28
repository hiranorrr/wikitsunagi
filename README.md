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
### 環境変数に自分のipアドレスを追加する方法
.zshrcやら.bashrcやらに以下を追記
```
$ export LOCAL_HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | sed -E "s/inet ([0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}) .*$/\1/" | tr -d "\t"`
$ source .zshrc
```
以下のコマンドを実行すると自分のipアドレスが出力されることを確認する
```
echo $LOCAL_HOST_IP
```


