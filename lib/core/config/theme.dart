import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();

  static final data = ThemeData(
    useMaterial3: true,
    //scaffoldBackgroundColor: Colors.green.shade50,
    colorSchemeSeed: Colors.green,
    listTileTheme: ListTileThemeData(
      tileColor: Colors.green.shade50,
      dense: false,
      visualDensity: VisualDensity.comfortable,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    )
  );
}