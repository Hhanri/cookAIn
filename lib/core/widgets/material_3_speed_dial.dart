import 'package:cookain/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Material3SpeedDial extends StatelessWidget {
  final List<MySpeedDialChild> children;
  const Material3SpeedDial({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      iconTheme: Theme.of(context).iconTheme,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      spacing: 16,
      childMargin: EdgeInsets.zero,
      childPadding: const EdgeInsets.all(8.0),
      animatedIcon: AnimatedIcons.menu_close,
      children: children
        .map((e) {
          return SpeedDialChild(
            backgroundColor: MyTheme.scheme.primaryContainer,
            labelBackgroundColor: MyTheme.scheme.primaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            label: e.label?.call(),
            onTap: e.onTap,
            child: e.child
          );
        }).toList()
    );
  }
}

class MySpeedDialChild {
  final VoidCallback onTap;
  final String Function()? label;
  final Widget child;

  MySpeedDialChild({
    required this.onTap,
    required this.label,
    required this.child,
  });
}