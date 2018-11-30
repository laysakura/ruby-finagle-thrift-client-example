# ruby-finagle-thrift-client-example

finagle-thrift を使ったRPCクライアントのRuby最小（当社比）実装。

（QiitaのURL）の記事で触れているサンプルコード。

## 実行方法

### Thrift定義からクライアントコードを生成
```bash
$ brew install thrift

$ thrift --version
Thrift version 0.11.0

$ thrift --gen rb hello_service.thrift

$ ls gen-rb
hello_service.rb  hello_service_constants.rb  hello_service_types.rb
```

### クライアント実行
finagle-thrift に対応したサーバは利用可能な前提。

接続情報は `run.rb` を直接変更すること。

```bash
$ bundle install --path=vendor/bundle

$ bundle exec ruby run.rb
Response: 'Hello, John'
TraceId: 9549be5ecbfacc56
```
