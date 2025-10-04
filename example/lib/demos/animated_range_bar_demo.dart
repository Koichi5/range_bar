import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Demo widget for animated RangeBar
class AnimatedRangeBarDemo extends StatefulWidget {
  const AnimatedRangeBarDemo({super.key});

  @override
  AnimatedRangeBarDemoState createState() => AnimatedRangeBarDemoState();
}

class AnimatedRangeBarDemoState extends State<AnimatedRangeBarDemo> {
  List<RangeData> _ranges = [
    const RangeData(
      startPosition: 0.0,
      endPosition: 0.2,
      color: Colors.blue,
      label: 'Phase 1',
      startValueLabel: '0%',
      endValueLabel: '20%',
    ),
    const RangeData(
      startPosition: 0.4,
      endPosition: 0.6,
      color: Colors.orange,
      label: 'Phase 2',
      startValueLabel: '40%',
      endValueLabel: '60%',
    ),
    const RangeData(
      startPosition: 0.8,
      endPosition: 1.0,
      color: Colors.green,
      label: 'Phase 3',
      startValueLabel: '80%',
      endValueLabel: '100%',
    ),
  ];

  void _updateRanges() {
    setState(() {
      _ranges = [
        const RangeData(
          startPosition: 0.0,
          endPosition: 0.3,
          color: Colors.purple,
          label: 'Phase 1 Extended',
          startValueLabel: '0%',
          endValueLabel: '30%',
        ),
        const RangeData(
          startPosition: 0.5,
          endPosition: 0.7,
          color: Colors.red,
          label: 'Phase 2 Updated',
          startValueLabel: '50%',
          endValueLabel: '70%',
        ),
        const RangeData(
          startPosition: 0.9,
          endPosition: 1.0,
          color: Colors.teal,
          label: 'Final Phase',
          startValueLabel: '90%',
          endValueLabel: '100%',
        ),
      ];
    });
  }

  void _resetRanges() {
    setState(() {
      _ranges = [
        const RangeData(
          startPosition: 0.0,
          endPosition: 0.2,
          color: Colors.blue,
          label: 'Phase 1',
          startValueLabel: '0%',
          endValueLabel: '20%',
        ),
        const RangeData(
          startPosition: 0.4,
          endPosition: 0.6,
          color: Colors.orange,
          label: 'Phase 2',
          startValueLabel: '40%',
          endValueLabel: '60%',
        ),
        const RangeData(
          startPosition: 0.8,
          endPosition: 1.0,
          color: Colors.green,
          label: 'Phase 3',
          startValueLabel: '80%',
          endValueLabel: '100%',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedRangeBar(
          ranges: _ranges,
          height: 25,
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Colors.grey[100],
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.above,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
          staggerDelay: const Duration(milliseconds: 150),
          initialDelay: const Duration(milliseconds: 200),
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Animation: ${range.label} (${range.startValueLabel} - ${range.endValueLabel})',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: _updateRanges,
              child: const Text('Update Data'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _resetRanges, child: const Text('Reset')),
          ],
        ),
      ],
    );
  }
}
