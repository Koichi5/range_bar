import 'package:flutter/material.dart';
import '../models/range_data.dart';
import '../models/types.dart';
import '../models/range_bar_base.dart';
import 'range_bar_methods.dart';

/// Widget that displays multiple ranges in a horizontal bar
///
/// [RangeBar] is a StatelessWidget that displays a static range bar.
/// It automatically fits to the parent widget's width and does not include animations
///
/// ```dart
/// RangeBar(
///   ranges: [
///     RangeData(
///       startPosition: 0.0,
///       endPosition: 0.3,
///       color: Colors.red,
///       label: 'Phase 1',
///     ),
///     RangeData(
///       startPosition: 0.3,
///       endPosition: 0.7,
///       color: Colors.blue,
///       label: 'Phase 2',
///     ),
///   ],
/// )
/// ```
class RangeBar extends StatelessWidget
    with RangeBarMethods
    implements RangeBarBase {
  /// List of ranges to display
  @override
  final List<RangeData> ranges;

  /// Height of the bar
  @override
  final double height;

  /// Border radius settings (for entire bar)
  @override
  final BorderRadius? borderRadius;

  /// Border radius settings for individual ranges
  @override
  final BorderRadius? rangeBorderRadius;

  /// Background color
  @override
  final Color? backgroundColor;

  /// Border settings
  @override
  final Border? border;

  /// Enable/disable label display
  @override
  final bool showLabels;

  /// Enable/disable start value label display
  @override
  final bool showStartValueLabels;

  /// Enable/disable end value label display
  @override
  final bool showEndValueLabels;

  /// Default label text style
  @override
  final TextStyle? defaultLabelStyle;

  /// Default value label text style
  @override
  final TextStyle? defaultValueLabelStyle;

  /// Label position
  @override
  final LabelPosition labelPosition;

  /// Value label position (for startValueLabel, endValueLabel)
  @override
  final ValueLabelPosition valueLabelPosition;

  /// Behavior when value labels overlap
  @override
  final ValueLabelOverlapBehavior valueLabelOverlapBehavior;

  /// Threshold for overlap detection
  @override
  final double overlapThreshold;

  /// Callback when range is tapped
  @override
  final void Function(RangeData)? onRangeTap;

  /// Callback when range is hovered (Web/Desktop)
  @override
  final void Function(RangeData)? onRangeHover;

  /// Enable/disable tooltip display
  @override
  final bool showTooltip;

  /// Custom tooltip builder
  @override
  final Widget Function(RangeData)? tooltipBuilder;

  /// Custom semantics label builder
  @override
  final String Function(RangeData)? semanticsLabelBuilder;

  /// Constructor for [RangeBar]
  ///
  /// [ranges] List of ranges to display (required)
  /// [height] Height of the bar (default: 15.0)
  /// [borderRadius] Border radius settings (for entire bar, default: 8.0)
  /// [rangeBorderRadius] Border radius settings for individual ranges (default: 4.0)
  /// [backgroundColor] Background color
  /// [border] Border settings
  /// [showLabels] Enable/disable label display (default: false)
  /// [showStartValueLabels] Enable/disable start value label display (default: false)
  /// [showEndValueLabels] Enable/disable end value label display (default: false)
  /// [defaultLabelStyle] Default label text style
  /// [defaultValueLabelStyle] Default value label text style
  /// [labelPosition] Label position (default: LabelPosition.above)
  /// [valueLabelPosition] Value label position (default: ValueLabelPosition.above)
  /// [valueLabelOverlapBehavior] Behavior when value labels overlap (default: ValueLabelOverlapBehavior.hide)
  /// [overlapThreshold] Threshold for overlap detection (default: 0.03)
  /// [onRangeTap] Callback when range is tapped
  /// [onRangeHover] Callback when range is hovered
  /// [showTooltip] Enable/disable tooltip display (default: false)
  /// [tooltipBuilder] Custom tooltip builder
  /// [semanticsLabelBuilder] Custom semantics label builder
  const RangeBar({
    super.key,
    required this.ranges,
    this.height = 15.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(50.0)),
    this.rangeBorderRadius = const BorderRadius.all(Radius.circular(50.0)),
    this.backgroundColor,
    this.border,
    this.showLabels = true,
    this.showStartValueLabels = true,
    this.showEndValueLabels = true,
    this.defaultLabelStyle,
    this.defaultValueLabelStyle,
    this.labelPosition = LabelPosition.below,
    this.valueLabelPosition = ValueLabelPosition.above,
    this.valueLabelOverlapBehavior = ValueLabelOverlapBehavior.hide,
    this.overlapThreshold = 0.03,
    this.onRangeTap,
    this.onRangeHover,
    this.showTooltip = false,
    this.tooltipBuilder,
    this.semanticsLabelBuilder,
  }) : assert(height > 0, 'height must be greater than 0'),
       assert(
         overlapThreshold >= 0.0 && overlapThreshold <= 1.0,
         'overlapThreshold must be between 0.0 and 1.0',
       );

  @override
  Widget build(BuildContext context) {
    // Execute overlap check only in debug mode (performance consideration)
    assert(() {
      RangeData.validateNoOverlaps(ranges, debugName: 'RangeBar');
      return true;
    }());

    // Display nothing for empty list
    if (ranges.isEmpty) {
      return SizedBox(height: height);
    }

    // Performance optimization: filter only valid ranges for large datasets
    final validRanges = getValidRanges();
    if (validRanges.isEmpty) {
      return SizedBox(height: height);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Performance optimization: simplified display when width is too small
        if (constraints.maxWidth < 50) {
          return buildMinimalView(constraints.maxWidth);
        }

        Widget child = SizedBox(
          height: calculateTotalHeight(),
          child: Stack(
            children: [
              // Main bar
              buildBarContainer(constraints.maxWidth, validRanges),
              // Value labels (when displayed above/below)
              if (showStartValueLabels || showEndValueLabels)
                ...buildValueLabels(constraints.maxWidth, validRanges),
            ],
          ),
        );
        child = Semantics(
          container: true,
          label: buildSemanticLabel(validRanges),
          child: child,
        );

        return child;
      },
    );
  }

  /// Calculate total height
  double calculateTotalHeight() {
    double totalHeight = height;

    // Additional height is needed when labels are displayed above/below
    bool needsExtraHeight = false;

    // When normal labels are displayed above/below
    if (showLabels &&
        (labelPosition == LabelPosition.above ||
            labelPosition == LabelPosition.below)) {
      needsExtraHeight = true;
    }

    // When value labels are displayed above/below
    if ((showStartValueLabels || showEndValueLabels) &&
        (valueLabelPosition == ValueLabelPosition.above ||
            valueLabelPosition == ValueLabelPosition.below)) {
      needsExtraHeight = true;
    }

    if (needsExtraHeight) {
      totalHeight += 50; // Increase additional height for labels
    }

    return totalHeight;
  }

  /// Performance optimization: get only valid ranges
  List<RangeData> getValidRanges() {
    // Exclude invalid ranges and merge overlapping ranges (optional)
    final validRanges = ranges.where((range) => range.isValid).toList();

    // Limit maximum display count for large datasets (performance improvement)
    const maxVisibleRanges = 100;
    if (validRanges.length > maxVisibleRanges) {
      // Sort by importance or width and select top entries
      validRanges.sort((a, b) => b.width.compareTo(a.width));
      return validRanges.take(maxVisibleRanges).toList();
    }

    return validRanges;
  }

  /// Build minimal display view (when width is narrow)
  Widget buildMinimalView(double width) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[200],
          borderRadius: borderRadius,
          border: border,
        ),
        child: ranges.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: ranges.first.color,
                  borderRadius: borderRadius,
                ),
              )
            : null,
      ),
    );
  }

  /// Build semantics label
  String buildSemanticLabel([List<RangeData>? targetRanges]) {
    final rangeList = targetRanges ?? ranges;
    if (rangeList.isEmpty) {
      return 'Empty range bar';
    }

    final buffer = StringBuffer();
    buffer.write('Range bar with ${rangeList.length} ranges. ');

    for (int i = 0; i < rangeList.length; i++) {
      final range = rangeList[i];

      if (semanticsLabelBuilder != null) {
        buffer.write(semanticsLabelBuilder!(range));
      } else {
        buffer.write('Range ${i + 1}: ');
        if (range.label != null) {
          buffer.write('${range.label}, ');
        }
        buffer.write(
          'from ${(range.startPosition * 100).toStringAsFixed(1)}% ',
        );
        buffer.write('to ${(range.endPosition * 100).toStringAsFixed(1)}%');

        if (range.startValueLabel != null || range.endValueLabel != null) {
          buffer.write(', values: ');
          if (range.startValueLabel != null) {
            buffer.write('start ${range.startValueLabel}');
          }
          if (range.endValueLabel != null) {
            if (range.startValueLabel != null) buffer.write(', ');
            buffer.write('end ${range.endValueLabel}');
          }
        }
      }

      if (i < rangeList.length - 1) {
        buffer.write('. ');
      }
    }

    return buffer.toString();
  }
}
