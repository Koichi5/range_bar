# RangeBar

[![pub package](https://img.shields.io/pub/v/range_bar.svg)](https://pub.dev/packages/range_bar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A highly customizable Flutter widget for displaying multiple ranges on a single horizontal bar. Perfect for visualizing data segments, progress indicators, timelines, and more.

## ✨ Features

- **Multiple Range Display**: Show multiple overlapping or non-overlapping ranges
- **Flexible Value Labels**: Display start/end values with customizable formatting
- **Smart Overlap Handling**: 6 different behaviors for overlapping value labels
- **Precise Position Control**: Individual positioning for each value label
- **Interactive**: Tap and hover callbacks for user interaction
- **Accessible**: Built-in screen reader support and semantic information
- **Tooltips**: Rich tooltip support with custom builders
- **Performance Optimized**: Handles large datasets efficiently (100+ ranges)
- **Highly Customizable**: Colors, styles, borders, and more
- **Zero Dependencies**: No external package dependencies

## 🚀 Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  range_bar: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 📖 Basic Usage

```dart
import 'package:range_bar/range_bar.dart';

RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.3,
      color: Colors.red,
      label: 'Phase 1',
    ),
    RangeData(
      startPosition: 0.3,
      endPosition: 0.7,
      color: Colors.blue,
      label: 'Phase 2',
    ),
    RangeData(
      startPosition: 0.7,
      endPosition: 1.0,
      color: Colors.green,
      label: 'Phase 3',
    ),
  ],
)
```

## 🎨 Advanced Examples

### With Value Labels

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.6,
      color: Colors.blue,
      label: 'Progress',
      startValueLabel: 0.0,
      endValueLabel: 60.0,
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
  valueLabelFormatter: (value) => '${value?.toInt()}%',
  labelPosition: LabelPosition.above,
)
```

### With Custom Positioning

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.5,
      color: Colors.purple,
      startValueLabel: 0.0,
      endValueLabel: 50.0,
      // Custom positioning for individual labels
      startValueLabelPosition: ValueLabelOffset.above(
        vertical: -10.0,
        horizontal: 5.0,
      ),
      endValueLabelPosition: ValueLabelOffset.below(
        vertical: 10.0,
        horizontal: -5.0,
      ),
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
)
```

### With Interactions and Tooltips

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.4,
      color: Colors.green,
      label: 'Q1 Sales',
      tooltip: 'Q1 Revenue: $1.2M\nGrowth: +15%',
      startValueLabel: 0.0,
      endValueLabel: 1200000.0,
    ),
  ],
  showTooltip: true,
  valueLabelFormatter: (value) => '\$${(value! / 1000000).toStringAsFixed(1)}M',
  onRangeTap: (range) {
    print('Tapped: ${range.label}');
  },
)
```

### Handling Overlapping Labels

```dart
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.05, // Very narrow range
      color: Colors.red,
      startValueLabel: 0.0,
      endValueLabel: 5.0,
    ),
    RangeData(
      startPosition: 0.04, // Overlapping position
      endPosition: 0.3,
      color: Colors.blue,
      startValueLabel: 4.0,
      endValueLabel: 30.0,
    ),
  ],
  showStartValueLabels: true,
  showEndValueLabels: true,
  valueLabelOverlapBehavior: ValueLabelOverlapBehavior.showBoth,
  overlapThreshold: 0.03, // 3% threshold
)
```

## 🎛️ API Reference

### RangeBar

| Property                    | Type                        | Default      | Description                 |
| --------------------------- | --------------------------- | ------------ | --------------------------- |
| `ranges`                    | `List<RangeData>`           | **required** | List of ranges to display   |
| `height`                    | `double`                    | `20.0`       | Height of the bar           |
| `borderRadius`              | `BorderRadius?`             | `null`       | Border radius for the bar   |
| `backgroundColor`           | `Color?`                    | `null`       | Background color of the bar |
| `border`                    | `Border?`                   | `null`       | Border decoration           |
| `showLabels`                | `bool`                      | `true`       | Show range labels           |
| `showStartValueLabels`      | `bool`                      | `true`       | Show start value labels     |
| `showEndValueLabels`        | `bool`                      | `true`       | Show end value labels       |
| `labelPosition`             | `LabelPosition`             | `above`      | Position of labels          |
| `valueLabelFormatter`       | `String Function(double?)?` | `null`       | Custom value formatter      |
| `valueLabelOverlapBehavior` | `ValueLabelOverlapBehavior` | `hide`       | Overlap handling behavior   |
| `overlapThreshold`          | `double`                    | `0.03`       | Overlap detection threshold |
| `showTooltip`               | `bool`                      | `false`      | Enable tooltips             |
| `onRangeTap`                | `void Function(RangeData)?` | `null`       | Tap callback                |
| `onRangeHover`              | `void Function(RangeData)?` | `null`       | Hover callback              |

### RangeData

| Property                  | Type                | Default      | Description                 |
| ------------------------- | ------------------- | ------------ | --------------------------- |
| `startPosition`           | `double`            | **required** | Start position (0.0-1.0)    |
| `endPosition`             | `double`            | **required** | End position (0.0-1.0)      |
| `color`                   | `Color`             | **required** | Range color                 |
| `label`                   | `String?`           | `null`       | Range label                 |
| `startValueLabel`         | `double?`           | `null`       | Start value                 |
| `endValueLabel`           | `double?`           | `null`       | End value                   |
| `tooltip`                 | `String?`           | `null`       | Tooltip message             |
| `startValueLabelPosition` | `ValueLabelOffset?` | `null`       | Custom start label position |
| `endValueLabelPosition`   | `ValueLabelOffset?` | `null`       | Custom end label position   |

### Enums

#### LabelPosition

- `above` - Labels above the bar
- `below` - Labels below the bar
- `center` - Labels in the center of ranges
- `none` - No labels

#### ValueLabelOverlapBehavior

- `hide` - Hide both overlapping labels
- `hideStart` - Hide start label only
- `hideEnd` - Hide end label only
- `showBoth` - Show both labels
- `showOnlyStart` - Show start label only
- `showOnlyEnd` - Show end label only

#### ValueLabelPosition

- `above` - Above the bar
- `below` - Below the bar
- `center` - Center of the bar
- `none` - Hidden
- `custom` - Custom position

## 🎯 Use Cases

- **Progress Indicators**: Multi-stage progress visualization
- **Timeline Visualization**: Project phases and milestones
- **Data Segmentation**: Category breakdowns and distributions
- **Resource Allocation**: Budget or time allocation displays
- **Performance Metrics**: KPI ranges and targets
- **Gantt Charts**: Simplified project scheduling
- **Survey Results**: Response distribution visualization

## 🔧 Performance

RangeBar is optimized for performance:

- **Large Datasets**: Efficiently handles 100+ ranges
- **Smart Filtering**: Automatically filters invalid ranges
- **Minimal Rendering**: Only renders visible elements
- **Memory Efficient**: Optimized widget tree structure
- **Responsive**: Adapts to different screen sizes

## ♿ Accessibility

RangeBar includes comprehensive accessibility support:

- **Screen Reader Support**: Full semantic information
- **Keyboard Navigation**: Focus and interaction support
- **Custom Semantics**: Customizable accessibility labels
- **WCAG Compliance**: Follows accessibility guidelines

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



<!--
TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more. -->