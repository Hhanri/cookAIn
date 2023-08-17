import 'package:cookain/core/utils/extract_recipe_from_string.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('extract recipe from string', () {
    const String firstTest = '''{
  "name": "Apple Pie",
  "ingredients": {
    "apple": {
      "name": "apple",
      "quantity": 50,
      "unit": "g"
    }
  }
}''';

    const String secondTest = '''Here is a recipe with the ingredients you gave me:

$firstTest

Hope you will enjoy this !
''';

    const String thirdTest = '''{this is a text that doesn't contain any recipe
}''';

    const String fourthTest = '''{
  "name": Apple Pie,
  "ingredients": {
    "apple": 
      "name": "apple",
      "quantity": 50,
      "unit": g
    }
  }
}''';

    const String fifthTest = '''
Here is a recipe with the ingredients you gave me:

$fourthTest

Hope you will enjoy this !
''';

  const RecipeEntity expectedRecipe = RecipeModel(
    name: "Apple Pie",
    ingredients: {
      "apple" : IngredientModel(
        name: "apple",
        quantity: 50,
        unit: Unit.g
      )
    }
  );


    test('only json should succeed', () {
      final res = extractRecipeFromString(firstTest);
      expect(res, expectedRecipe);
    });

    test('text with valid json should succeed', () {
      final res = extractRecipeFromString(secondTest);
      expect(res, expectedRecipe);
    });

    test('text only should return null', () {
      final res = extractRecipeFromString(thirdTest);
      expect(res, null);
    });

    test('non valid json should return null', () {
      final res = extractRecipeFromString(fourthTest);
      expect(res, null);
    });

    test('text with non valid json should return null', () {
      final res = extractRecipeFromString(fifthTest);
      expect(res, null);
    });

    test('null input should return null', () {
      final res = extractRecipeFromString(null);
      expect(res, null);
    });
  });

  group('format recipe to string', () {

    test('format recipe without unit', () {
      const recipe = RecipeModel(
        name: "apple pie",
        ingredients: {
          "apple": IngredientModel(name: "apple", quantity: 50, unit: null)
        }
      );
      const expected = "Apple Pie:\nApple: 50";
      expect(formatRecipeToString(recipe), expected);
    });

    test('format recipe with unit', () {
      const recipe = RecipeModel(
        name: "apple Pie",
        ingredients: {
          "apple": IngredientModel(name: "apple", quantity: 50, unit: Unit.kg)
        }
      );
      const expected = "Apple Pie:\nApple: 50kg";
      expect(formatRecipeToString(recipe), expected);
    });

    test('format recipe without ingredients', () {
      const recipe = RecipeModel(
        name: "apple Pie",
        ingredients: {}
      );
      const expected = "Apple Pie:\n";
      expect(formatRecipeToString(recipe), expected);
    });
  });

  group('format string with recipe', () {

    test('string with recipe', () {
      const recipe = RecipeModel(
          name: "apple Pie",
          ingredients: {
            "apple": IngredientModel(name: "apple", quantity: 50, unit: Unit.g)
          }
      );
      const String text = '''Here is your recipe:

{
  "name": Apple Pie,
  "ingredients": {
    "apple": 
      "name": "apple",
      "quantity": 50,
      "unit": g
    }
  }
}''';

      const String expected = "Here is your recipe:\n\nApple Pie:\nApple: 50g";
      expect(formatStringWithRecipe(text, recipe), expected);
    });

    test('string with recipe 2', () {
      const recipe = RecipeModel(
          name: "apple Pie",
          ingredients: {
            "apple": IngredientModel(name: "apple", quantity: 50, unit: Unit.g)
          }
      );
      const String text = '''Here is your recipe:

{
  "name": Apple Pie,
  "ingredients": {
    "apple": 
      "name": "apple",
      "quantity": 50,
      "unit": g
    }
  }
}

enjoy your meal !''';

      const String expected = '''Here is your recipe:

Apple Pie:
Apple: 50g

enjoy your meal !''';
      expect(formatStringWithRecipe(text, recipe), expected);
    });

  });

  group('text with recipe from string', () {

    test('text without recipe', () {
      const input = 'test';
      final res = textWithRecipeFromString(input);
      expect(res.recipe, null);
      expect(res.text, input);
    });

    test('text with valid json but no recipe', () {
      const input = 'test\n{"key": "value"}';
      final res = textWithRecipeFromString(input);
      expect(res.recipe, null);
      expect(res.text, input);
    });

    test('text with invalid json', () {
      const input = 'test\n{"key": lue"}';
      final res = textWithRecipeFromString(input);
      expect(res.recipe, null);
      expect(res.text, input);
    });

    test('text with recipe', () {
      const input = '''Here is your recipe:

{
  "name": "Apple Pie",
  "ingredients": {
    "apple": {
      "name": "apple",
      "quantity": 50,
      "unit": "g"
    }
  }
}

enjoy your meal !''';

      const expectedText = '''Here is your recipe:

Apple Pie:
Apple: 50g

enjoy your meal !''';

      const expectedRecipe = RecipeModel(
        name: "Apple Pie",
        ingredients: {
          "apple": IngredientModel(name: "apple", quantity: 50, unit: Unit.g)
        }
      );

      final res = textWithRecipeFromString(input);
      expect(
        res,
        const TextWithRecipe(recipe: expectedRecipe, text: expectedText)
      );
    });
  });

}


