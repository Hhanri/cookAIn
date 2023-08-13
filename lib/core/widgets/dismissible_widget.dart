import 'package:cookain/core/config/theme.dart';
import 'package:flutter/material.dart';

class DismissibleWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismissed;
  const DismissibleWidget({
    required super.key,
    required this.child,
    required this.onDismissed
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: MyShapes.padding,
      child: Dismissible(
        key: key!,
        background: Container(
          padding: MyShapes.padding,
          alignment: const Alignment(0.9, 0),
          decoration: BoxDecoration(
            borderRadius: MyShapes.circularBorderRadius,
            color: colorScheme.errorContainer,
          ),
          child: Icon(Icons.delete, color: colorScheme.onErrorContainer,),
        ),
        behavior: HitTestBehavior.deferToChild,
        direction: DismissDirection.endToStart,
        onUpdate: (DismissUpdateDetails details) {
          if (details.reached && details.progress == 1) onDismissed();
        },
        child: child
      ),
    );
  }
}
