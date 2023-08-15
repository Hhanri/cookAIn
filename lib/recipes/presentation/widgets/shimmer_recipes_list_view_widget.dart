import 'package:cookain/core/widgets/shimmer_widget.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_expansion_tile_widget.dart';
import 'package:flutter/material.dart';

class ShimmerRecipesListViewWidget extends StatelessWidget {
  const ShimmerRecipesListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const RecipeExpansionTileWidget(
            recipe: RecipeModel(
              name: 'name',
              ingredients: {}
            ),
            canMake: false,
          );
        }
      ),
    );
  }
}
