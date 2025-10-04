import 'package:flutter/material.dart';
import '../models/range_data.dart';
import '../models/types.dart';
import '../models/range_bar_base.dart';
import 'range_bar.dart';

/// Range bar widget with animation functionality
///
/// [AnimatedRangeBar] displays range data with animations that extend sequentially from left to right.
/// It executes delayed animations based on the distance between RangeData,
/// achieving smooth display like a progress indicator.
///
/// ```dart
/// AnimatedRangeBar(
///   ranges: ranges,
///   duration: const Duration(milliseconds: 800),
///   curve: Curves.easeInOut,
///   staggerDelay: const Duration(milliseconds: 200),
/// )
/// ```
class AnimatedRangeBar extends StatefulWidget implements RangeBarBase {
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

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  /// Delay time between ranges (based on distance)
  final Duration staggerDelay;

  /// Delay at animation start
  final Duration initialDelay;

  /// Constructor for [AnimatedRangeBar]
  const AnimatedRangeBar({
    super.key,
    required this.ranges,
    this.height = 15.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.rangeBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
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
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeInOut,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.initialDelay = Duration.zero,
  }) : assert(height > 0, 'height must be greater than 0'),
       assert(
         overlapThreshold >= 0.0 && overlapThreshold <= 1.0,
         'overlapThreshold must be between 0.0 and 1.0',
       );

  @override
  State<AnimatedRangeBar> createState() => _AnimatedRangeBarState();
}

/// State management class for AnimatedRangeBar
class _AnimatedRangeBarState extends State<AnimatedRangeBar>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  final List<AnimationController> _rangeControllers = [];
  final List<Animation<double>> _rangeAnimations = [];
  List<RangeData> _sortedRanges = [];

  @override
  void initState() {
    super.initState();

    // Execute overlap check only in debug mode (performance consideration)
    assert(() {
      RangeData.validateNoOverlaps(
        widget.ranges,
        debugName: 'AnimatedRangeBar',
      );
      return true;
    }());

    _initializeAnimations();
  }

  @override
  void didUpdateWidget(AnimatedRangeBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Re-initialize animation when range data is changed
    if (oldWidget.ranges != widget.ranges ||
        oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve ||
        oldWidget.staggerDelay != widget.staggerDelay) {
      _disposeAnimations();
      _initializeAnimations();
    }
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  /// Initialize animation
  void _initializeAnimations() {
    // Sort range data by start position
    _sortedRanges = List.from(widget.ranges);
    _sortedRanges.sort((a, b) => a.startPosition.compareTo(b.startPosition));

    // Main animation controller
    _mainController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Animation controllers and animations for each range
    _rangeControllers.clear();
    _rangeAnimations.clear();

    for (int i = 0; i < _sortedRanges.length; i++) {
      final controller = AnimationController(
        duration: widget.duration,
        vsync: this,
      );

      final animation = CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      );

      _rangeControllers.add(controller);
      _rangeAnimations.add(animation);
    }

    // Start animation
    _startStaggeredAnimation();
  }

  /// Start staggered animation
  void _startStaggeredAnimation() async {
    // Initial delay
    if (widget.initialDelay > Duration.zero) {
      await Future.delayed(widget.initialDelay);
    }

    for (int i = 0; i < _rangeControllers.length; i++) {
      // Calculate delay based on distance from previous range
      Duration delay = Duration.zero;
      if (i > 0) {
        final prevRange = _sortedRanges[i - 1];
        final currentRange = _sortedRanges[i];
        final gap = currentRange.startPosition - prevRange.endPosition;

        // Longer delay for larger gaps
        final delayMultiplier = (gap * 10).clamp(0.0, 3.0);
        delay = Duration(
          milliseconds: (widget.staggerDelay.inMilliseconds * delayMultiplier)
              .round(),
        );
      }

      // Start animation after delay
      Future.delayed(delay, () {
        if (mounted && i < _rangeControllers.length) {
          _rangeControllers[i].forward();
        }
      });
    }
  }

  /// Dispose animations
  void _disposeAnimations() {
    _mainController.dispose();
    for (final controller in _rangeControllers) {
      controller.dispose();
    }
    _rangeControllers.clear();
    _rangeAnimations.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (_sortedRanges.isEmpty) {
      return SizedBox(height: widget.height);
    }

    return AnimatedBuilder(
      animation: Listenable.merge(_rangeAnimations),
      builder: (context, child) {
        // Create range data based on animation progress
        final animatedRanges = <RangeData>[];

        for (int i = 0; i < _sortedRanges.length; i++) {
          final originalRange = _sortedRanges[i];
          final progress = _rangeAnimations[i].value;

          // Animation extending from left to right
          final animatedEndPosition =
              originalRange.startPosition +
              (originalRange.endPosition - originalRange.startPosition) *
                  progress;

          // Always display range (even when progress is 0)
          // However, ensure minimum width for point data
          final effectiveEndPosition = originalRange.isPoint
              ? originalRange.endPosition
              : animatedEndPosition;

          animatedRanges.add(
            RangeData(
              startPosition: originalRange.startPosition,
              endPosition: effectiveEndPosition,
              color: originalRange.color,
              label: originalRange.label, // Always display label
              startValueLabel: originalRange
                  .startValueLabel, // Always display start value label
              endValueLabel: originalRange
                  .endValueLabel, // Always display end value label too
              labelStyle: originalRange.labelStyle,
              valueLabelStyle: originalRange.valueLabelStyle,
              data: originalRange.data,
              tooltip: originalRange.tooltip,
              startValueLabelPosition: originalRange.startValueLabelPosition,
              endValueLabelPosition: originalRange.endValueLabelPosition,
              isPoint: originalRange.isPoint,
            ),
          );
        }

        // Use static RangeBar to draw with animation values
        return RangeBar(
          ranges: animatedRanges,
          height: widget.height,
          borderRadius: widget.borderRadius,
          rangeBorderRadius: widget.rangeBorderRadius,
          backgroundColor: widget.backgroundColor,
          border: widget.border,
          showLabels: widget.showLabels,
          showStartValueLabels: widget.showStartValueLabels,
          showEndValueLabels: widget.showEndValueLabels,
          defaultLabelStyle: widget.defaultLabelStyle,
          defaultValueLabelStyle: widget.defaultValueLabelStyle,
          labelPosition: widget.labelPosition,
          valueLabelPosition: widget.valueLabelPosition,
          valueLabelOverlapBehavior: widget.valueLabelOverlapBehavior,
          overlapThreshold: widget.overlapThreshold,
          onRangeTap: widget.onRangeTap,
          onRangeHover: widget.onRangeHover,
          showTooltip: widget.showTooltip,
          tooltipBuilder: widget.tooltipBuilder,
          semanticsLabelBuilder: widget.semanticsLabelBuilder,
        );
      },
    );
  }
}
