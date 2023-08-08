import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerIngredientsListViewWidget extends StatelessWidget {
  const ShimmerIngredientsListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Colors.white54,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const IngredientTileWidget(
            ingredient: IngredientModel(
              name: 'name',
              quantity: 0,
              unit: null
            )
          );
        }
      ),
    );
  }
}
