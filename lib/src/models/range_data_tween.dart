import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'range_data.dart';

/// Custom Tween for RangeData
class RangeDataTween extends Tween<RangeData> {
  RangeDataTween({required super.begin, required super.end});

  @override
  RangeData lerp(double t) {
    if (begin == null) return end!;
    if (end == null) return begin!;

    return RangeData(
      startPosition:
          lerpDouble(begin!.startPosition, end!.startPosition, t) ?? 0.0,
      endPosition: lerpDouble(begin!.endPosition, end!.endPosition, t) ?? 0.0,
      color: Color.lerp(begin!.color, end!.color, t) ?? end!.color,
      label: end!.label, // Labels are not animated
      startValueLabel:
          end!.startValueLabel, // Value labels are also not animated
      endValueLabel: end!.endValueLabel,
      labelStyle: end!.labelStyle,
      valueLabelStyle: end!.valueLabelStyle,
      data: end!.data,
      tooltip: end!.tooltip,
      startValueLabelPosition: end!.startValueLabelPosition,
      endValueLabelPosition: end!.endValueLabelPosition,
      isPoint: end!.isPoint,
    );
  }
}
