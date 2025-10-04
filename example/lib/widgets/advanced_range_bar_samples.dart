import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Collection of advanced RangeBar samples
class AdvancedRangeBarSamples extends StatelessWidget {
  const AdvancedRangeBarSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edge Clipping Test (Value Labels at Both Ends)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0, // Left edge
              endPosition: 0.4,
              color: Colors.red,
              label: 'Start',
              startValueLabel: '¥0',
              endValueLabel: '¥400',
            ),
            RangeData(
              startPosition: 0.6,
              endPosition: 1.0, // Right edge
              color: Colors.blue,
              label: 'End',
              startValueLabel: '¥600',
              endValueLabel: '¥1000',
            ),
          ],
          height: 30,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.above,
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${range.label}: ${range.startValueLabel} - ${range.endValueLabel}',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        const Text(
          'Extreme Value Test',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.02, // Extremely narrow range
              color: Colors.orange,
              label: 'Tiny',
              startValueLabel: '0',
              endValueLabel: '2.0%',
            ),
            RangeData(
              startPosition: 0.98, // Extremely right-aligned
              endPosition: 1.0,
              color: Colors.purple,
              label: 'Edge',
              startValueLabel: '98.0%',
              endValueLabel: '100%',
            ),
          ],
          height: 25,
          borderRadius: BorderRadius.circular(4),
          showLabels: false, // Hide labels to focus on value labels
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.below,
        ),
        const SizedBox(height: 24),

        const Text(
          'Overlap Avoidance Test (Default: hide)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.05, // Overlapping narrow range
              color: Colors.red,
              label: 'A',
              startValueLabel: '0',
              endValueLabel: '5',
            ),
            RangeData(
              startPosition: 0.1, // Overlaps with previous range
              endPosition: 0.3,
              color: Colors.blue,
              label: 'B',
              startValueLabel: '10',
              endValueLabel: '30',
            ),
          ],
          height: 25,
          borderRadius: BorderRadius.circular(4),
          labelPosition: LabelPosition.above,
          valueLabelOverlapBehavior: ValueLabelOverlapBehavior.hide,
          overlapThreshold: 0.03, // 3% threshold
        ),
        const SizedBox(height: 16),

        const Text(
          'Overlap Allowed Test (showBoth)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.05,
              color: Colors.red,
              label: 'A',
              startValueLabel: '0',
              endValueLabel: '5',
            ),
            RangeData(
              startPosition: 0.1,
              endPosition: 0.3,
              color: Colors.blue,
              label: 'B',
              startValueLabel: '10',
              endValueLabel: '30',
            ),
          ],
          height: 25,
          borderRadius: BorderRadius.circular(4),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.below,
          valueLabelOverlapBehavior: ValueLabelOverlapBehavior.showBoth,
          overlapThreshold: 0.03,
        ),
        const SizedBox(height: 24),

        const Text(
          'Tooltip Test',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.3,
              color: Colors.green,
              label: 'Q1',
              tooltip: 'Q1 Sales: ¥12M\nYoY: +15%',
              startValueLabel: '0',
              endValueLabel: '¥12M',
            ),
            RangeData(
              startPosition: 0.3,
              endPosition: 0.7,
              color: Colors.blue,
              label: 'Q2',
              tooltip: 'Q2 Sales: ¥16M\nYoY: +8%',
              startValueLabel: '¥12M',
              endValueLabel: '¥28M',
            ),
            RangeData(
              startPosition: 0.7,
              endPosition: 1.0,
              color: Colors.purple,
              label: 'Q3',
              tooltip: 'Q3 Sales: ¥12M\nYoY: +5%',
              startValueLabel: '¥28M',
              endValueLabel: '¥40M',
            ),
          ],
          height: 30,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: false,
          showEndValueLabels: true,
          showTooltip: true,
          labelPosition: LabelPosition.center,
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${range.label} was tapped'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        const Text(
          'Accessibility Test',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'For screen reader testing. Focus on each range to verify the read-aloud content.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.25,
              color: Colors.red,
              label: 'Q1',
              tooltip: 'Q1 sales performance',
              startValueLabel: '0',
              endValueLabel: '¥2.5M',
            ),
            RangeData(
              startPosition: 0.25,
              endPosition: 0.6,
              color: Colors.orange,
              label: 'Q2',
              tooltip: 'Q2 sales performance',
              startValueLabel: '¥2.5M',
              endValueLabel: '¥6M',
            ),
            RangeData(
              startPosition: 0.6,
              endPosition: 1.0,
              color: Colors.green,
              label: 'Q3',
              tooltip: 'Q3 sales performance',
              startValueLabel: '¥600',
              endValueLabel: '¥1000',
            ),
          ],
          height: 35,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          showTooltip: true,
          labelPosition: LabelPosition.center,
          semanticsLabelBuilder: (range) {
            return '${range.label}: Sales from ${range.startValueLabel} to ${range.endValueLabel}, occupying ${(range.startPosition * 100).toStringAsFixed(0)}% to ${(range.endPosition * 100).toStringAsFixed(0)}% of the total range';
          },
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Displaying detailed information for ${range.label}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        const Text(
          'Fine Position Control Test',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Customize individual value label positions. Set vertical positions and offsets individually.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.3,
              color: Colors.indigo,
              label: 'Custom Position',
              startValueLabel: '0',
              endValueLabel: '30',
              // Start label above, end label below
              startValueLabelPosition: ValueLabelOffset.above(
                vertical: -10.0, // 10px higher than usual
                horizontal: 5.0, // 5px right offset
              ),
              endValueLabelPosition: ValueLabelOffset.below(
                vertical: 10.0, // 10px lower than usual
                horizontal: -5.0, // 5px left offset
              ),
            ),
            RangeData(
              startPosition: 0.3,
              endPosition: 0.7,
              color: Colors.teal,
              label: 'Center Alignment',
              startValueLabel: '30%',
              endValueLabel: '70%',
              // Both centered
              startValueLabelPosition: ValueLabelOffset.center(
                horizontal: -20.0, // 20px left offset
              ),
              endValueLabelPosition: ValueLabelOffset.center(
                horizontal: 20.0, // 20px right offset
              ),
            ),
            RangeData(
              startPosition: 0.7,
              endPosition: 1.0,
              color: Colors.deepOrange,
              label: 'Custom',
              startValueLabel: '70%',
              endValueLabel: '100%',
              // Custom position
              startValueLabelPosition: ValueLabelOffset.custom(
                vertical: -25.0, // 25px above bar
                horizontal: 0.0,
              ),
              endValueLabelPosition: ValueLabelOffset.custom(
                vertical: 50.0, // 50px below bar
                horizontal: 0.0,
              ),
            ),
          ],
          height: 30,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition
              .center, // Default position (overridden by individual settings)
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Check detailed settings for ${range.label}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        const Text(
          'Point Data Sample',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            // Normal range
            RangeData(
              startPosition: 0.1,
              endPosition: 0.4,
              color: Colors.blue,
              label: 'Phase 1',
              startValueLabel: '10%',
              endValueLabel: '40%',
            ),
            // Point data - Milestone
            RangeData.point(
              position: 0.6,
              color: Colors.red,
              label: 'Milestone (M1)',
              tooltip: 'Important milestone point',
            ),
            // Normal range
            RangeData(
              startPosition: 0.7,
              endPosition: 0.95,
              color: Colors.green,
              label: 'Phase 2',
              startValueLabel: '70%',
              endValueLabel: '95%',
            ),
            // Point data - Completion point
            RangeData.point(
              position: 0.95,
              color: Colors.orange,
              label: 'Complete',
              tooltip: 'Project completion point',
            ),
          ],
          height: 10,
          borderRadius: BorderRadius.circular(10),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: false,
          showTooltip: true,
          labelPosition: LabelPosition.above,
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  range.isPoint
                      ? 'Point data: ${range.label} (${range.startValueLabel})'
                      : 'Range data: ${range.label}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    );
  }
}
