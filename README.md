# Prepare
```
$ gem install grpc
$ gem install grpc-tools
$ grpc_tools_ruby_protoc -I . --ruby_out=./lib --grpc_out=./lib ./auth.proto
```

