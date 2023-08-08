import 'package:cookain/core/utils/regexp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('RegExp test', () {

    test('123 should be valid', () {
      expect('123'.isValidNumber(), true);
    });

    test('12.3 should be valid', () {
      expect('12.3'.isValidNumber(), true);
    });

    test('1.23 should be valid', () {
      expect('1.23'.isValidNumber(), true);
    });

    test('12.23 should be valid', () {
      expect('1.23'.isValidNumber(), true);
    });

    test('564564812.23 should be valid', () {
      expect('1.23'.isValidNumber(), true);
    });

    test('12.234 should NOT be valid', () {
      expect('1.23'.isValidNumber(), true);
    });

    test('12.234564654 should NOT be valid', () {
      expect('1.23'.isValidNumber(), true);
    });

    test('123. should NOT be valid', () {
      expect('123.'.isValidNumber(), false);
    });

    test('.123 should NOT be valid', () {
      expect('.123'.isValidNumber(), false);
    });

    test('.1.23 should NOT be valid', () {
      expect('.1.23'.isValidNumber(), false);
    });

    test('.1.2.3. should NOT be valid', () {
      expect('.1.2.3.'.isValidNumber(), false);
    });

    test(' should NOT be valid', () {
      expect(''.isValidNumber(), false);
    });

    test('  should NOT be valid', () {
      expect(' '.isValidNumber(), false);
    });

    test('one should NOT be valid', () {
      expect('one'.isValidNumber(), false);
    });
  });

}