# Range Bar パッケージ仕様書

## 概要

`range_bar`は、単一のバー上に複数の範囲（レンジ）を可視化できる Flutter ウィジェットパッケージです。データの範囲や期間、進捗状況など、様々な用途で使用できる柔軟なコンポーネントを提供します。

## 主要機能

### 1. 基本機能

- **複数範囲表示**: 1 つのバー上に複数の範囲セグメントを表示
- **カスタマイズ可能な外観**: 色、サイズ、角丸などの細かなカスタマイズ
- **レスポンシブ対応**: 異なる画面サイズに対応
- **2 つのコンポーネント**: 静的な `RangeBar` とアニメーション対応の `AnimatedRangeBar`

### 2. 範囲（Range）の定義

各範囲は以下の属性を持ちます：

- `startPosition`: 開始位置（0.0〜1.0 の範囲、左端からの正規化された座標）
- `endPosition`: 終了位置（0.0〜1.0 の範囲、左端からの正規化された座標）
- `color`: 範囲の色
- `label`: 範囲のラベル（オプション、カスタムテキスト用）
- `startValueLabel`: 開始位置に表示する値ラベル（オプション、数値表示用）
- `endValueLabel`: 終了位置に表示する値ラベル（オプション、数値表示用）
- `labelStyle`: ラベルのテキストスタイル（オプション、個別設定用）
- `valueLabelStyle`: 値ラベルのテキストスタイル（オプション、個別設定用）

### 3. カスタマイズオプション

#### バー全体

- `height`: バーの高さ（デフォルト: 20.0）
- `borderRadius`: 角丸の設定
- `backgroundColor`: 背景色
- `border`: ボーダーの設定

#### 範囲セグメント

- `ranges`: 表示する範囲のリスト（必須、空リストの場合は何も表示しない）
- `showLabels`: ラベル表示のオン/オフ（デフォルト: false）
- `showStartValueLabels`: 開始値ラベル表示のオン/オフ（デフォルト: false）
- `showEndValueLabels`: 終了値ラベル表示のオン/オフ（デフォルト: false）
- `defaultLabelStyle`: デフォルトのラベルテキストスタイル（オプション）
- `defaultValueLabelStyle`: デフォルトの値ラベルテキストスタイル（オプション）
- `labelPosition`: ラベルの位置（デフォルト: `LabelPosition.above`）
- `valueLabelFormatter`: 値ラベルのフォーマット関数（デフォルト: `(value) => value?.toString() ?? ''`）
- `valueLabelOverlapBehavior`: 値ラベル重複時の動作（デフォルト: `hide`）
- `overlapThreshold`: 重複判定の閾値（デフォルト: 0.03、つまり 3%）

#### インタラクション

- `onRangeTap`: 範囲タップ時のコールバック
- `onRangeHover`: 範囲ホバー時のコールバック（Web/Desktop）
- `tooltip`: ツールチップの表示

## 使用例

### RangeBar（静的） - 基本的な使用例

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.3,
      color: Colors.red,
      label: 'Phase 1',
      startValueLabel: 0.0,
      endValueLabel: 30.0,
    ),
    RangeData(
      startPosition: 0.3,
      endPosition: 0.7,
      color: Colors.blue,
      label: 'Phase 2',
      startValueLabel: 30.0,
      endValueLabel: 70.0,
    ),
    RangeData(
      startPosition: 0.7,
      endPosition: 1.0,
      color: Colors.green,
      label: 'Phase 3',
      startValueLabel: 70.0,
      endValueLabel: 100.0,
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
  valueLabelFormatter: (value) => '${value?.toInt()}%',
  // デフォルトの重複回避（3%以下で両方非表示）
)
```

### 重複回避の具体例

```dart
// 狭い範囲での重複回避例
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.4,
      endPosition: 0.41,  // 1%の狭い範囲
      color: Colors.red,
      startValueLabel: 40.0,
      endValueLabel: 41.0,
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
  // デフォルトでは両方のラベルが非表示になる（3%以下のため）
)
```

### 重複を許容する例

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.4,
      endPosition: 0.41,
      color: Colors.red,
      startValueLabel: 40.0,
      endValueLabel: 41.0,
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
  valueLabelOverlapBehavior: ValueLabelOverlapBehavior.showBoth,
  // 重複を許容して両方のラベルを表示
)
```

