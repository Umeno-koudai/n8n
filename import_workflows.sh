#!/bin/bash

# n8n ワークフロー CLI インポート スクリプト (最小機能版)
# 目的:
#   ./WorkFlow ディレクトリに置いた複数の *.json ワークフローを
#   稼働中 Docker コンテナ内で n8n CLI を使って一括インポートする。
# 参照: https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials
#   n8n import:workflow --input <path> [--separate] [--overwrite]
#
# 段階的拡張を想定した最初の最小バージョン:
#   - コンテナ稼働確認
#   - ディレクトリ存在/JSONファイル存在確認
#   - ディレクトリをまとめて --separate 付きでインポート
#   - オプション: -o で --overwrite 指定
#   - ログ表示
# 後続発展案 (未実装): 個別結果集計, dry-run, credential import, バージョン管理, 差分検出 など

set -euo pipefail  # 厳格モード
IFS=$'\n\t'

# カラー出力の設定
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 設定
WORKFLOW_DIR=${WORKFLOW_DIR:-"./workflow"}
CONTAINER_NAME=${N8N_CONTAINER_NAME:-"n8n_local"}
OVERWRITE=false

usage() {
    cat <<EOF
Usage: $(basename "$0") [options]

Options:
    -o, --overwrite  既存ワークフローを上書き (--overwrite)
    -h, --help       このヘルプを表示

Env Vars:
    WORKFLOW_DIR          デフォルト: ./workflow
    N8N_CONTAINER_NAME    デフォルト: n8n_local
EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -o|--overwrite)
                OVERWRITE=true; shift ;;
            -h|--help)
                usage; exit 0 ;;
            *)
                log_warning "未対応の引数: $1"; usage; exit 1 ;;
        esac
    done
}

# ログ関数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# dockerコンテナの稼働確認
check_docker_container() {
    log_info "n8nコンテナ(${CONTAINER_NAME})の稼働確認..."
    if ! docker ps --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"; then
        log_error "コンテナが起動していません: $CONTAINER_NAME"
        log_error "起動例: docker compose up -d  (または docker-compose up -d)"
        exit 1
    fi
    log_success "コンテナ稼働中"
}

# ワークフローディレクトリの確認
check_workflow_directory() {
    log_info "ワークフローディレクトリ確認: $WORKFLOW_DIR"
    if [[ ! -d "$WORKFLOW_DIR" ]]; then
        log_error "ディレクトリが存在しません: $WORKFLOW_DIR"
        exit 1
    fi
    local json_count
    json_count=$(find "$WORKFLOW_DIR" -maxdepth 1 -type f -name '*.json' | wc -l | tr -d ' ')
    if [[ "$json_count" -eq 0 ]]; then
        log_error "*.json がありません。"; exit 1
    fi
    log_success "${json_count} 個のJSONファイルを検出"
}

# ワークフローファイルをコンテナにコピー
import_workflows_cli() {
    log_info "n8n CLI によるインポート開始"

    # read-only マウント (docker-compose.yaml で ./WorkFlow:/workflows:ro) を想定
    local input_path="/workflows"
    local cmd=(docker exec "$CONTAINER_NAME" n8n import:workflow --input "$input_path" --separate)
    if $OVERWRITE; then
        cmd+=(--overwrite)
    fi

    log_info "実行コマンド: ${cmd[*]}"
    if "${cmd[@]}"; then
        log_success "インポート完了"
    else
        log_error "インポートに失敗しました"; exit 1
    fi
}

# インポート手順の表示
summary_message() {
    log_info "=== インポート概要 ==="
    echo "ソースディレクトリ : $WORKFLOW_DIR"
    echo "コンテナ            : $CONTAINER_NAME"
    echo "上書きモード        : $OVERWRITE"
    echo "n8n URL             : http://localhost:5678"
    log_warning "必要に応じて Credentials を UI で再設定してください"
}

# メイン処理
main() {
    parse_args "$@"
    log_info "n8n ワークフロー CLI インポート開始"
    check_docker_container
    check_workflow_directory
    import_workflows_cli
    summary_message
}

main "$@"
