import 'dart:convert';

import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';

RecipeEntity? extractRecipeFromString(String input) {
  try {
    final firstBracket = input.indexOf('{');
    if (firstBracket == -1) return null;

    final lastBracket = input.lastIndexOf('}');
    if (lastBracket == -1) return null;

    final subString = input.substring(firstBracket, lastBracket + 1);
    print(subString);
    final jsonSubString = jsonDecode(subString);
    print(jsonSubString);
    final recipe = RecipeModel.fromJson(jsonSubString);
    return recipe;
  } catch (e) {
    print(e);
    return null;
  }
}