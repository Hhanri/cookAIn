import 'package:cookain/core/utils/extract_recipe_from_string.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('extract recipe from string', () {

    test('only json should succeed', () {
      final res = extractRecipeFromString(_firstTest);
      expect(res, _expectedRecipe);
    });

    test('text with valid json should succeed', () {
      final res = extractRecipeFromString(_secondTest);
      expect(res, _expectedRecipe);
    });

    test('text only should return null', () {
      final res = extractRecipeFromString(_thirdTest);
      expect(res, null);
    });

    test('non valid json should return null', () {
      final res = extractRecipeFromString(_fourthTest);
      expect(res, null);
    });

    test('text with non valid json should return null', () {
      final res = extractRecipeFromString(_fourthTest);
      expect(res, null);
    });
  });
}
const RecipeEntity _expectedRecipe = RecipeModel(
  name: "Apple Pie",
  ingredients: {
    "apple" : IngredientModel(
      name: "apple",
      quantity: 50,
      unit: Unit.g
    )
  }
);

const String _firstTest = '''{
  "name": "Apple Pie",
  "ingredients": {
    "apple": {
      "name": "apple",
      "quantity": 50,
      "unit": "g"
    }
  }
}''';

const String _secondTest = '''
Here is a recipe with the ingredients you gave me:

$_firstTest

Hope you will enjoy this !
''';

const String _thirdTest = '''{
this is a text that doesn't contain any recipe
}''';

const String _fourthTest = '''{
  "name": Apple Pie,
  "ingredients": {
    "apple": 
      "name": "apple",
      "quantity": 50,
      "unit": g
    }
  }
}''';

const String _fifthTest = '''
Here is a recipe with the ingredients you gave me:

$_fourthTest

Hope you will enjoy this !
''';