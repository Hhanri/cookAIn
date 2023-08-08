import 'package:cookain/core/utils/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('capitalizing test', () {

    test('Hello World should return Hello World', () {
      expect("Hello World".toCapitalized(), "Hello world");
    });

    test('hello World should return Hello world', () {
      expect("hello World".toCapitalized(), "Hello world");
    });

    test('helloworld should return Helloworld', () {
      expect("helloworld".toCapitalized(), "Helloworld");
    });

    test('HELLOWORLD should return Helloworld', () {
      expect("HELLOWORLD".toCapitalized(), "Helloworld");
    });

    test('heLLOwOrLd should return Helloworld', () {
      expect("heLLOwOrLd".toCapitalized(), "Helloworld");
    });

  });

  group('titling test', () {

    test('Hello World should return Hello World', () {
      expect("Hello World".toTitleCase(), "Hello World");
    });

    test('hello World should return Hello World', () {
      expect("hello World".toTitleCase(), "Hello World");
    });

    test('hello woRlD should return Hello World', () {
      expect("hello woRlD".toTitleCase(), "Hello World");
    });

    test('helloworld should return Helloworld', () {
      expect("helloworld".toTitleCase(), "Helloworld");
    });

    test('HELLOWORLD should return Helloworld', () {
      expect("HELLOWORLD".toTitleCase(), "Helloworld");
    });

    test('heLLOwOrLd should return Helloworld', () {
      expect("heLLOwOrLd".toTitleCase(), "Helloworld");
    });

  });

}