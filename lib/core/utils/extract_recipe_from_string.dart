import 'dart:convert';

import 'package:cookain/core/utils/string_extensions.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:equatable/equatable.dart';

class TextWithRecipe extends Equatable {

  final RecipeEntity? recipe;
  final String text;

  const TextWithRecipe({
    required this.recipe,
    required this.text
  });

  @override
  List<Object?> get props => [recipe, text];
}

TextWithRecipe textWithRecipeFromString(String input) {
  final recipe = extractRecipeFromString(input);
  if (recipe == null) return TextWithRecipe(recipe: null, text: input);
  final text = formatStringWithRecipe(input, recipe);
  return TextWithRecipe(recipe: recipe, text: text);
}

RecipeEntity? extractRecipeFromString(String? input) {
  try {
    if (input == null) return null;

    final firstBracket = input.indexOf('{');
    if (firstBracket == -1) return null;

    final lastBracket = input.lastIndexOf('}');
    if (lastBracket == -1) return null;

    final subString = input.substring(firstBracket, lastBracket + 1);

    final jsonSubString = jsonDecode(subString);

    final recipe = RecipeModel.fromJson(jsonSubString);
    return recipe;
  } catch (e) {
    return null;
  }
}

String formatStringWithRecipe(String text, RecipeEntity recipe) {
  final firstBracket = text.indexOf('{');
  final lastBracket = text.lastIndexOf('}');
  if (firstBracket == -1 || lastBracket == -1) return text;

  final firstPart = text.substring(0, firstBracket);
  final lastPart = text.substring(lastBracket+1);
  final middlePart = formatRecipeToString(recipe);

  return "$firstPart$middlePart$lastPart";
}

String formatRecipeToString(RecipeEntity recipe) {
  String output = "${recipe.name.toTitleCase()}:\n\n";
  for (final value in recipe.ingredients.values) {
    output += "${value.name.toTitleCase()}: ${value.quantity}${value.unit?.name ?? ""}\n";
  }
  return output.trim();
}