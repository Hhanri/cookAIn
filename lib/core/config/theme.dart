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
      shape: MyShapes.roundedRectangleBorder
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: MyShapes.roundedRectangleBorder,
      collapsedShape: MyShapes.roundedRectangleBorder,
      childrenPadding: MyShapes.padding,
      backgroundColor: MyTheme.scheme.secondaryContainer,
      clipBehavior: Clip.hardEdge
    ),
    navigationBarTheme: const NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected
    )
  );
}

class MyShapes {

  MyShapes._();

  static final circularBorderRadius = BorderRadius.circular(12);

  static final roundedRectangleBorder = RoundedRectangleBorder(borderRadius: circularBorderRadius);

  static const padding = EdgeInsets.all(8);
}