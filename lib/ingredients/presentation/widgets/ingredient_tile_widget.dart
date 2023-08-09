import 'package:cookain/core/utils/string_extensions.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Dismissible(
        background: Container(
          padding: const EdgeInsets.all(8),
          alignment: const Alignment(0.9, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.errorContainer,
          ),
          child: Icon(Icons.delete, color: colorScheme.onErrorContainer,),
        ),
        onUpdate: (DismissUpdateDetails details) {
          if (details.reached && details.progress == 1) context.read<IngredientsCubit>().removeIngredient(ingredient.name);
        },
        behavior: HitTestBehavior.deferToChild,
        direction: DismissDirection.endToStart,
        key: Key(ingredient.hashCode.toString()),
        child: ListTile(
          title: Text(ingredient.name.toTitleCase()),
          subtitle: Text(ingredient.quantityText),
          trailing: IconButton(
            onPressed: () => showEditIngredientDialog(context, initialIngredient: ingredient),
            icon: const Icon(Icons.edit)
          ),
        ),
      ),
    );
  }
}
