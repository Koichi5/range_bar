import 'package:flutter/material.dart';
import 'range_data.dart';
import 'types.dart';

/// Helper class that holds value label information
class ValueLabelInfo {
  final String value;
  final double position;
  final RangeData range;
  final bool isStart;
  final bool
  isValueLabel; // Whether it's a value label (startValueLabel, endValueLabel)

  const ValueLabelInfo({
    required this.value,
    required this.position,
    required this.range,
    required this.isStart,
    required this.isValueLabel,
  });

  @override
  String toString() =>
      'ValueLabelInfo(value: $value, position: $position, isStart: $isStart, isValueLabel: $isValueLabel)';
}

/// Base class that provides common functionality for range bars
abstract class RangeBarBase {
  /// List of ranges to display
  List<RangeData> get ranges;

  /// Height of the bar
  double get height;

  /// Border radius settings (for entire bar)
  BorderRadius? get borderRadius;

  /// Border radius settings for individual ranges
  BorderRadius? get rangeBorderRadius;

  /// Background color
  Color? get backgroundColor;

  /// Border settings
  Border? get border;

  /// Label display on/off
  bool get showLabels;

  /// Start value label display on/off
  bool get showStartValueLabels;

  /// End value label display on/off
  bool get showEndValueLabels;

  /// Default label text style
  TextStyle? get defaultLabelStyle;

  /// Default value label text style
  TextStyle? get defaultValueLabelStyle;

  /// Label position
  LabelPosition get labelPosition;

  /// Value label position (for startValueLabel, endValueLabel)
  ValueLabelPosition get valueLabelPosition;

  /// Behavior when value labels overlap
  ValueLabelOverlapBehavior get valueLabelOverlapBehavior;

  /// Threshold for overlap detection
  double get overlapThreshold;

  /// Callback when range is tapped
  void Function(RangeData)? get onRangeTap;

  /// Callback when range is hovered (Web/Desktop)
  void Function(RangeData)? get onRangeHover;

  /// Enable/disable tooltip display
  bool get showTooltip;

  /// Custom tooltip builder
  Widget Function(RangeData)? get tooltipBuilder;

  /// Custom builder for semantics labels
  String Function(RangeData)? get semanticsLabelBuilder;
}
