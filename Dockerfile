# マルチステージビルドを使用し、Rustのプログラムをビルドする。
FROM rust:1.78-slim-bookworm AS builder
WORKDIR /app

ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

COPY . .
RUN cargo build --release

# 不要なソフトウエアを同梱する必要はないので、軽量なslim-bookwormを使用する。
FROM debian:bookworm-slim
WORKDIR /app

# ユーザを作成
RUN adduser book && chown -R book /app
USER book
COPY --from=builder ./app/target/release/app ./target/release/app

# 8080ポートでアプリケーションを起動する
ENV PORT 8080
EXPOSE ${PORT}
ENTRYPOINT [ "./target/release/app" ]
