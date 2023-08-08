class MyRegExp {

  MyRegExp._();

  static final RegExp number = RegExp(r'^(\d+)(\.\d{1,2})?$');

}

extension RegexpExtension on String {
  bool isValidNumber() {
    return MyRegExp.number.hasMatch(this);
  }
}
