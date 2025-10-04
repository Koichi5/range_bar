import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';
import '../widgets/demo_section.dart';

/// Dedicated screen for RangeBar
class RangeBarScreen extends StatelessWidget {
  const RangeBarScreen({super.key});

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

          // Basic usage examples
          DemoSection(
            title: 'Basic Usage Examples',
            subtitle: 'Simple range display',
            icon: Icons.straighten,
            child: Column(
              children: [
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: 0.3,
                      color: Colors.blue,
                      label: 'Phase 1',
                    ),
                    RangeData(
                      startPosition: 0.4,
                      endPosition: 0.7,
                      color: Colors.green,
                      label: 'Phase 2',
                    ),
                    RangeData(
                      startPosition: 0.8,
                      endPosition: 1.0,
                      color: Colors.orange,
                      label: 'Phase 3',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                ),
                const CodeExample(
                  title: 'Basic Implementation',
                  code: '''RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.0,
      endPosition: 0.3,
      color: Colors.blue,
      label: 'Phase 1',
    ),
    // ... other ranges
  ],
  height: 32,
  showLabels: true,
)''',
                ),
              ],
            ),
          ),

          // Partial range specification
          DemoSection(
            title: 'Partial Range Specification',
            subtitle: 'Display a portion of the overall range',
            icon: Icons.crop,
            isHighlighted: true,
            accentColor: colorScheme.secondary,
            child: Column(
              children: [
                const InfoBox(
                  text:
                      'Example showing only the 40-80 point portion within a 0-100 point range',
                  icon: Icons.lightbulb_outline,
                  type: InfoBoxType.tip,
                ),
                const SizedBox(height: 16),
                RangeBar(
                  ranges: [
                    RangeData(
                      startPosition: _normalizeScore(40, 0, 100),
                      endPosition: _normalizeScore(80, 0, 100),
                      color: colorScheme.primary,
                      label: 'Target Range',
                      startValueLabel: '40pts',
                      endValueLabel: '80pts',
                      tooltip: 'Target achievement range: 40-80 points',
                    ),
                  ],
                  height: 32,
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  showStartValueLabels: true,
                  showEndValueLabels: true,
                  showTooltip: true,
                  labelPosition: LabelPosition.above,
                ),
                const CodeExample(
                  title: 'Partial Range Implementation',
                  code: '''// Normalization function
double _normalizeScore(int score, int min, int max) {
  return (score - min) / (max - min);
}

RangeBar(
  ranges: [
    RangeData(
      startPosition: _normalizeScore(40, 0, 100),
      endPosition: _normalizeScore(80, 0, 100),
      color: Colors.blue,
      label: 'Target Range',
      startValueLabel: '40pts',
      endValueLabel: '80pts',
    ),
  ],
  backgroundColor: Colors.grey[200], // Display overall range
  showStartValueLabels: true,
  showEndValueLabels: true,
)''',
                ),
              ],
            ),
          ),

          // Label position adjustment
          DemoSection(
            title: 'Label Position Adjustment',
            subtitle: 'Customize label display positions',
            icon: Icons.text_fields,
            child: Column(
              children: [
                const Text('Above Display'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.1,
                      endPosition: 0.4,
                      color: Colors.purple,
                      label: 'Task A',
                    ),
                    RangeData(
                      startPosition: 0.6,
                      endPosition: 0.9,
                      color: Colors.teal,
                      label: 'Task B',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  labelPosition: LabelPosition.above,
                ),
                const SizedBox(height: 24),
                const Text('Below Display'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.1,
                      endPosition: 0.4,
                      color: Colors.purple,
                      label: 'Task A',
                    ),
                    RangeData(
                      startPosition: 0.6,
                      endPosition: 0.9,
                      color: Colors.teal,
                      label: 'Task B',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  labelPosition: LabelPosition.below,
                ),
                const SizedBox(height: 24),
                const Text('Center Display'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.1,
                      endPosition: 0.4,
                      color: Colors.purple,
                      label: 'Task A',
                    ),
                    RangeData(
                      startPosition: 0.6,
                      endPosition: 0.9,
                      color: Colors.teal,
                      label: 'Task B',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  labelPosition: LabelPosition.center,
                ),
                const CodeExample(
                  title: 'Label Position Implementation',
                  code:
                      '''// Unified control of label positions with labelPosition
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.1,
      endPosition: 0.4,
      color: Colors.purple,
      label: 'Task A', // Available for all positions
    ),
  ],
  showLabels: true,
  labelPosition: LabelPosition.above, // above, below, center
)

// Value labels (startValueLabel, endValueLabel) are controlled separately
RangeBar(
  ranges: [
    RangeData(
      startPosition: 0.1,
      endPosition: 0.4,
      color: Colors.purple,
      label: 'Task A',           // For label
      startValueLabel: '10%',    // For start value label
      endValueLabel: '40%',      // For end value label
    ),
  ],
  showLabels: true,
  showStartValueLabels: true,
  showEndValueLabels: true,
  labelPosition: LabelPosition.center,      // Label position
  valueLabelPosition: ValueLabelPosition.above, // Value label position
)''',
                ),
              ],
            ),
          ),

          // Range border radius settings
          DemoSection(
            title: 'Range Border Radius Settings',
            subtitle: 'Apply border radius to individual ranges',
            icon: Icons.rounded_corner,
            child: Column(
              children: [
                const Text('Default (with border radius)'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: 0.3,
                      color: Colors.blue,
                      label: 'Phase 1',
                    ),
                    RangeData(
                      startPosition: 0.4,
                      endPosition: 0.7,
                      color: Colors.green,
                      label: 'Phase 2',
                    ),
                    RangeData(
                      startPosition: 0.8,
                      endPosition: 1.0,
                      color: Colors.orange,
                      label: 'Phase 3',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  labelPosition: LabelPosition.center,
                ),
                const SizedBox(height: 24),
                const Text('Custom border radius'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: 0.3,
                      color: Colors.blue,
                      label: 'Phase 1',
                    ),
                    RangeData(
                      startPosition: 0.4,
                      endPosition: 0.7,
                      color: Colors.green,
                      label: 'Phase 2',
                    ),
                    RangeData(
                      startPosition: 0.8,
                      endPosition: 1.0,
                      color: Colors.orange,
                      label: 'Phase 3',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Border radius for entire bar
                  rangeBorderRadius: BorderRadius.circular(
                    8,
                  ), // Border radius for individual ranges
                  showLabels: true,
                  labelPosition: LabelPosition.center,
                ),
                const SizedBox(height: 24),
                const Text('Sharp corners'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: 0.3,
                      color: Colors.blue,
                      label: 'Phase 1',
                    ),
                    RangeData(
                      startPosition: 0.4,
                      endPosition: 0.7,
                      color: Colors.green,
                      label: 'Phase 2',
                    ),
                    RangeData(
                      startPosition: 0.8,
                      endPosition: 1.0,
                      color: Colors.orange,
                      label: 'Phase 3',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.zero, // Sharp corners
                  rangeBorderRadius: BorderRadius.zero, // Sharp corners
                  showLabels: true,
                  labelPosition: LabelPosition.center,
                ),
                const CodeExample(
                  title: 'Range Border Radius Implementation',
                  code: '''// Default (with border radius)
RangeBar(
  ranges: [...],
  // borderRadius: 8.0 (default)
  // rangeBorderRadius: 4.0 (default)
)

// Custom border radius
RangeBar(
  ranges: [...],
  borderRadius: BorderRadius.circular(16),     // Border radius for entire bar
  rangeBorderRadius: BorderRadius.circular(8), // Border radius for individual ranges
)

// Sharp corners
RangeBar(
  ranges: [...],
  borderRadius: BorderRadius.zero,     // Sharp corners
  rangeBorderRadius: BorderRadius.zero, // Sharp corners
)''',
                ),
              ],
            ),
          ),

          // Value label position adjustment
          DemoSection(
            title: 'Value Label Position Adjustment',
            subtitle:
                'Individual control of startValueLabel and endValueLabel positions',
            icon: Icons.label_outline,
            child: Column(
              children: [
                const Text('Label: Center, Value Labels: Above'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.1,
                      endPosition: 0.4,
                      color: Colors.blue,
                      label: 'Project A',
                      startValueLabel: '10%',
                      endValueLabel: '40%',
                    ),
                    RangeData(
                      startPosition: 0.6,
                      endPosition: 0.9,
                      color: Colors.green,
                      label: 'Project B',
                      startValueLabel: '60%',
                      endValueLabel: '90%',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  showStartValueLabels: true,
                  showEndValueLabels: true,
                  labelPosition: LabelPosition.center,
                  valueLabelPosition: ValueLabelPosition.above,
                ),
                const SizedBox(height: 24),
                const Text('Label: Below, Value Labels: Above'),
                const SizedBox(height: 8),
                RangeBar(
                  ranges: const [
                    RangeData(
                      startPosition: 0.2,
                      endPosition: 0.5,
                      color: Colors.orange,
                      label: 'Phase 1',
                      startValueLabel: 'Feb',
                      endValueLabel: 'May',
                    ),
                    RangeData(
                      startPosition: 0.7,
                      endPosition: 0.95,
                      color: Colors.purple,
                      label: 'Phase 2',
                      startValueLabel: 'Jul',
                      endValueLabel: 'Dec',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  showStartValueLabels: true,
                  showEndValueLabels: true,
                  labelPosition: LabelPosition.below,
                  valueLabelPosition: ValueLabelPosition.above,
                ),
                const CodeExample(
                  title: 'Value Label Position Implementation',
                  code: '''RangeBar(
  ranges: [
    RangeData(
      label: 'Project A',      // Label
      startValueLabel: '10%',     // Start value label
      endValueLabel: '40%',       // End value label
    ),
  ],
  showLabels: true,
  showStartValueLabels: true,
  showEndValueLabels: true,
  labelPosition: LabelPosition.center,      // Label is centered
  valueLabelPosition: ValueLabelPosition.above, // Value labels are above
)''',
                ),
              ],
            ),
          ),

          // Tooltip functionality
          DemoSection(
            title: 'Tooltip Functionality',
            subtitle: 'Display detailed information on tap',
            icon: Icons.info_outline,
            child: Column(
              children: [
                const InfoBox(
                  text: 'Tap each range to display detailed information',
                  icon: Icons.touch_app,
                  type: InfoBoxType.info,
                ),
                const SizedBox(height: 16),
                RangeBar(
                  ranges: [
                    RangeData(
                      startPosition: 0.0,
                      endPosition: 0.25,
                      color: Colors.red,
                      label: 'Q1',
                      tooltip: 'Q1\nSales: ¥12M\nYoY: +15%',
                    ),
                    RangeData(
                      startPosition: 0.25,
                      endPosition: 0.6,
                      color: Colors.orange,
                      label: 'Q2',
                      tooltip: 'Q2\nSales: ¥18M\nYoY: +22%',
                    ),
                    RangeData(
                      startPosition: 0.6,
                      endPosition: 1.0,
                      color: Colors.green,
                      label: 'Q3-Q4',
                      tooltip: 'Q3-Q4\nSales: ¥21M\nYoY: +18%',
                    ),
                  ],
                  height: 40,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  showTooltip: true,
                  rangeBorderRadius: BorderRadius.zero,
                  onRangeTap: (range) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${range.label} was tapped'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Point data display
          DemoSection(
            title: 'Point Data Display',
            subtitle: 'Display as points without width',
            icon: Icons.fiber_manual_record,
            child: Column(
              children: [
                RangeBar(
                  ranges: const [
                    RangeData.point(
                      position: 0.2,
                      color: Colors.red,
                      label: 'Event A',
                    ),
                    RangeData.point(
                      position: 0.5,
                      color: Colors.blue,
                      label: 'Event B',
                    ),
                    RangeData.point(
                      position: 0.8,
                      color: Colors.green,
                      label: 'Event C',
                    ),
                  ],
                  height: 32,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  showLabels: true,
                  labelPosition: LabelPosition.above,
                ),
                const CodeExample(
                  title: 'Point Data Implementation',
                  code: '''RangeData.point(
  position: 0.5,
  color: Colors.blue,
  label: 'Event',
)
''',
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
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              color: colorScheme.onPrimary,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RangeBar',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Basic range display widget',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onPrimaryContainer.withValues(
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

  double _normalizeScore(int score, int min, int max) {
    return (score - min) / (max - min);
  }
}
