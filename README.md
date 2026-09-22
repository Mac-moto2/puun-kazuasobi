# ぷ〜ん！かずあそび

幼児むけの かずあそび。かを ぱちん！して、1つずつ かぞえます。

- 5ステージ × 3ラウンド（全15ラウンド／合計172匹）
- タップだけで あそべる。文字は 読めなくて よい（音声＋字幕）
- BGM 8曲・羽音・かぞえる声つき
- ⚙ 長押しで おとな用の 設定（こえ／おんがく／むずかしさ／とぶはやさ／さされたら／ステージ選択）

## 中身

```
index.html          ゲーム本体（これ1つで動く）
assets/img/*.png    キャラと背景 18枚
assets/audio/*.mp3  BGM 8曲
manifest.json       ホーム画面に追加したとき用
icon-192.png / icon-512.png
```

外部のサーバーや CDN を いっさい 使いません。広告・課金・外部リンク・アクセス解析も ありません。
静的ファイルだけなので、どの ホスティングでも そのまま 動きます。

## 公開のしかた（どれか1つ）

### A. GitHub Pages（ことばパトロールと おなじ やりかた・おすすめ）
Mac の ターミナルで:

```bash
cd /Users/afiri/Desktop/MulmoClaude
gh auth login                      # はじめてのときだけ
node scripts/deploy-puun.mjs       # ビルド → 検査 → リポジトリ作成 → push → Pages有効化
```
→ `https://Mac-moto2.github.io/puun-kazuasobi/` が できます。

ゲームを 直すたびに 自動で 公開しなおしたい ときは、見はり番として 起動:

```bash
node scripts/deploy-puun.mjs --watch
```

公開の まえに かならず 通しプレイの 検査が 走り、落ちたら 公開を 中止します。
（このフォルダの `deploy.sh` は gh だけで 済ませたい ときの 簡易版です）

### B. Netlify Drop（アカウント不要・いちばん かんたん）
https://app.netlify.com/drop を ひらいて、この `puun-kazuasobi` フォルダごと 画面に ドラッグ＆ドロップ。
数秒で URL が 出ます。

### C. Cloudflare Pages / Vercel
どちらも フォルダを ドラッグ＆ドロップするだけで 公開できます。

## iPad / iPhone で アプリのように あそぶ
公開した URL を Safari で ひらき、共有ボタン →「ホーム画面に追加」。
全画面で 起動して、アドレスバーも 出ません。

## 作り直すとき
ゲーム本体（`artifacts/html/2026/09/puun-kazuasobi.html`）を なおしたら:

```bash
python3 scripts/build_puun_web.py     # このフォルダを 作り直す
node scripts/puun_sim.mjs artifacts/deploy/puun-kazuasobi/index.html   # 動作確認
```
そのあと もう一度 `./deploy.sh`（または ドラッグ＆ドロップ）で 更新されます。

## 注意
- 公開すると URL を 知っている 人は だれでも あそべます。
- チェイス・スカイは 第三者の キャラクターです。家族で あそぶ ための ものとして、
  宣伝したり 検索に のせたり しない ほうが 安全です。
