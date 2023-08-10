import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();

  static final scheme = ColorScheme.fromSeed(seedColor: Colors.green);

  static final data = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    listTileTheme: ListTileThemeData(
      tileColor: scheme.secondaryContainer,
      dense: false,
      visualDensity: VisualDensity.comfortable,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    ),
    navigationBarTheme: const NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected
    )
  );
}