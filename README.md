# n8n_MCP プロジェクト概要

## プロジェクトの目的
このプロジェクトは、ワークフロー自動化ツール「n8n」をローカル環境で簡単に立ち上げ、独自のワークフロー（例: GoogleアラートやSlackコマンド連携など）を一括でインポート・管理できるようにするためのものです。

- n8nのDocker環境を素早く構築
- `workflow`ディレクトリ内の複数ワークフロー（JSONファイル）を一括インポート
- インポート作業を自動化するシェルスクリプト付き

---


###  n8nの起動とワークフローの一括インポート
```sh
npm run start
```
- これにより、Dockerでn8nがバックグラウンド起動し、`workflow`ディレクトリ内の全ワークフローが一括インポートされます。
- n8nのWeb UIは http://localhost:5678 でアクセスできます。

#### 参考: n8nの停止・リセット
- n8nとデータベースを完全リセットしたい場合:
  ```sh
  npm run db_reset
  ```

---

## 各種スクリプトの説明（package.jsonより）

- `start` :
  - `docker-compose up -d` でn8nコンテナをバックグラウンド起動
  - その後 `npm run import` を実行
- `import` :
  - `import_workflows.sh` を実行し、`workflow`ディレクトリ内のワークフローをn8nに一括インポート
- `db_reset` :
  - `docker-compose down -v` で全データを削除し、`docker-compose up -d` で再起動

---

## 主要ファイルの説明

- `docker-compose.yaml` : n8nのDocker構成ファイル。永続化やワークフローのマウント設定済み。
- `import_workflows.sh` : ワークフロー一括インポート用スクリプト。Dockerコンテナ内でn8n CLIを使い、`workflow`ディレクトリの全JSONファイルをインポートします。
- `workflow/` : インポートしたいワークフロー（JSON形式）を格納するディレクトリ。
- `package.json` : npmスクリプトやプロジェクト情報を管理。

---

## 注意事項
- 初回起動時やワークフローインポート後は、n8nのUI上で認証情報（Credentials）の再設定が必要な場合があります。
- `N8N_ENCRYPTION_KEY` などの環境変数はセキュリティのため適切に管理してください。

---

## 参考リンク
- [n8n公式ドキュメント](https://docs.n8n.io/)
- [n8n CLIコマンド](https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials)
