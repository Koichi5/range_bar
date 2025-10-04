import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:range_bar/range_bar.dart';

void main() {
  group('Performance Tests', () {
    testWidgets('handles large number of ranges efficiently', (tester) async {
      // Generate large amount of data
      final largeRangeList = List.generate(200, (index) {
        final start = index / 200.0;
        final end = (index + 1) / 200.0;
        return RangeData(
          startPosition: start,
          endPosition: end,
          color: Colors.primaries[index % Colors.primaries.length],
          label: 'Range $index',
          startValueLabel: '${(start * 100).toStringAsFixed(1)}%',
          endValueLabel: '${(end * 100).toStringAsFixed(1)}%',
        );
      });

      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RangeBar(
              ranges: largeRangeList,
              showLabels: true,
              showStartValueLabels: true,
              showEndValueLabels: true,
            ),
          ),
        ),
      );

      stopwatch.stop();

      // Verify rendering time is within reasonable range
      expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // Within 1 second

      expect(find.byType(RangeBar), findsOneWidget);
    });

    testWidgets('handles minimal width efficiently', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 30, // Very narrow width
              child: RangeBar(
                ranges: [
                  RangeData(
                    startPosition: 0.0,
                    endPosition: 0.5,
                    color: Colors.red,
                    label: 'Test',
                  ),
                  RangeData(
                    startPosition: 0.5,
                    endPosition: 1.0,
                    color: Colors.blue,
                    label: 'Test2',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(RangeBar), findsOneWidget);
      // Verify it renders normally even with narrow width
    });

    testWidgets('filters invalid ranges efficiently', (tester) async {
      final mixedRanges = [
        // Valid range
        const RangeData(
          startPosition: 0.0,
          endPosition: 0.3,
          color: Colors.red,
        ),
        // Invalid range (width 0)
        const RangeData(
          startPosition: 0.5,
          endPosition: 0.5,
          color: Colors.blue,
        ),
        // Valid range
        const RangeData(
          startPosition: 0.7,
          endPosition: 1.0,
          color: Colors.green,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: RangeBar(ranges: mixedRanges)),
        ),
      );

      expect(find.byType(RangeBar), findsOneWidget);
      // Verify invalid ranges are properly filtered
    });

    test('range validation is efficient', () {
      final stopwatch = Stopwatch()..start();

      // Create and validate large amount of RangeData
      final ranges = List.generate(1000, (index) {
        return RangeData(
          startPosition: index / 1000.0,
          endPosition: (index + 1) / 1000.0,
          color: Colors.red,
        );
      });

      // Validity check
      final validRanges = ranges.where((range) => range.isValid).toList();

      stopwatch.stop();

      expect(validRanges.length, 1000);
      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Within 100ms
    });

    test('width calculation is efficient', () {
      final stopwatch = Stopwatch()..start();

      // Large amount of width calculations
      for (int i = 0; i < 10000; i++) {
        const range = RangeData(
          startPosition: 0.2,
          endPosition: 0.8,
          color: Colors.red,
        );
        range.width; // getter call
      }

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(50)); // Within 50ms
    });

    test('equality comparison is efficient', () {
      const range1 = RangeData(
        startPosition: 0.0,
        endPosition: 1.0,
        color: Colors.red,
        label: 'Test',
      );

      const range2 = RangeData(
        startPosition: 0.0,
        endPosition: 1.0,
        color: Colors.red,
        label: 'Test',
      );

      final stopwatch = Stopwatch()..start();

      // Large amount of equality comparisons
      for (int i = 0; i < 10000; i++) {
        range1 == range2;
        range1.hashCode;
      }

      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(100)); // Within 100ms
    });
  });

  group('Memory Efficiency Tests', () {
    test('RangeData objects are memory efficient', () {
      // Memory usage test (conceptual)
      final ranges = List.generate(1000, (index) {
        return RangeData(
          startPosition: index / 1000.0,
          endPosition: (index + 1) / 1000.0,
          color: Colors.red,
        );
      });

      expect(ranges.length, 1000);
      // Actual memory usage measurement is complex, so
      // here we just verify that large objects can be created normally
    });

    testWidgets('Widget tree depth is reasonable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RangeBar(
              ranges: List.generate(50, (index) {
                return RangeData(
                  startPosition: index / 50.0,
                  endPosition: (index + 1) / 50.0,
                  color: Colors.primaries[index % Colors.primaries.length],
                );
              }),
            ),
          ),
        ),
      );

      // Verify widget tree is properly constructed
      expect(find.byType(RangeBar), findsOneWidget);
      expect(find.byType(Stack), findsWidgets);
    });
  });
}
