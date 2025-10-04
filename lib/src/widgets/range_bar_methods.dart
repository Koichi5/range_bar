import 'package:flutter/material.dart';
import '../models/range_data.dart';
import '../models/types.dart';
import '../models/range_bar_base.dart';

/// Mixin containing internal methods for RangeBar
mixin RangeBarMethods on StatelessWidget implements RangeBarBase {
  /// Build the main bar container
  Widget buildBarContainer(double totalWidth, [List<RangeData>? targetRanges]) {
    final rangeList = targetRanges ?? ranges;
    // Shift the bar down when labels are displayed at the top
    double barTop = 0.0;

    // When normal labels are displayed at the top
    if (showLabels && labelPosition == LabelPosition.above) {
      barTop = 25.0;
    }

    // When value labels are displayed at the top
    if ((showStartValueLabels || showEndValueLabels) &&
        valueLabelPosition == ValueLabelPosition.above) {
      barTop = 25.0;
    }

    return Positioned(
      left: 0,
      top: barTop,
      right: 0,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[300],
          borderRadius: borderRadius,
          border: border,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Stack(
            children: [
              // Draw each range
              ...rangeList.map(
                (range) => buildRangeSegment(range, totalWidth, barTop),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build value labels (with overlap avoidance logic)
  List<Widget> buildValueLabels(
    double totalWidth, [
    List<RangeData>? targetRanges,
  ]) {
    final rangeList = targetRanges ?? ranges;
    final List<Widget> labels = [];

    // Collect label information for each range
    final List<ValueLabelInfo> labelInfos = [];

    for (final range in rangeList) {
      // When labels are displayed at top/bottom, add label as value label too
      if (showLabels &&
          range.label != null &&
          (labelPosition == LabelPosition.above ||
              labelPosition == LabelPosition.below)) {
        // Labels are displayed at the center position of the range
        final centerPosition = (range.startPosition + range.endPosition) / 2;
        labelInfos.add(
          ValueLabelInfo(
            value: range.label!,
            position: centerPosition,
            range: range,
            isStart: false, // Labels are treated as end values
            isValueLabel: false, // Normal label
          ),
        );
      }

      // Start value label
      if (showStartValueLabels && range.startValueLabel != null) {
        labelInfos.add(
          ValueLabelInfo(
            value: range.startValueLabel!,
            position: range.startPosition,
            range: range,
            isStart: true,
            isValueLabel: true, // Value label
          ),
        );
      }

      // End value label
      if (showEndValueLabels && range.endValueLabel != null) {
        labelInfos.add(
          ValueLabelInfo(
            value: range.endValueLabel!,
            position: range.endPosition,
            range: range,
            isStart: false,
            isValueLabel: true, // Value label
          ),
        );
      }
    }

    // Apply overlap avoidance logic and filter
    final filteredLabels = applyOverlapBehavior(labelInfos);

    // Convert filtered labels to Widgets
    for (final labelInfo in filteredLabels) {
      labels.add(
        buildValueLabel(
          labelInfo.value,
          labelInfo.position,
          totalWidth,
          labelInfo.range,
          isStart: labelInfo.isStart,
          labelInfo: labelInfo,
        ),
      );
    }

    return labels;
  }

  /// Apply overlap avoidance logic
  List<ValueLabelInfo> applyOverlapBehavior(List<ValueLabelInfo> labelInfos) {
    // Sort by position
    labelInfos.sort((a, b) => a.position.compareTo(b.position));

    final List<ValueLabelInfo> result = [];

    for (int i = 0; i < labelInfos.length; i++) {
      final current = labelInfos[i];
      bool shouldShow = true;

      // Check for overlaps within the same range
      if (i > 0) {
        final previous = labelInfos[i - 1];

        // When overlapping within the same range
        if (current.range == previous.range &&
            areLabelsOverlapping(previous.position, current.position)) {
          shouldShow = shouldShowLabelInSameRange(previous, current);
        }
        // Check for overlaps between different ranges
        else if (current.range != previous.range &&
            areLabelsOverlapping(previous.position, current.position)) {
          shouldShow = shouldShowLabelBetweenRanges(previous, current);
        }
      }

      if (shouldShow) {
        result.add(current);
      }
    }

    return result;
  }

  /// Determine if labels are overlapping
  bool areLabelsOverlapping(double pos1, double pos2) {
    return (pos2 - pos1).abs() <= overlapThreshold;
  }

  /// Determine display when overlapping within the same range
  bool shouldShowLabelInSameRange(ValueLabelInfo first, ValueLabelInfo second) {
    switch (valueLabelOverlapBehavior) {
      case ValueLabelOverlapBehavior.hide:
        return false; // Hide both
      case ValueLabelOverlapBehavior.hideStart:
        return !first.isStart; // Hide only start label
      case ValueLabelOverlapBehavior.hideEnd:
        return first.isStart; // Hide only end label
      case ValueLabelOverlapBehavior.showBoth:
        return true; // Show both
      case ValueLabelOverlapBehavior.showOnlyEnd:
        return !first.isStart; // Show only end label
      case ValueLabelOverlapBehavior.showOnlyStart:
        return first.isStart; // Show only start label
    }
  }

  /// Determine display when overlapping between different ranges
  bool shouldShowLabelBetweenRanges(
    ValueLabelInfo first,
    ValueLabelInfo second,
  ) {
    switch (valueLabelOverlapBehavior) {
      case ValueLabelOverlapBehavior.hide:
        return false; // Hide both
      case ValueLabelOverlapBehavior.hideStart:
        return !second.isStart; // Hide later start label
      case ValueLabelOverlapBehavior.hideEnd:
        return second.isStart; // Hide later end label
      case ValueLabelOverlapBehavior.showBoth:
        return true; // Show both
      case ValueLabelOverlapBehavior.showOnlyEnd:
        return !second.isStart; // Prioritize end label
      case ValueLabelOverlapBehavior.showOnlyStart:
        return second.isStart; // Prioritize start label
    }
  }

  /// Build individual value labels
  Widget buildValueLabel(
    String value,
    double normalizedPosition,
    double totalWidth,
    RangeData range, {
    required bool isStart,
    ValueLabelInfo? labelInfo,
  }) {
    final text = value;

    final style =
        range.valueLabelStyle ??
        defaultValueLabelStyle ??
        const TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

    // Check individual position settings
    final individualPosition = isStart
        ? range.startValueLabelPosition
        : range.endValueLabelPosition;

    double top = 0.0;
    double horizontalOffset = 0.0;

    if (individualPosition != null) {
      // When individual position settings exist
      switch (individualPosition.position) {
        case IndividualValueLabelPosition.above:
          top =
              0 +
              individualPosition
                  .vertical; // Display at top of bar (adjusted by barTop)
          break;
        case IndividualValueLabelPosition.below:
          top =
              height +
              30 +
              individualPosition.vertical; // Display at bottom of bar
          break;
        case IndividualValueLabelPosition.center:
          top = height / 2 - 10 + individualPosition.vertical;
          break;
        case IndividualValueLabelPosition.none:
          return const SizedBox.shrink();
        case IndividualValueLabelPosition.custom:
          top = individualPosition.vertical;
          break;
      }
      horizontalOffset = individualPosition.horizontal;
    } else {
      // Use default global settings
      // Use labelInfo if available, otherwise use conventional logic
      final isValueLabel =
          labelInfo?.isValueLabel ??
          ((isStart && range.startValueLabel != null && showStartValueLabels) ||
              (!isStart && range.endValueLabel != null && showEndValueLabels));

      if (isValueLabel) {
        // Position control for value labels (startValueLabel, endValueLabel)
        switch (valueLabelPosition) {
          case ValueLabelPosition.above:
            top = 0; // Display at top of bar (adjusted by barTop)
            break;
          case ValueLabelPosition.below:
            top = height + 30; // Display at bottom of bar
            break;
          case ValueLabelPosition.center:
            top = height / 2 + 15; // Adjust considering barTop
            break;
          case ValueLabelPosition.none:
            return const SizedBox.shrink();
        }
      } else {
        // Position control for normal labels (label)
        switch (labelPosition) {
          case LabelPosition.above:
            top = 0; // Display at top of bar (adjusted by barTop)
            break;
          case LabelPosition.below:
            top = height + 30; // Display at bottom of bar
            break;
          case LabelPosition.center:
            top = height / 2 + 15; // Adjust considering barTop
            break;
          case LabelPosition.none:
            return const SizedBox.shrink();
        }
      }
    }

    // Determine if near edges (threshold: 0.05 = 5%)
    const edgeThreshold = 0.05;
    final isNearLeftEdge = normalizedPosition <= edgeThreshold;
    final isNearRightEdge = normalizedPosition >= (1.0 - edgeThreshold);

    // Determine position and alignment
    double left;
    TextAlign textAlign;

    if (isNearLeftEdge) {
      // Near left edge: left-align with margin
      left = 8.0 + horizontalOffset;
      textAlign = TextAlign.left;
    } else if (isNearRightEdge) {
      // Near right edge: right-align with margin
      left =
          totalWidth - 60.0 + horizontalOffset; // 60px inside from right edge
      textAlign = TextAlign.right;
    } else {
      // Center: normal center alignment
      left =
          (normalizedPosition * totalWidth) -
          30.0 +
          horizontalOffset; // Center align (half of 60px width)
      textAlign = TextAlign.center;
    }

    return Positioned(
      left: left.clamp(0.0, totalWidth - 60.0), // Boundary check
      top: top,
      width: 60.0, // Fixed width for stable layout
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Build individual range segments
  Widget buildRangeSegment(RangeData range, double totalWidth, double barTop) {
    // Skip if range is invalid
    if (!range.isValid) return const SizedBox.shrink();

    // Use dedicated drawing process for point data
    if (range.isPoint) {
      return buildPointMarker(range, totalWidth, barTop);
    }

    final left = range.startPosition * totalWidth;
    final width = range.width * totalWidth;

    Widget child = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: range.color,
        borderRadius: rangeBorderRadius,
      ),
      child: buildRangeContent(range),
    );

    // Add tooltip functionality
    if (showTooltip && (range.tooltip != null || tooltipBuilder != null)) {
      child = Tooltip(
        message: range.tooltip ?? '',
        preferBelow: labelPosition == LabelPosition.above,
        child: tooltipBuilder != null ? tooltipBuilder!(range) : child,
      );
    }

    Widget segmentChild = GestureDetector(
      onTap: onRangeTap != null ? () => onRangeTap!(range) : null,
      child: MouseRegion(
        onEnter: onRangeHover != null ? (_) => onRangeHover!(range) : null,
        child: child,
      ),
    );

    // Add semantics information to individual ranges (always enabled)
    final semanticLabel = semanticsLabelBuilder != null
        ? semanticsLabelBuilder!(range)
        : buildRangeSemanticLabel(range);

    segmentChild = Semantics(
      button: onRangeTap != null,
      enabled: true,
      label: semanticLabel,
      onTap: onRangeTap != null ? () => onRangeTap!(range) : null,
      child: segmentChild,
    );

    return Positioned(
      left: left,
      top: 0,
      width: width,
      height: height,
      child: segmentChild,
    );
  }

  /// Build content within range (labels, etc.)
  Widget? buildRangeContent(RangeData range) {
    // Display nothing when label display is disabled
    if (!showLabels ||
        range.label == null ||
        labelPosition == LabelPosition.none) {
      return null;
    }

    final style =
        range.labelStyle ??
        defaultLabelStyle ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

    // Display labels according to labelPosition
    switch (labelPosition) {
      case LabelPosition.center:
        return Center(
          child: Text(
            range.label!,
            style: style,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        );
      case LabelPosition.above:
      case LabelPosition.below:
        // For top/bottom display, show outside range, so return nothing here
        // Actual display is handled by buildValueLabels
        return null;
      case LabelPosition.none:
        return null;
    }
  }

  /// Build semantics labels for individual ranges
  String buildRangeSemanticLabel(RangeData range) {
    final buffer = StringBuffer();

    if (range.label != null) {
      buffer.write('${range.label} range, ');
    } else {
      buffer.write('Range ');
    }

    buffer.write('from ${(range.startPosition * 100).toStringAsFixed(1)}% ');
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

    if (onRangeTap != null) {
      buffer.write('. Tap to interact');
    }

    return buffer.toString();
  }

  /// Build point markers
  Widget buildPointMarker(RangeData range, double totalWidth, double barTop) {
    final left = range.startPosition * totalWidth;
    final pointSize = height; // Circle with same size as bar height

    Widget child = Container(
      width: pointSize,
      height: pointSize,
      decoration: BoxDecoration(color: range.color, shape: BoxShape.circle),
      child: buildRangeContent(range),
    );

    // Add tooltip functionality
    if (showTooltip && (range.tooltip != null || tooltipBuilder != null)) {
      child = Tooltip(
        message: range.tooltip ?? '',
        preferBelow: labelPosition == LabelPosition.above,
        child: tooltipBuilder != null ? tooltipBuilder!(range) : child,
      );
    }

    Widget pointChild = GestureDetector(
      onTap: onRangeTap != null ? () => onRangeTap!(range) : null,
      child: MouseRegion(
        onEnter: onRangeHover != null ? (_) => onRangeHover!(range) : null,
        child: child,
      ),
    );

    // Add semantics information
    final semanticLabel = semanticsLabelBuilder != null
        ? semanticsLabelBuilder!(range)
        : buildPointSemanticLabel(range);

    pointChild = Semantics(
      button: onRangeTap != null,
      enabled: true,
      label: semanticLabel,
      onTap: onRangeTap != null ? () => onRangeTap!(range) : null,
      child: pointChild,
    );

    return Positioned(
      left: left - (pointSize / 2), // Center placement
      top: 0,
      width: pointSize,
      height: pointSize,
      child: pointChild,
    );
  }

  /// Build semantics labels for points
  String buildPointSemanticLabel(RangeData range) {
    final buffer = StringBuffer();

    if (range.label != null) {
      buffer.write('${range.label} point, ');
    } else {
      buffer.write('Point ');
    }

    buffer.write('at ${(range.startPosition * 100).toStringAsFixed(1)}%');

    if (range.startValueLabel != null) {
      buffer.write(', value: ${range.startValueLabel}');
    }

    if (onRangeTap != null) {
      buffer.write('. Tap to interact');
    }

    return buffer.toString();
  }
}
