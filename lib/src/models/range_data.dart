import 'package:flutter/material.dart';
import 'types.dart';

/// Model class representing range data
class RangeData {
  /// Start position (normalized coordinates from 0.0 to 1.0)
  final double startPosition;

  /// End position (normalized coordinates from 0.0 to 1.0)
  final double endPosition;

  /// Color of the range
  final Color color;

  /// Custom label
  final String? label;

  /// Value label to display at start position
  final String? startValueLabel;

  /// Value label to display at end position
  final String? endValueLabel;

  /// Text style for labels
  final TextStyle? labelStyle;

  /// Text style for value labels
  final TextStyle? valueLabelStyle;

  /// For additional data
  final dynamic data;

  /// Message to display in tooltip
  final String? tooltip;

  /// Position override for start value label (optional)
  final ValueLabelOffset? startValueLabelPosition;

  /// Position override for end value label (optional)
  final ValueLabelOffset? endValueLabelPosition;

  /// Whether to display as a point
  final bool isPoint;

  /// Constructor for [RangeData]
  ///
  /// [startPosition] and [endPosition] must be within the range 0.0-1.0,
  /// and [startPosition] must be less than or equal to [endPosition].
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
    this.tooltip,
    this.startValueLabelPosition,
    this.endValueLabelPosition,
    this.isPoint = false,
  }) : assert(
         startPosition >= 0.0 && startPosition <= 1.0,
         'startPosition must be between 0.0 and 1.0',
       ),
       assert(
         endPosition >= 0.0 && endPosition <= 1.0,
         'endPosition must be between 0.0 and 1.0',
       ),
       assert(
         startPosition <= endPosition,
         'startPosition must be less than or equal to endPosition',
       );

  /// Constructor for creating point data
  ///
  /// [position] must be within the range 0.0-1.0.
  /// Point data does not have start/end concepts, so startValueLabel, endValueLabel,
  /// startValueLabelPosition, and endValueLabelPosition cannot be used.
  const RangeData.point({
    required double position,
    required this.color,
    this.label,
    this.labelStyle,
    this.valueLabelStyle,
    this.data,
    this.tooltip,
  }) : startPosition = position,
       endPosition = position,
       startValueLabel = null,
       endValueLabel = null,
       startValueLabelPosition = null,
       endValueLabelPosition = null,
       isPoint = true,
       assert(
         position >= 0.0 && position <= 1.0,
         'position must be between 0.0 and 1.0',
       );

  /// Get the width of the range
  double get width => endPosition - startPosition;

  /// Determine if the range is valid
  bool get isValid => isPoint || width > 0.0;

  /// Determine if this range data overlaps with another range data
  ///
  /// The following cases are not considered overlaps:
  /// - Adjacent ranges (one's end position equals the other's start position)
  /// - Point data inside or on the boundary of range data (allowed as milestones)
  bool overlapsWith(RangeData other) {
    // Combinations of point data and range data are always allowed
    // Point data is used as milestones or event markers within ranges
    if (isPoint || other.isPoint) {
      return false; // Point data is always allowed
    }

    // Overlap check between normal range data
    // Adjacent cases (endPosition == other.startPosition or startPosition == other.endPosition) are not considered overlaps
    return !(endPosition <= other.startPosition ||
        startPosition >= other.endPosition);
  }

  /// Static method to check if multiple range data have no overlaps
  static void validateNoOverlaps(List<RangeData> ranges, {String? debugName}) {
    for (int i = 0; i < ranges.length; i++) {
      for (int j = i + 1; j < ranges.length; j++) {
        final range1 = ranges[i];
        final range2 = ranges[j];

        if (range1.overlapsWith(range2)) {
          final debugInfo = debugName != null ? ' in $debugName' : '';
          final overlapStart = range1.startPosition > range2.startPosition
              ? range1.startPosition
              : range2.startPosition;
          final overlapEnd = range1.endPosition < range2.endPosition
              ? range1.endPosition
              : range2.endPosition;
          final overlapSize = ((overlapEnd - overlapStart) * 100)
              .toStringAsFixed(1);

          throw AssertionError(
            'Range overlap detected$debugInfo:\n'
            '  Range ${i + 1}: ${range1.label ?? 'Unnamed'} '
            '(${range1.startPosition.toStringAsFixed(3)} - ${range1.endPosition.toStringAsFixed(3)})\n'
            '  Range ${j + 1}: ${range2.label ?? 'Unnamed'} '
            '(${range2.startPosition.toStringAsFixed(3)} - ${range2.endPosition.toStringAsFixed(3)})\n'
            '  Overlap: ${overlapStart.toStringAsFixed(3)} - ${overlapEnd.toStringAsFixed(3)} ($overlapSize%)\n'
            '\n'
            'Solutions:\n'
            '  • Adjust range positions to avoid overlap\n'
            '  • Make ranges adjacent: set end of first range = start of second range\n'
            '  • Use point data (RangeData.point) for markers within ranges',
          );
        }
      }
    }
  }

  /// Static method to check if range data is sorted by start position
  static void validateSortedByStartPosition(
    List<RangeData> ranges, {
    String? debugName,
  }) {
    for (int i = 1; i < ranges.length; i++) {
      if (ranges[i].startPosition < ranges[i - 1].startPosition) {
        final debugInfo = debugName != null ? ' in $debugName' : '';
        throw AssertionError(
          'Ranges are not sorted by start position$debugInfo:\n'
          '  Range $i: ${ranges[i - 1].label ?? 'Unnamed'} '
          'starts at ${ranges[i - 1].startPosition.toStringAsFixed(3)}\n'
          '  Range ${i + 1}: ${ranges[i].label ?? 'Unnamed'} '
          'starts at ${ranges[i].startPosition.toStringAsFixed(3)}\n'
          'Consider sorting ranges by startPosition before passing to the widget.',
        );
      }
    }
  }

  /// String representation for debugging
  @override
  String toString() =>
      'RangeData(start: $startPosition, end: $endPosition, '
      'label: $label, width: ${width.toStringAsFixed(3)})';

  /// Equality comparison
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
          endValueLabel == other.endValueLabel &&
          tooltip == other.tooltip &&
          isPoint == other.isPoint;

  @override
  int get hashCode => Object.hash(
    startPosition,
    endPosition,
    color,
    label,
    startValueLabel,
    endValueLabel,
    tooltip,
    isPoint,
  );
}

/// Class for detailed position settings of value labels
class ValueLabelOffset {
  /// Vertical offset (positive values go downward)
  final double vertical;

  /// Horizontal offset (positive values go rightward)
  final double horizontal;

  /// Label position
  final IndividualValueLabelPosition position;

  const ValueLabelOffset({
    required this.position,
    this.vertical = 0.0,
    this.horizontal = 0.0,
  });

  /// Place above (with custom offset)
  const ValueLabelOffset.above({this.vertical = 0.0, this.horizontal = 0.0})
    : position = IndividualValueLabelPosition.above;

  /// Place below (with custom offset)
  const ValueLabelOffset.below({this.vertical = 0.0, this.horizontal = 0.0})
    : position = IndividualValueLabelPosition.below;

  /// Place at center (with custom offset)
  const ValueLabelOffset.center({this.vertical = 0.0, this.horizontal = 0.0})
    : position = IndividualValueLabelPosition.center;

  /// Custom position
  const ValueLabelOffset.custom({
    required this.vertical,
    required this.horizontal,
  }) : position = IndividualValueLabelPosition.custom;
}
