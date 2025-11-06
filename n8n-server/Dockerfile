# n8nのベースイメージを使用
FROM n8nio/n8n:latest

# FFmpegと日本語フォント、フォント管理ツールをインストール
USER root

# パッケージリストを更新し、FFmpeg、日本語フォント、fontconfigをインストール
RUN apk update && \
    apk add --no-cache \
        ffmpeg \
        font-noto-cjk \
        fontconfig \
        libstdc++ && \
    rm -rf /var/cache/apk/*

# ユーザーを元に戻す（セキュリティ上の理由）
USER node