import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:flutter/material.dart';

class IngredientTileWidget extends StatelessWidget {
  final IngredientEntity ingredient;
  const IngredientTileWidget({Key? key, required this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(ingredient.name.toTitleCase()),
        subtitle: Text(ingredient.quantityText),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit)
        ),
      ),
    );
  }
}
