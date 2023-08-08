import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_tile_widget.dart';
import 'package:cookain/ingredients/presentation/widgets/shimmer_ingredients_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientsListViewWidget extends StatelessWidget {
  const IngredientsListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientsCubit, IngredientsState>(
      builder: (context, state) {
        if (state is IngredientsError) {

          return Center(
            child: Text(
              state.error ?? "unknown error"
            ),
          );

        } else if (state is IngredientsSuccess) {

          if (state.ingredients.isEmpty) {
            return const Center(
              child: Text(
                "Add your ingredients !"
              ),
            );
          }

          return ListView.builder(
            itemCount: state.ingredients.length,
            itemBuilder: (context, index) {
              return IngredientTileWidget(
                ingredient: state.ingredients.values.elementAt(index)
              );
            }
          );
        }

        return const ShimmerIngredientsListViewWidget();
      }
    );
  }
}