### RangeBar（静的） - カスタマイズされた使用例

```dart
RangeBar(
  height: 30.0,
  borderRadius: BorderRadius.circular(15.0),
  backgroundColor: Colors.grey[200],
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.4,
      color: Colors.orange,
      label: 'In Progress',
      startValueLabel: 0.0,
      endValueLabel: 40.0,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.orange[800],
      ),
      valueLabelStyle: TextStyle(
        fontSize: 12,
        color: Colors.orange[600],
      ),
    ),
    RangeData(
      startPosition: 0.6,
      endPosition: 0.9,
      color: Colors.purple,
      label: 'Review',
      startValueLabel: 60.0,
      endValueLabel: 90.0,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.purple[800],
      ),
      valueLabelStyle: TextStyle(
        fontSize: 12,
        color: Colors.purple[600],
      ),
    ),
  ],
  showLabels: true,
  showStartValueLabels: true,
  showEndValueLabels: true,
  labelPosition: LabelPosition.above,
  valueLabelFormatter: (value) => '${value?.toStringAsFixed(1)}%',
  valueLabelOverlapBehavior: ValueLabelOverlapBehavior.hideStart,
  overlapThreshold: 0.05, // 5%以下の場合は重複とみなす
  onRangeTap: (range) {
    print('Tapped: ${range.label} - Start: ${range.startValueLabel}, End: ${range.endValueLabel}');
  },
)
```

### AnimatedRangeBar - アニメーション対応使用例

```dart
class _MyWidgetState extends State<MyWidget> {
  List<RangeData> _ranges = [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.3,
      color: Colors.red,
      label: 'Sales',
      startValueLabel: 0.0,
      endValueLabel: 25.5,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    RangeData(
      startPosition: 0.3,
      endPosition: 0.7,
      color: Colors.blue,
      label: 'Marketing',
      startValueLabel: 25.5,
      endValueLabel: 70.7,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    RangeData(
      startPosition: 0.7,
      endPosition: 1.0,
      color: Colors.green,
      label: 'Development',
      startValueLabel: 70.7,
      endValueLabel: 100.0,
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  ];

  void _updateRanges() {
    setState(() {
      _ranges = [
        RangeData(
          startPosition: 0.0,
          endPosition: 0.6,
          color: Colors.red,
          label: 'Sales',
          startValueLabel: 0.0,
          endValueLabel: 60.0,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        RangeData(
          startPosition: 0.6,
          endPosition: 1.0,
          color: Colors.blue,
          label: 'Marketing',
          startValueLabel: 60.0,
          endValueLabel: 100.0,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedRangeBar(
          ranges: _ranges,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          showLabels: true,
          showStartValueLabels: false,
          showEndValueLabels: true,
          valueLabelFormatter: (value) => '${value?.toStringAsFixed(1)}%',
        ),
        ElevatedButton(
          onPressed: _updateRanges,
          child: Text('Update Ranges'),
        ),
      ],
    );
  }
}
```

## データモデル

### RangeData クラス

