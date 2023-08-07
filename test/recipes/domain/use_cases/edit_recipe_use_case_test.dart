import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/data/repository/recipe_repository_implementation.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/edit_recipe_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {
  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);
  final repo = RecipeRepositoryImplementation(dataSource: dataSource);
  final addUseCase = AddRecipeUseCase(repo);
  final editUseCase = EditRecipeUseCase(repo);

  group('Edit Recipe Use Case test', () {

    test('Edit non existing recipe', () async {
      final res = await editUseCase.call(_mockEditedRecipe);
      expect(res.isRight(), false);
    });

    test('Edit an existing recipe', () async {
      await addUseCase.call(_mockRecipe);
      expect(fsi.dump(), _mockAfterAddingRecipe);
      final res = await editUseCase.call(_mockEditedRecipe);
      expect(res.isRight(), true);
      expect(fsi.dump(), _mockAfterEditingRecipe);
    });

  });
}

const RecipeModel _mockRecipe = RecipeModel(
  name: 'apple pie',
  ingredients: {
    'apple': IngredientModel(name: 'apple', quantity: 4, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g),
  }
);

const RecipeModel _mockEditedRecipe = RecipeModel(
  name: 'apple pie',
  ingredients: {
    'apple': IngredientModel(name: 'apple', quantity: 2, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 25, unit: Unit.g),
  }
);

const _mockAfterAddingRecipe = '''{
  "ingredients": {
    "uuid123456789": {
      "recipes": {
        "apple pie": {
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
        }
      }
    }
  }
}''';

const _mockAfterEditingRecipe = '''{
  "ingredients": {
    "uuid123456789": {
      "recipes": {
        "apple pie": {
          "name": "apple pie",
          "ingredients": {
            "apple": {
              "name": "apple",
              "quantity": 2,
              "unit": null
            },
            "sugar": {
              "name": "sugar",
              "quantity": 25,
              "unit": "g"
            }
          }
        }
      }
    }
  }
}''';