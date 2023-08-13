import 'package:cookain/core/config/theme.dart';
import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:flutter/material.dart';

class RecipeExpansionTileWidget extends StatelessWidget {
  final RecipeEntity recipe;
  final bool canMake;
  const RecipeExpansionTileWidget({Key? key, required this.recipe, required this.canMake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: MyShapes.padding,
      child: ExpansionTile(
        leading: canMake
          ? Icon(Icons.check_circle_sharp, color: colorScheme.primary,)
          : Icon(Icons.cancel, color: colorScheme.error,),
        title:
        Text(recipe.name.toTitleCase()),
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