```dart
class RangeData {
  final double startPosition;       // 0.0 - 1.0 (正規化された座標)
  final double endPosition;         // 0.0 - 1.0 (正規化された座標)
  final Color color;
  final String? label;              // カスタムラベル
  final double? startValueLabel;    // 開始位置に表示する値ラベル
  final double? endValueLabel;      // 終了位置に表示する値ラベル
  final TextStyle? labelStyle;      // ラベルのテキストスタイル
  final TextStyle? valueLabelStyle; // 値ラベルのテキストスタイル
  final dynamic data;               // 追加データ用

  const RangeData({
    required this.startPosition,
    required this.endPosition,
    required this.color,
    this.label,
    this.startValueLabel,
    this.endValueLabel,
    this.labelStyle,
    this.valueLabelStyle,
    this.data,
  }) : assert(startPosition >= 0.0 && startPosition <= 1.0,
              'startPosition must be between 0.0 and 1.0'),
       assert(endPosition >= 0.0 && endPosition <= 1.0,
              'endPosition must be between 0.0 and 1.0'),
       assert(startPosition <= endPosition,
              'startPosition must be less than or equal to endPosition');

  /// 範囲の幅を取得
  double get width => endPosition - startPosition;

  /// 範囲が有効かどうかを判定
  bool get isValid => width > 0.0;

  /// デバッグ用の文字列表現
  @override
  String toString() => 'RangeData(start: $startPosition, end: $endPosition, '
                      'label: $label, width: ${width.toStringAsFixed(3)})';

  /// 等価比較
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RangeData &&
          runtimeType == other.runtimeType &&
          startPosition == other.startPosition &&
          endPosition == other.endPosition &&
          color == other.color &&
          label == other.label &&
          startValueLabel == other.startValueLabel &&
          endValueLabel == other.endValueLabel;

  @override
  int get hashCode => Object.hash(
    startPosition,
    endPosition,
    color,
    label,
    startValueLabel,
    endValueLabel,
  );
}
```

### LabelPosition 列挙型

```dart
enum LabelPosition {
  above,    // バーの上
  below,    // バーの下
  center,   // バーの中央
  none,     // ラベルなし
}
```

### ValueLabelOverlapBehavior 列挙型

```dart
enum ValueLabelOverlapBehavior {
  hide,           // 重複時は両方のラベルを非表示（デフォルト）
  hideStart,      // 重複時は開始ラベルのみ非表示
  hideEnd,        // 重複時は終了ラベルのみ非表示
  showBoth,       // 重複を許容して両方表示
  showOnlyEnd,    // 重複時は終了ラベルのみ表示
  showOnlyStart,  // 重複時は開始ラベルのみ表示
}
```

## 設計原則

### **1. 依存関係なし**

- Flutter の標準ライブラリのみを使用
- 外部パッケージへの依存は一切なし
- `flutter/material.dart` と `flutter/widgets.dart` のみ

### **2. ユーザーフレンドリー設計**

- **明確なデフォルト値**: 最小限の設定で使用可能
- **バリデーション**: 不正な値に対する適切なエラーハンドリング
- **一貫性**: Flutter の標準的な命名規則とパターンに従う
- **ドキュメント**: 豊富なコード例とドキュメント

### **3. パフォーマンス重視**

- **効率的な描画**: CustomPainter を使用した最適化された描画
- **メモリ効率**: 不要なオブジェクト生成を避ける
- **レイアウト最適化**: 親ウィジェットサイズに応じた効率的なレイアウト

### **4. 堅牢性**

- **境界値チェック**: 0.0-1.0 の範囲外値に対する適切な処理
- **null 安全**: 完全な null safety 対応
- **エッジケース対応**: 空リスト、重複範囲等の適切な処理

## コンポーネント設計

### RangeBar（基本コンポーネント）

静的な範囲バーを表示する StatelessWidget。親ウィジェットの幅に自動的にフィットし、アニメーションは含まず、パフォーマンスを重視。

**特徴**:

- StatelessWidget
- 親ウィジェットの幅に自動フィット
- 直接的な描画処理
- 軽量でパフォーマンス重視
- アニメーションなし

**主な用途**:

- 固定的なデータ表示
- リスト内での使用
- パフォーマンスが重要な場面
- レスポンシブレイアウト

### AnimatedRangeBar（アニメーション対応コンポーネント）

