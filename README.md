# MurderMysteryTimer マーダーミステリータイマー

ボードゲームのマーダーミステリーの進捗、時間を管理するアプリです

# スクリーンショット

<img width="375" alt="1" src="https://github.com/user-attachments/assets/cac3ae30-b9e9-4090-9479-eb6ae8d362e5" />

<img width="375" alt="2" src="https://github.com/user-attachments/assets/3e03f57f-a157-45ac-9bf5-b5397c7fa9db" />

<img width="375" alt="3" src="https://github.com/user-attachments/assets/9975116a-e618-42b2-8a98-35eec5825493" />

@ -0,0 +1,74 @@
# タイトル
MurderMysteryTimer — マーダーミステリー用シナリオタイマー

## 概要
- マーダーミステリー（人狼/推理系）などの進行に使える、シナリオベースのタイマーアプリ。
- フェーズ（導入/議論/推理/エピローグなど）をシナリオとして管理し、順次カウントダウン。
- サンプルデータが同梱され、起動直後から使い始められます。

## 主な機能
- タブ構成のUI（メイン / シナリオ / タイマー）。
- シナリオの一覧表示・追加・更新・削除。
- フェーズ（時間/説明）の編集と順次再生。
- 合計時間の自動計算。
- ローカル永続化（UserDefaults + JSONエンコード）。

## 画面構成
- メイン: シナリオを選んでスタート。進行中の残り時間を表示。
- シナリオ: シナリオ一覧と編集。フェーズの追加/削除/並び替え（対応している場合）。
- タイマー: シンプルな単発タイマー（個別の計測に便利）。

## 技術スタック
- Swift 5.x / SwiftUI
- iOS（Xcode 15 以降を想定。実際の最小対応はプロジェクト設定に準拠）
- 状態管理: ObservableObject / @Published
- データ保存: UserDefaults + JSON (Codable)
- テスト: XCTest（UI テスト含む）

## プロジェクト構成（抜粋）
- MurderMysteryTimerApp.swift: アプリエントリポイント。
- ContentView.swift: タブベースのルートビュー。
- ScenarioDataManager.swift: シナリオの永続化と操作を担うデータ管理。
- 各種 View: MainView / ScenarioListView / SimpleTimerView など（UI）。
- テスト: MurderMysteryTimerUITests ほか。

## セットアップ
1. このリポジトリをクローン。
2. Xcode でプロジェクトを開く（MurderMysteryTimer.xcodeproj または .xcworkspace）。
3. 実機またはシミュレータを選択してビルド & 実行。

## 使い方（基本フロー）
1. 「シナリオ」タブで、既存のサンプルを参照するか、新規作成します。
2. フェーズ（名称 / 秒数 / 説明 など）を設定します。
3. 「メイン」タブでシナリオを選択し、再生を開始します。
4. フェーズが順次カウントダウンされ、全フェーズ完了で終了します。

## データ保存について
- シナリオは UserDefaults に JSON 形式で保存されます。
- 端末内のみで完結するため、アンインストールでデータは消去されます。
- 「サンプルデータへリセット」等の機能がある場合、ScenarioDataManager の `resetToSampleData()` を利用しています。

## 今後のロードマップ（例）
- 通知・アラーム音の追加。
- フェーズ毎の効果音/カラーリング。
- iCloud 同期や共有機能。
- 並び替え・複製などの編集体験の向上。
- アクセシビリティとダイナミックタイプの最適化。
