# 書籍『RustによるWebアプリケーション開発』の第３章 最小構成アプリケーションの実装
## プロジェクトの作成
```
cargo new rust-book-manager
```

## 必要なファイルのコピー
```
cp ../helloworld/Dockerfile ./
cp ../helloworld/Makefile.toml ./
cp ../helloworld/compose.yaml ./
```

## 開発に必要なライブラリの追加
```
cargo add axum@0.7.5 --features macros
cargo add tokio@1.37.0 --features full
cargo add rstest@0.18.2 --dev
```

## 実行
```
cargo run
or
cargo make run
```
## 動作確認
```
curl localhost:8080/hello -v
* Host localhost:8080 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:8080...
* connect to ::1 port 8080 from ::1 port 57943 failed: Connection refused
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080
> GET /hello HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/8.7.1
> Accept: */*
>
* Request completely sent off
< HTTP/1.1 200 OK
< content-type: text/plain; charset=utf-8
< content-length: 14
< date: Tue, 15 Oct 2024 23:05:43 GMT
<
Hello, world!
* Connection #0 to host localhost left intact
```

## anyhowクレートの追加
```
cargo add anyhow@1.0.75
```

## cargo-nextestクレートの追加
```
cargo add cargo-nextest
```

## ユニットテスト実行
```
cargo make test
[cargo-make] INFO - cargo make 0.37.21
[cargo-make] INFO - Calling cargo metadata to extract project info
[cargo-make] INFO - Cargo metadata done
[cargo-make] INFO - Project: rust-book-manager
[cargo-make] INFO - Build File: Makefile.toml
[cargo-make] INFO - Task: test
[cargo-make] INFO - Profile: development
[cargo-make] INFO - Execute Command: "cargo" "nextest" "run" "--workspace" "--status-level" "all" "--test-threads=1"
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.24s
------------
 Nextest run ID ae54cc3d-4b38-47ea-8723-38b2b8dd556e with nextest profile: default
    Starting 1 test across 1 binary
        PASS [   0.007s] rust-book-manager::bin/rust-book-manager health_check_works
------------
     Summary [   0.007s] 1 test run: 1 passed, 0 skipped
[cargo-make] INFO - Build Done in 1.64 seconds.

or

cargo nextest run
    Finished `test` profile [unoptimized + debuginfo] target(s) in 0.14s
------------
 Nextest run ID 18bddc59-ab3a-4208-96d5-8312076fc8ef with nextest profile: default
    Starting 1 test across 1 binary
        PASS [   0.007s] rust-book-manager::bin/rust-book-manager health_check_works
------------
     Summary [   0.007s] 1 test run: 1 passed, 0 skipped
```

## sqlxクレートの導入
```
cargo add sqlx@0.7.3 --features runtime-tokio,uuid,chrono,macros,postgres,migrate
```

## テスト実行（3.5.3 ユニットテストを書く）
```
cargo make before-build
cargo make test
```

## 動作確認（3.5.４ 動作確認する）
```
cargo make run
curl localhost:8080/health/db -v
```

## 動作確認（3.5.４ 動作確認する）
```
cargo make compose-down
curl localhost:8080/health/db -v
```



以上