範囲の変更時にスムーズなアニメーションを提供する StatefulWidget。内部で RangeBar を使用。

**特徴**:

- StatefulWidget
- AnimationController を使用
- RangeBar をベースとして構築
- カスタマイズ可能なアニメーション

**追加パラメータ**:

- `duration`: アニメーション時間（デフォルト: 300ms）
- `curve`: アニメーションカーブ（デフォルト: Curves.easeInOut）
- `animateInitialDisplay`: 初期表示時のアニメーション有無（デフォルト: false）

**主な用途**:

- 動的なデータ更新がある場面
- ユーザーインタラクションに応じた変化
- 視覚的なフィードバックが重要な場面

## 技術要件

### Flutter/Dart バージョン

- Flutter: >= 1.17.0
- Dart: >= 3.9.0

### 依存関係

- flutter/material.dart（標準ライブラリのみ使用）

### プラットフォーム対応

- iOS
- Android
- Web
- Windows
- macOS
- Linux

## 実装計画

### Phase 1: 基本実装（RangeBar - 静的コンポーネント）

- [x] プロジェクト構成の確認
- [x] 仕様書の作成と設計原則の確立
- [x] コンポーネント設計の分離（RangeBar / AnimatedRangeBar）
- [x] gap パラメータの削除と設計の簡素化
- [ ] RangeData モデルクラスの実装（バリデーション付き）
- [ ] 基本的な RangeBar ウィジェットの実装
- [ ] CustomPainter による効率的な描画実装
- [ ] エラーハンドリングと境界値チェック

### Phase 2: 機能拡張（RangeBar）

- [ ] ラベル表示機能
- [ ] 値ラベル表示機能とフォーマッター
- [ ] 値ラベル重複回避ロジック
- [ ] インタラクション機能（タップ、ホバー）
- [ ] アクセシビリティ対応

### Phase 3: アニメーション実装（AnimatedRangeBar）

- [ ] AnimatedRangeBar コンポーネントの実装
- [ ] 範囲変更時のスムーズなアニメーション
- [ ] アニメーションパラメータのカスタマイズ

### Phase 4: 品質向上とテスト

- [ ] 包括的な単体テスト
- [ ] ウィジェットテスト
- [ ] パフォーマンステスト
- [ ] エッジケースのテスト
- [ ] ドキュメント生成とコード例の充実

### Phase 5: パッケージ公開準備

- [ ] API ドキュメントの完成
- [ ] サンプルアプリの作成
- [ ] README とチュートリアルの作成
- [ ] pub.dev 公開準備
- [ ] CI/CD 設定

### 将来のバージョン（v2.0 以降）

- [ ] 垂直方向バーの対応
- [ ] 高度なアニメーション効果
- [ ] テーマシステムの導入

## デザインガイドライン

### 視覚的階層

- 範囲は明確に区別できる色を使用
- ギャップがある場合は適切な余白を設ける
- ラベルは読みやすいコントラストを維持

### アクセシビリティ

- 色だけでなく、パターンやテクスチャでも区別可能
- 適切なセマンティクス情報を提供
- キーボードナビゲーション対応

### パフォーマンス

- 大量の範囲でも滑らかに描画
- 不要な再描画を避ける
- メモリ効率的な実装

## テストケース

### 単体テスト

- RangeData クラスのバリデーション
- 範囲の重複チェック
- 境界値テスト

### ウィジェットテスト

- 基本的な描画テスト
- 各カスタマイズオプションのテスト
- インタラクションテスト

### 統合テスト

- 実際のアプリでの動作確認
- 異なるプラットフォームでの動作確認

## 参考資料

### 類似パッケージの調査

- progress_bar 系パッケージとの差別化
- 既存の range picker 系パッケージとの比較

### デザインパターン

- Material Design ガイドライン
- Human Interface Guidelines
- 一般的なデータビジュアライゼーションパターン

---

_この仕様書は開発進行に合わせて更新されます。_
