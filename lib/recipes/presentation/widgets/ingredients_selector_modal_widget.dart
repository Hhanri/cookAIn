import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<List<String>?> showIngredientsSelectorModal(BuildContext context) {
  final ingredients = context.read<IngredientsCubit>().ingredients.values.toList();
  Set<String> set = {};
  return showModalBottomSheet<List<String>?>(
    useRootNavigator: true,
    clipBehavior: Clip.hardEdge,
    context: context,
    builder: (context) {
      return Column(
        children: [
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final curr = ingredients[index].name.toTitleCase();
                    return CheckboxListTile(
                      tileColor: Colors.transparent,
                      value: set.contains(curr),
                      onChanged: (value) {
                        if (value == true) {
                          setState(() {
                            set.add(curr);
                          });
                        } else {
                          setState(() {
                            set.remove(curr);
                          });
                        }
                      },
                      title: Text(curr),
                    );
                  }
                );
              }
            ),
          ),
          const SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () {
                final router = GoRouter.of(context);
                if (set.isNotEmpty) return router.pop(set.toList());
                router.pop();
              },
              child: const Text("Select")
            ),
          )
        ],
      );
    }
  );
}