import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Collection of basic RangeBar samples
class BasicRangeBarSamples extends StatelessWidget {
  const BasicRangeBarSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.4,
              endPosition: 0.6,
              color: Colors.black,
              startValueLabel: '40%',
              endValueLabel: '60%',
            ),
          ],
          borderRadius: BorderRadius.circular(4),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.above,
        ),
        const SizedBox(height: 24),
        const Text(
          'Basic Usage Example',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.3,
              color: Colors.red,
              label: 'Phase 1',
              startValueLabel: '0%',
              endValueLabel: '30%',
            ),
            RangeData(
              startPosition: 0.3,
              endPosition: 0.7,
              color: Colors.blue,
              label: 'Phase 2',
              startValueLabel: '30%',
              endValueLabel: '70%',
            ),
            RangeData(
              startPosition: 0.7,
              endPosition: 1.0,
              color: Colors.green,
              label: 'Phase 3',
              startValueLabel: '70%',
              endValueLabel: '100%',
            ),
          ],
          height: 30,
          borderRadius: BorderRadius.circular(4),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.above,
          onRangeTap: (range) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Tapped: ${range.label}')));
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Single Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.2,
              startValueLabel: '20',
              endPosition: 0.8,
              endValueLabel: '80',
              color: Colors.purple,
              label: 'Progress',
            ),
          ],
          height: 25,
          backgroundColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          labelPosition: LabelPosition.below,
        ),
        const SizedBox(height: 24),
        const Text(
          'Custom Style',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.25,
              color: Colors.orange,
              label: 'Q1',
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeData(
              startPosition: 0.25,
              endPosition: 0.5,
              color: Colors.amber,
              label: 'Q2',
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeData(
              startPosition: 0.5,
              endPosition: 0.75,
              color: Colors.lime,
              label: 'Q3',
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeData(
              startPosition: 0.75,
              endPosition: 1.0,
              color: Colors.teal,
              label: 'Q4',
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          height: 40,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          showLabels: true,
          labelPosition: LabelPosition.center,
          onRangeTap: (range) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tapped ${range.label}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ],
    );
  }
}
