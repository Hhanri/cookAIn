import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/core/widgets/dismissible_widget.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeExpansionTileWidget extends StatelessWidget {
  final RecipeEntity recipe;
  final bool canMake;
  const RecipeExpansionTileWidget({
    Key? key,
    required this.recipe,
    required this.canMake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DismissibleWidget(
      key: Key(recipe.hashCode.toString()),
      onDismissed: () => context.read<RecipesCubit>().removeRecipe(recipe.name),
      child: ExpansionTile(
        leading: canMake
          ? Icon(Icons.check_circle_sharp, color: colorScheme.primary,)
          : Icon(Icons.cancel, color: colorScheme.error,),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(recipe.name.toTitleCase()),
            IconButton(
              onPressed: () => showEditRecipeDialog(context, initialRecipe: recipe),
              icon: const Icon(Icons.edit)
            )
          ],
        ),
        children: recipe
          .ingredients
          .values
          .map(ingredientTextWidget)
          .toList(),
      ),
    );
  }

  Widget ingredientTextWidget(IngredientEntity ingredient) {
    return Row(
      children: [
        Text('  • ${ingredient.name}'),
        Text(ingredient.quantityText)
      ],
    );
  }
}
