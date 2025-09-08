# n8n_MCP プロジェクト概要

## プロジェクトの目的

このプロジェクトは、ワークフロー自動化ツール「n8n」をローカル環境で簡単に立ち上げ、独自のワークフロー（例: GoogleアラートやSlackコマンド連携など）を一括または個別でインポート・管理できるようにするためのものです。

- n8nのDocker環境を素早く構築
- `WorkFlow`ディレクトリ内の複数ワークフロー（JSONファイル）を一括または個別でインポート
- インポート作業を自動化するシェルスクリプト付き

---

### インストール
``` sh
git clone https://github.com/Umeno-koudai/n8n.git
```
### n8nの起動
```sh
npm run start
```
- これにより、Dockerでn8nがバックグラウンド起動
- n8nのWeb UIは http://localhost:5678 でアクセスできます。
- 起動したら[email, UserName, Password]を入力する必要がありその後ワークフローのインポートを行います。

### ワークフローをインポート
```sh
//workflowディレクトリ内のワークフロー全てをインポート
npm run import
```
```sh
//指定したファイルだけインポート
npm run import ファイル名.json
```
この場合、`WorkFlow/GoogleAlert.json` だけがインポートされます。

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
  - `import_workflows.sh` を実行し、`WorkFlow`ディレクトリ内のワークフローをn8nに一括または個別インポート
- `db_reset` :
  - `docker-compose down -v` で全データを削除し、`docker-compose up -d` で再起動

---

## 主要ファイルの説明

- `docker-compose.yaml` : n8nのDocker構成ファイル。永続化やワークフローのマウント設定済み。
- `import_workflows.sh` : ワークフロー一括・個別インポート用スクリプト。Dockerコンテナ内でn8n CLIを使い、`WorkFlow`ディレクトリの全JSONファイルまたは指定ファイルをインポートします。
- `WorkFlow/` : インポートしたいワークフロー（JSON形式）を格納するディレクトリ。
- `package.json` : npmスクリプトやプロジェクト情報を管理。

---

## 注意事項
- 初回起動時やワークフローインポート後は、n8nのUI上で認証情報（Credentials）の再設定が必要な場合があります。
- `N8N_ENCRYPTION_KEY` などの環境変数はセキュリティのため適切に管理してください。
- local環境でwebhookを使用する場合localhostのままではエンドポイントを呼び出せないそのためngrokというツールを使用して一時的にネット上にエンドポイントを登録する必要がある
- [brewでngrokをインストール](https://zenn.dev/u2dncx/articles/3fa29c8a3d63b6)
- ``` sh
  ngrok http 5678
  ```
- 上記コマンドを入力したらlocalhostを置き換えるURLを作成してくれるのでエンドポイントのlocalhost:5678~を置き換える
  - 下の例だったらlocalhost:5678 -> 7c2c29258eef.ngrok-free.appに置き換える
- ただし、ngrokを閉じてしまうと毎回URLが変わるのでエンドポイントもその都度修正が必要(固定できるがお金がかかる) 
- <img width="682" height="222" alt="スクリーンショット 2025-09-06 23 00 09" src="https://github.com/user-attachments/assets/ab943341-f9ca-40cd-99fc-282e134334b1" />

---

## 参考リンク
- [n8n公式ドキュメント](https://docs.n8n.io/)
- [n8n CLIコマンド](https://docs.n8n.io/hosting/cli-commands/#import-workflows-and-credentials)
