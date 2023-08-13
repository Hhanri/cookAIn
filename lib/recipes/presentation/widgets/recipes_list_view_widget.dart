import 'package:cookain/core/widgets/query_list_view_builder.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_expansion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesListViewWidget extends StatelessWidget {
  const RecipesListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryListViewBuilder<RecipesCubit, RecipeEntity>(
      emptyBuilder: (context) {
        return const Center(child: Text("Add your recipes !"));
      },
      itemBuilder: (context, document) {
        return RecipeExpansionTileWidget(
          recipe: document.data(),
          canMake: document.data().canMake(context.watch<IngredientsCubit>().ingredients)
        );
      }
    );
  }
}
