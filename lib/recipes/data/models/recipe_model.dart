import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({required super.name, required super.ingredients});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'],
      ingredients: (json['ingredients'] as Map<String, dynamic>).map((key, value) => MapEntry(key, IngredientModel.fromJson(value)))
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients.map((key, value) => MapEntry(key, value.toJson()))
    };
  }

  @override
  List<Object?> get props => [name, ingredients];
}