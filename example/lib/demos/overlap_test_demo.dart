import 'package:flutter/material.dart';
import 'package:range_bar/range_bar.dart';

/// Demo widget for overlap validation testing
class OverlapTestDemo extends StatefulWidget {
  const OverlapTestDemo({super.key});

  @override
  OverlapTestDemoState createState() => OverlapTestDemoState();
}

class OverlapTestDemoState extends State<OverlapTestDemo> {
  Widget? _currentWidget;
  String? _errorMessage;

  void _testOverlapRangeBar() {
    try {
      setState(() {
        _errorMessage = null;
        _currentWidget = RangeBar(
          ranges: const [
            RangeData(
              startPosition: 0.0,
              endPosition: 0.4,
              color: Colors.red,
              label: 'Range 1',
              startValueLabel: '0%',
              endValueLabel: '40%',
            ),
            RangeData(
              startPosition:
                  0.3, // Overlap. This overlaps with the previous range
              endPosition: 0.7,
              color: Colors.blue,
              label: 'Range 2',
              startValueLabel: '30%',
              endValueLabel: '70%',
            ),
          ],
          height: 25,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
        );
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _currentWidget = null;
      });
    }
  }

  void _testOverlapAnimatedRangeBar() {
    try {
      setState(() {
        _errorMessage = null;
        _currentWidget = AnimatedRangeBar(
          ranges: [
            RangeData(
              startPosition: 0.1,
              endPosition: 0.5,
              color: Colors.green,
              label: 'Phase 1',
              startValueLabel: '10%',
              endValueLabel: '50%',
            ),
            RangeData(
              startPosition:
                  0.4, // Overlap. This overlaps with the previous range
              endPosition: 0.8,
              color: Colors.orange,
              label: 'Phase 2',
              startValueLabel: '40%',
              endValueLabel: '80%',
            ),
          ],
          height: 25,
          borderRadius: BorderRadius.circular(8),
          showLabels: true,
          showStartValueLabels: true,
          showEndValueLabels: true,
          duration: Duration(milliseconds: 800),
        );
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _currentWidget = null;
      });
    }
  }

  void _testValidRanges() {
    setState(() {
      _errorMessage = null;
      _currentWidget = RangeBar(
        ranges: const [
          RangeData(
            startPosition: 0.0,
            endPosition: 0.3,
            color: Colors.blue,
            label: 'Valid 1',
            startValueLabel: '0%',
            endValueLabel: '30%',
          ),
          RangeData(
            startPosition: 0.5, // No overlap
            endPosition: 0.8,
            color: Colors.green,
            label: 'Valid 2',
            startValueLabel: '50%',
            endValueLabel: '80%',
          ),
        ],
        height: 25,
        borderRadius: BorderRadius.circular(8),
        showLabels: true,
        showStartValueLabels: true,
        showEndValueLabels: true,
      );
    });
  }

  void _testAdjacentRanges() {
    setState(() {
      _errorMessage = null;
      _currentWidget = RangeBar(
        ranges: const [
          RangeData(
            startPosition: 0.0,
            endPosition: 0.3,
            color: Colors.blue,
            label: 'Range 1',
            startValueLabel: '0%',
            endValueLabel: '30%',
          ),
          RangeData(
            startPosition:
                0.3, // Adjacent (same as previous range end position) → Allowed
            endPosition: 0.6,
            color: Colors.green,
            label: 'Range 2',
            startValueLabel: '30%',
            endValueLabel: '60%',
          ),
          RangeData(
            startPosition:
                0.6, // Adjacent (same as previous range end position) → Allowed
            endPosition: 1.0,
            color: Colors.orange,
            label: 'Range 3',
            startValueLabel: '60%',
            endValueLabel: '100%',
          ),
        ],
        height: 25,
        borderRadius: BorderRadius.circular(8),
        showLabels: true,
        showStartValueLabels: true,
        showEndValueLabels: true,
      );
    });
  }

  void _testPointInRange() {
    setState(() {
      _errorMessage = null;
      _currentWidget = RangeBar(
        ranges: const [
          RangeData(
            startPosition: 0.0,
            endPosition: 0.5,
            color: Colors.blue,
            label: 'Phase 1',
            startValueLabel: '0%',
            endValueLabel: '50%',
          ),
          RangeData.point(
            position: 0.2, // Point within range (milestone) → Allowed
            color: Colors.red,
            label: 'Milestone 1 (M1)',
          ),
          RangeData.point(
            position: 0.5, // Point on range boundary → Allowed
            color: Colors.orange,
            label: 'Checkpoint (CP)',
          ),
          RangeData(
            startPosition: 0.5,
            endPosition: 1.0,
            color: Colors.green,
            label: 'Phase 2',
            startValueLabel: '50%',
            endValueLabel: '100%',
          ),
          RangeData.point(
            position: 0.8, // Point within range (milestone) → Allowed
            color: Colors.purple,
            label: 'Milestone 2 (M2)',
          ),
        ],
        height: 25,
        borderRadius: BorderRadius.circular(8),
        showLabels: true,
        showStartValueLabels: true,
        showEndValueLabels: false,
        labelPosition: LabelPosition.above,
      );
    });
  }

  void _clearTest() {
    setState(() {
      _currentWidget = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: _testOverlapRangeBar,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
              child: const Text('RangeBar Overlap Test'),
            ),
            ElevatedButton(
              onPressed: _testOverlapAnimatedRangeBar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[100],
              ),
              child: const Text('AnimatedRangeBar Overlap Test'),
            ),
            ElevatedButton(
              onPressed: _testValidRanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[100],
              ),
              child: const Text('Valid Data Test'),
            ),
            ElevatedButton(
              onPressed: _testAdjacentRanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
              ),
              child: const Text('Adjacent Range Test'),
            ),
            ElevatedButton(
              onPressed: _testPointInRange,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[100],
              ),
              child: const Text('Point in Range Test'),
            ),
            ElevatedButton(onPressed: _clearTest, child: const Text('Clear')),
          ],
        ),
        const SizedBox(height: 16),
        if (_errorMessage != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🚨 Overlap error detected:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (_currentWidget != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '✅ Successfully displayed:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                _currentWidget!,
              ],
            ),
          ),
        ],
      ],
    );
  }
}
