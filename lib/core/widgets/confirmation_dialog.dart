import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  String title = "Are you sure ?",
  required String description,
  required VoidCallback? onValidate,
}) async {
  return await showDialog<bool?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: GoRouter.of(context).pop,
            child: const Text("Cancel")
          ),
          FilledButton(
            onPressed: () {
              onValidate?.call();
              GoRouter.of(context).pop(true);
            },
            child: const Text("Yes")
          ),
        ],
      );
    }
  );
}