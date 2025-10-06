# APIキー・トークン取得手順書

この手順書は、n8nでよく使う外部サービス（Gemini API, Slack, Fal ai）のAPIキーやトークンを、非エンジニアの方でも迷わず取得できるようにまとめたものです。

---

## 1. Gemini API（Google Gemini）APIキーの取得方法

1. [Google AI Studio](https://aistudio.google.com/app/apikey) にアクセス
2. Googleアカウントでログイン
3. 「API キーを作成」ボタンをクリック
4. 表示されたAPIキーをコピー
### n8n画面説明
<img width="406" height="231" alt="スクリーンショット 2025-09-08 12 11 45" src="https://github.com/user-attachments/assets/d5ed6a4f-b54e-4cf3-afa9-b4e5c5e7ee8b" />
<img width="700" height="401" alt="スクリーンショット 2025-09-08 12 28 14" src="https://github.com/user-attachments/assets/8eebf2e0-9f63-4504-a424-e02b47f2a993" />



---

## 2. Slack Bot Token の取得方法

1. [Slack API: Your Apps](https://api.slack.com/apps) にアクセス
2. 「Create New App」→「From scratch」を選択
3. App Name（任意）とワークスペースを選択し「Create App」
4. 左メニュー「OAuth & Permissions」→「Scopes」で必要な権限（chat:write など）を追加
5. ページ上部「Install to Workspace」→「許可する」
6. 「Bot User OAuth Token」（`xoxb-...`で始まる）をコピー
### n8n画面説明
<img width="406" height="231" alt="スクリーンショット 2025-09-08 12 31 47" src="https://github.com/user-attachments/assets/c5c25654-fbd4-405b-996b-89a590c18ee5" />
<img width="700" height="400" alt="スクリーンショット 2025-09-08 12 31 30" src="https://github.com/user-attachments/assets/9b29970c-c177-496d-bb44-937df27000c0" />

---

## 3. Fal ai API Key の取得方法(他のHTTPRequestも同じやり方)

1. [Fal ai](https://fal.ai/) にアクセス
2. 右上の「Sign in」からアカウント作成またはログイン
3. ログイン後、ダッシュボードの「API Keys」セクションへ
4. 「Create API Key」ボタンで新規キーを発行
5. 表示されたAPIキーをコピー
### n8n画面説明
<img width="400" height="581" alt="スクリーンショット 2025-09-08 12 32 07" src="https://github.com/user-attachments/assets/862a86f4-77ce-4a7e-b91e-360125050e24" />
<img width="1215" height="712" alt="スクリーンショット 2025-09-08 12 32 47" src="https://github.com/user-attachments/assets/0f771d6e-c98e-43c1-b90f-e688a794a262" />
*名前に[Authorization]と入力する必要がある
*値は最初に[Key ]と入力しAPI_Keyを貼り付ける

---

## 注意事項
- APIキーやトークンは**絶対に他人に教えない**でください。
- 万が一流出した場合は、各サービスの管理画面から「無効化」や「再発行」を行ってください。
- n8nの認証情報（Credential）画面で「新規作成」し、該当する項目に貼り付けてください。

---

## サポート
取得方法が分からない場合や、うまくいかない場合は管理者またはサポート担当までご連絡ください。
