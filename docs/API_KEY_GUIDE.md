# APIキー・トークン取得手順書

この手順書は、n8nでよく使う外部サービス（Gemini API, Slack, Fal ai）のAPIキーやトークンを、非エンジニアの方でも迷わず取得できるようにまとめたものです。

---

## 1. Gemini API（Google Gemini）APIキーの取得方法

1. [Google AI Studio](https://aistudio.google.com/app/apikey) にアクセス
2. Googleアカウントでログイン
3. 「API キーを作成」ボタンをクリック
4. 表示されたAPIキーをコピー
### n8n画面説明


---

## 2. Slack Bot Token の取得方法

1. [Slack API: Your Apps](https://api.slack.com/apps) にアクセス
2. 「Create New App」→「From scratch」を選択
3. App Name（任意）とワークスペースを選択し「Create App」
4. 左メニュー「OAuth & Permissions」→「Scopes」で必要な権限（chat:write など）を追加
5. ページ上部「Install to Workspace」→「許可する」
6. 「Bot User OAuth Token」（`xoxb-...`で始まる）をコピー
### n8n画面説明

---

## 3. Fal ai API Key の取得方法

1. [Fal ai](https://fal.ai/) にアクセス
2. 右上の「Sign in」からアカウント作成またはログイン
3. ログイン後、ダッシュボードの「API Keys」セクションへ
4. 「Create API Key」ボタンで新規キーを発行
5. 表示されたAPIキーをコピー
### n8n画面説明

---

## 注意事項
- APIキーやトークンは**絶対に他人に教えない**でください。
- 万が一流出した場合は、各サービスの管理画面から「無効化」や「再発行」を行ってください。
- n8nの認証情報（Credential）画面で「新規作成」し、該当する項目に貼り付けてください。

---

## サポート
取得方法が分からない場合や、うまくいかない場合は管理者またはサポート担当までご連絡ください。
