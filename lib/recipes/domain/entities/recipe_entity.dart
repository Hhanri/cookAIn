import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeEntity extends Equatable {
  final String name;
  final Ingredients ingredients;

  const RecipeEntity({
    required this.name,
    required this.ingredients
  });

  bool canMake(Ingredients availableIngredients) {
    for (final element in ingredients.entries) {
      if (!availableIngredients.containsKey(element.key)) return false;
      if (availableIngredients[element.key]?.unit != element.value.unit) return false;
      if ((availableIngredients[element.key]?.absoluteQuantity ?? 0) < element.value.absoluteQuantity) return false;
    }
    return true;
  }
}