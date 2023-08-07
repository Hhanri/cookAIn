import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const RecipeModel recipe = RecipeModel(
    name: 'apple pie',
    ingredients: {
      'apple': IngredientModel(name: 'apple', quantity: 4, unit: null),
      'sugar': IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g),
    }
  );

  const Map<String, dynamic> json = {
    "name": "apple pie",
    "ingredients": {
      "apple": {
        "name": "apple",
        "quantity": 4,
        "unit": null
      },
      "sugar": {
        "name": "sugar",
        "quantity": 50,
        "unit": "g"
      }
    }
  };

  const Map<String, dynamic> json2 = {
    "name": "apple pie",
    "ingredients": {
      "apple": {
        "name": "apple",
        "quantity": 4,
        "unit": null
      },
    }
  };

  const Ingredients enough = {
    'apple': IngredientModel(name: 'apple', quantity: 6, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 200, unit: Unit.g),
  };

  const Ingredients notEnough = {
    'apple': IngredientModel(name: 'apple', quantity: 1, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 20, unit: Unit.g),
  };

  const Ingredients missing = {
    'apple': IngredientModel(name: 'apple', quantity: 5, unit: null),
  };

  const Ingredients wrongUnit = {
    'apple': IngredientModel(name: 'apple', quantity: 1, unit: Unit.kg),
    'sugar': IngredientModel(name: 'sugar', quantity: 20, unit: Unit.L),
  };

  group('recipe model parsing test', () {

    test('to json', () {
      final res = recipe.toJson();
      expect(res, json);
    });

    test('from json', () {
      final res = RecipeModel.fromJson(json);
      expect(res, recipe);
    });

    test('from json2', () {
      final res = RecipeModel.fromJson(json2);
      expect(res == recipe, false);
    });
  });

  group('can make recipe tests', () {

    test('enough ingredients', () {
      final res = recipe.canMake(enough);
      expect(res, true);
    });

    test('not enough ingredients', () {
      final res = recipe.canMake(notEnough);
      expect(res, false);
    });

    test('missing ingredients', () {
      final res = recipe.canMake(missing);
      expect(res, false);
    });

    test('wrong unit', () {
      final res = recipe.canMake(wrongUnit);
      expect(res, false);
    });
  });
}