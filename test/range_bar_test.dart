import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:range_bar/range_bar.dart';

void main() {
  group('RangeData', () {
    group('Constructor', () {
      test('creates valid RangeData with required parameters', () {
        const rangeData = RangeData(
          startPosition: 0.0,
          endPosition: 1.0,
          color: Colors.red,
        );

        expect(rangeData.startPosition, 0.0);
        expect(rangeData.endPosition, 1.0);
        expect(rangeData.color, Colors.red);
        expect(rangeData.label, isNull);
        expect(rangeData.startValueLabel, isNull);
        expect(rangeData.endValueLabel, isNull);
      });

      test('throws assertion error for invalid startPosition', () {
        expect(
          () => RangeData(
            startPosition: -0.1,
            endPosition: 1.0,
            color: Colors.red,
          ),
          throwsAssertionError,
        );

        expect(
          () => RangeData(
            startPosition: 1.1,
            endPosition: 1.0,
            color: Colors.red,
          ),
          throwsAssertionError,
        );
      });

      test('throws assertion error when startPosition > endPosition', () {
        expect(
          () => RangeData(
            startPosition: 0.8,
            endPosition: 0.2,
            color: Colors.red,
          ),
          throwsAssertionError,
        );
      });
    });

    group('Properties', () {
      test('width returns correct value', () {
        const rangeData = RangeData(
          startPosition: 0.2,
          endPosition: 0.8,
          color: Colors.red,
        );

        expect(rangeData.width, closeTo(0.6, 0.0001));
      });

      test('isValid returns true for valid range', () {
        const rangeData = RangeData(
          startPosition: 0.2,
          endPosition: 0.8,
          color: Colors.red,
        );

        expect(rangeData.isValid, isTrue);
      });

      test('isValid returns false for zero-width range', () {
        const rangeData = RangeData(
          startPosition: 0.5,
          endPosition: 0.5,
          color: Colors.red,
        );

        expect(rangeData.isValid, isFalse);
      });
    });

    group('Equality', () {
      test('equals returns true for identical RangeData', () {
        const rangeData1 = RangeData(
          startPosition: 0.2,
          endPosition: 0.8,
          color: Colors.red,
          label: 'Test',
          startValueLabel: '20.0',
          endValueLabel: '80.0',
          tooltip: 'tooltip',
        );

        const rangeData2 = RangeData(
          startPosition: 0.2,
          endPosition: 0.8,
          color: Colors.red,
          label: 'Test',
          startValueLabel: '20.0',
          endValueLabel: '80.0',
          tooltip: 'tooltip',
        );

        expect(rangeData1, equals(rangeData2));
        expect(rangeData1.hashCode, equals(rangeData2.hashCode));
      });
    });

    group('Point data tests', () {
      test('should create point data correctly', () {
        const pointData = RangeData.point(
          position: 0.5,
          color: Colors.red,
          label: 'Milestone (M1)',
        );

        expect(pointData.startPosition, equals(0.5));
        expect(pointData.endPosition, equals(0.5));
        expect(pointData.isPoint, isTrue);
        expect(pointData.width, equals(0.0));
        expect(pointData.startValueLabel, isNull);
        expect(pointData.endValueLabel, isNull);
        expect(pointData.startValueLabelPosition, isNull);
        expect(pointData.endValueLabelPosition, isNull);
        expect(pointData.isValid, isTrue);
        expect(pointData.label, equals('Milestone (M1)'));
      });

      test('should validate point position', () {
        expect(
          () => RangeData.point(position: -0.1, color: Colors.red),
          throwsAssertionError,
        );
        expect(
          () => RangeData.point(position: 1.1, color: Colors.red),
          throwsAssertionError,
        );
      });

      test('should handle point data equality correctly', () {
        const pointData1 = RangeData.point(
          position: 0.5,
          color: Colors.red,
          label: 'Test (T1)',
        );

        const pointData2 = RangeData.point(
          position: 0.5,
          color: Colors.red,
          label: 'Test (T1)',
        );

        expect(pointData1, equals(pointData2));
        expect(pointData1.hashCode, equals(pointData2.hashCode));
      });

      test('should differentiate point data from range data', () {
        const pointData = RangeData.point(position: 0.5, color: Colors.red);

        const rangeData = RangeData(
          startPosition: 0.5,
          endPosition: 0.5,
          color: Colors.red,
        );

        expect(pointData.isPoint, isTrue);
        expect(rangeData.isPoint, isFalse);
        expect(pointData, isNot(equals(rangeData)));
      });
    });
  });
}
