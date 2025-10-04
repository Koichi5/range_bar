import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';
import '../widgets/demo_section.dart';

/// Dedicated screen for AnimatedRangeBar
class AnimatedRangeBarScreen extends StatefulWidget {
  const AnimatedRangeBarScreen({super.key});

  @override
  State<AnimatedRangeBarScreen> createState() => _AnimatedRangeBarScreenState();
}

class _AnimatedRangeBarScreenState extends State<AnimatedRangeBarScreen> {
  List<RangeData> _basicRanges = [];
  List<RangeData> _staggeredRanges = [];
  List<RangeData> _customRanges = [];

  // Keys for curve comparison (for animation replay)
  Key _linearKey = UniqueKey();
  Key _easeInOutKey = UniqueKey();
  Key _easeOutCubicKey = UniqueKey();
  Key _easeOutBackKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _resetBasicAnimation();
    _resetStaggeredAnimation();
    _resetCustomAnimation();
  }

  void _resetBasicAnimation() {
    setState(() {
      _basicRanges = [
        const RangeData(
          startPosition: 0.0,
          endPosition: 0.3,
          color: Colors.blue,
          label: 'Phase 1',
        ),
        const RangeData(
          startPosition: 0.4,
          endPosition: 0.7,
          color: Colors.green,
          label: 'Phase 2',
        ),
        const RangeData(
          startPosition: 0.8,
          endPosition: 0.95,
          color: Colors.orange,
          label: 'Phase 3',
        ),
      ];
    });
  }

  void _resetStaggeredAnimation() {
    setState(() {
      _staggeredRanges = [
        const RangeData(
          startPosition: 0.0,
          endPosition: 0.2,
          color: Colors.purple,
          label: 'Task A',
        ),
        const RangeData(
          startPosition: 0.3,
          endPosition: 0.5,
          color: Colors.teal,
          label: 'Task B',
        ),
        const RangeData(
          startPosition: 0.6,
          endPosition: 0.8,
          color: Colors.indigo,
          label: 'Task C',
        ),
        const RangeData(
          startPosition: 0.82,
          endPosition: 0.95,
          color: Colors.amber,
          label: 'Task D',
        ),
      ];
    });
  }

  void _resetCustomAnimation() {
    setState(() {
      _customRanges = [
        const RangeData(
          startPosition: 0.1,
          endPosition: 0.4,
          color: Colors.red,
          label: 'Q1',
        ),
        const RangeData(
          startPosition: 0.5,
          endPosition: 0.85,
          color: Colors.blue,
          label: 'Q2-Q3',
        ),
      ];
    });
  }

  void _resetAllCurveAnimations() {
    setState(() {
      _linearKey = UniqueKey();
      _easeInOutKey = UniqueKey();
      _easeOutCubicKey = UniqueKey();
      _easeOutBackKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page header
          _buildPageHeader(context),
          const SizedBox(height: 32),

          // Basic animation
          DemoSection(
            title: 'Basic Animation',
            subtitle: 'Animation extending sequentially from left to right',
            icon: Icons.play_arrow,
            child: Column(
              children: [
                AnimatedRangeBar(
                  ranges: _basicRanges,
                  height: 32,
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutCubic,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _resetBasicAnimation,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Play Animation'),
                ),
                const CodeExample(
                  title: 'Basic Implementation',
                  code: '''AnimatedRangeBar(
  ranges: ranges,
  duration: Duration(milliseconds: 1000),
  curve: Curves.easeInOutCubic,
  height: 32,
  showLabels: true,
)''',
                ),
              ],
            ),
          ),

          // Stagger animation
          DemoSection(
            title: 'Stagger Animation',
            subtitle: 'Animation with delays based on distance between ranges',
            icon: Icons.timeline,
            isHighlighted: true,
            accentColor: colorScheme.secondary,
            child: Column(
              children: [
                const InfoBox(
                  text:
                      'Each range animates sequentially with delays adjusted according to distance',
                  icon: Icons.info_outline,
                  type: InfoBoxType.info,
                ),
                const SizedBox(height: 16),
                AnimatedRangeBar(
                  ranges: _staggeredRanges,
                  height: 28,
                  borderRadius: BorderRadius.circular(14),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  staggerDelay: const Duration(milliseconds: 150),
                  initialDelay: const Duration(milliseconds: 200),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _resetStaggeredAnimation,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Play Animation'),
                ),
                const CodeExample(
                  title: 'Stagger Animation Implementation',
                  code: '''AnimatedRangeBar(
  ranges: ranges,
  duration: Duration(milliseconds: 800),
  curve: Curves.easeOutBack,
  staggerDelay: Duration(milliseconds: 150), // Delay between ranges
  initialDelay: Duration(milliseconds: 200),  // Initial delay
)''',
                ),
              ],
            ),
          ),

          // Custom animation
          DemoSection(
            title: 'Custom Animation',
            subtitle: 'Custom curves and timing',
            icon: Icons.tune,
            child: Column(
              children: [
                AnimatedRangeBar(
                  ranges: _customRanges,
                  height: 36,
                  borderRadius: BorderRadius.circular(18),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  showStartValueLabels: true,
                  showEndValueLabels: true,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutBack,
                  staggerDelay: const Duration(milliseconds: 300),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _resetCustomAnimation,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Play'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _customRanges = [];
                          });
                        },
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Animation curve comparison
          DemoSection(
            title: 'Animation Curve Comparison',
            subtitle: 'Differences in movement with different curves',
            icon: Icons.show_chart,
            child: Column(
              children: [
                _buildCurveComparison(
                  'Linear',
                  Curves.linear,
                  Colors.red,
                  _linearKey,
                ),
                const SizedBox(height: 16),
                _buildCurveComparison(
                  'Ease In Out',
                  Curves.easeInOut,
                  Colors.blue,
                  _easeInOutKey,
                ),
                const SizedBox(height: 16),
                _buildCurveComparison(
                  'Ease Out Cubic',
                  Curves.easeOutCubic,
                  Colors.green,
                  _easeOutCubicKey,
                ),
                const SizedBox(height: 16),
                _buildCurveComparison(
                  'Ease Out Back',
                  Curves.easeOutBack,
                  Colors.purple,
                  _easeOutBackKey,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _resetAllCurveAnimations,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Play Animation'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.secondaryContainer,
            colorScheme.secondaryContainer.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.animation,
              color: colorScheme.onSecondary,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimatedRangeBar',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Animated range display widget',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSecondaryContainer.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurveComparison(
    String name,
    Curve curve,
    Color color,
    Key animationKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        AnimatedRangeBar(
          key: animationKey,
          ranges: [
            RangeData(
              startPosition: 0.1,
              endPosition: 0.75,
              color: color,
              label: name,
            ),
          ],
          height: 24,
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
          showLabels: true,
          duration: const Duration(milliseconds: 1200),
          curve: curve,
        ),
      ],
    );
  }
}
