import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/core/widgets/dismissible_widget.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientTileWidget extends StatelessWidget {
  final IngredientEntity ingredient;
  const IngredientTileWidget({Key? key, required this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissibleWidget(
      key: Key(ingredient.hashCode.toString()),
      onDismissed: () {
        context.read<IngredientsCubit>().removeIngredient(ingredient.name);
      },
      child: ListTile(
        title: Text(ingredient.name.toTitleCase()),
        subtitle: Text(ingredient.quantityText),
        trailing: IconButton(
          onPressed: () => showEditIngredientDialog(context, initialIngredient: ingredient),
          icon: const Icon(Icons.edit)
        ),
      ),
    );
  }
}
