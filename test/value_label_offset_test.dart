import 'package:flutter_test/flutter_test.dart';
import 'package:range_bar/range_bar.dart';

void main() {
  group('ValueLabelOffset', () {
    test('creates ValueLabelOffset with default values', () {
      const offset = ValueLabelOffset(
        position: IndividualValueLabelPosition.above,
      );

      expect(offset.position, IndividualValueLabelPosition.above);
      expect(offset.vertical, 0.0);
      expect(offset.horizontal, 0.0);
    });

    test('creates ValueLabelOffset with custom values', () {
      const offset = ValueLabelOffset(
        position: IndividualValueLabelPosition.below,
        vertical: 10.0,
        horizontal: 5.0,
      );

      expect(offset.position, IndividualValueLabelPosition.below);
      expect(offset.vertical, 10.0);
      expect(offset.horizontal, 5.0);
    });

    test('creates ValueLabelOffset.above with custom values', () {
      const offset = ValueLabelOffset.above(vertical: 10.0, horizontal: 5.0);

      expect(offset.position, IndividualValueLabelPosition.above);
      expect(offset.vertical, 10.0);
      expect(offset.horizontal, 5.0);
    });

    test('creates ValueLabelOffset.above with default values', () {
      const offset = ValueLabelOffset.above();

      expect(offset.position, IndividualValueLabelPosition.above);
      expect(offset.vertical, 0.0);
      expect(offset.horizontal, 0.0);
    });

    test('creates ValueLabelOffset.below with custom values', () {
      const offset = ValueLabelOffset.below(vertical: -5.0, horizontal: 10.0);

      expect(offset.position, IndividualValueLabelPosition.below);
      expect(offset.vertical, -5.0);
      expect(offset.horizontal, 10.0);
    });

    test('creates ValueLabelOffset.below with default values', () {
      const offset = ValueLabelOffset.below();

      expect(offset.position, IndividualValueLabelPosition.below);
      expect(offset.vertical, 0.0);
      expect(offset.horizontal, 0.0);
    });

    test('creates ValueLabelOffset.center with custom values', () {
      const offset = ValueLabelOffset.center(vertical: 2.0, horizontal: -3.0);

      expect(offset.position, IndividualValueLabelPosition.center);
      expect(offset.vertical, 2.0);
      expect(offset.horizontal, -3.0);
    });

    test('creates ValueLabelOffset.center with default values', () {
      const offset = ValueLabelOffset.center();

      expect(offset.position, IndividualValueLabelPosition.center);
      expect(offset.vertical, 0.0);
      expect(offset.horizontal, 0.0);
    });

    test('creates ValueLabelOffset.custom with required values', () {
      const offset = ValueLabelOffset.custom(vertical: 15.0, horizontal: -10.0);

      expect(offset.position, IndividualValueLabelPosition.custom);
      expect(offset.vertical, 15.0);
      expect(offset.horizontal, -10.0);
    });
  });

  group('ValueLabelPosition enum', () {
    test('has all expected values', () {
      expect(ValueLabelPosition.values, hasLength(5));
      expect(
        ValueLabelPosition.values,
        contains(IndividualValueLabelPosition.above),
      );
      expect(
        ValueLabelPosition.values,
        contains(IndividualValueLabelPosition.below),
      );
      expect(
        ValueLabelPosition.values,
        contains(IndividualValueLabelPosition.center),
      );
      expect(ValueLabelPosition.values, contains(ValueLabelPosition.none));
      expect(
        ValueLabelPosition.values,
        contains(IndividualValueLabelPosition.custom),
      );
    });
  });
}
