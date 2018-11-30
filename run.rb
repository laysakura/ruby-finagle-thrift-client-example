$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'gen-rb'))
require 'thrift_client'
require 'finagle-thrift'
require 'hello_service'

SERVER = 'localhost:9999'
CLIENT_NAME = 'ruby-finagle-thrift-client-example'

# HelloServiceのクライアント作成
client = ::ThriftClient.new(::Laysakura::Idl::HelloService::Client, SERVER)

# Tracingの有効化
#
## https://zipkin.io/pages/instrumenting.html の "Endpoint" を設定。
##
## このように設定しないと、 https://github.com/twitter/finagle/blob/version-6.40.0/finagle-thrift/src/main/ruby/lib/finagle-thrift/trace.rb#L145 のように
## gethostname(3) の結果を名前解決しようとするが、名前解決できない名前が取得されるとThrift API callが例外で失敗する。
::Trace.default_endpoint = ::Trace::Endpoint.new(::Trace::Endpoint.host_to_i32('127.0.0.1'), 0, CLIENT_NAME)
::FinagleThrift.enable_tracing!(client, ::FinagleThrift::ClientId.new(name: CLIENT_NAME))

# HelloServiceのサーバ側の sayHelloTo() APIを叩く
begin
  resp = client.sayHelloTo('John')
ensure
  client.disconnect!
end

puts "Response: '#{resp}'"
puts "TraceId: #{::Trace.id.trace_id.to_s}"
