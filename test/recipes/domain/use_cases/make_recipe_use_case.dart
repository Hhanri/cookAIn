import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/data/repository/recipe_repository_implementation.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/make_recipe_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {
  final fsi = mockFSI;
  final fai = mockFAI;

  final recipeDataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);
  final ingredientsDataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);

  final recipeRepo = RecipeRepositoryImplementation(dataSource: recipeDataSource);
  final ingredientsRepo = IngredientsRepositoryImplementation(ingredientsDataSource);

  final addRecipeUseCase = AddRecipeUseCase(recipeRepo);
  final addIngredientUseCase = AddIngredientUseCase(ingredientsRepo);
  final makeRecipeUseCase = MakeRecipeUseCase(recipeRepo);

  group('Remove Recipe Use Case test', () {

    test('Add ingredients and recipe', () async {
      await addIngredientUseCase(_mockApple);
      await addIngredientUseCase(_mockSugar);
      expect(fsi.dump(), _mockAfterAddingIngredients);
      await addRecipeUseCase(_mockRecipe);
      expect(fsi.dump(), _mockAfterAddingRecipe);
    });

    test('Make Recipe', () async {
      final res = await makeRecipeUseCase.call(_mockRecipe);
      expect(res.isRight(), true);
      expect(fsi.dump(), _mockAfterMakingRecipe);
    });

  });
}

const _mockApple = IngredientModel(name: 'apple', quantity: 4, unit: null);
const _mockSugar = IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g);

const RecipeModel _mockRecipe = RecipeModel(
  name: 'apple pie',
  ingredients: {
    'apple': IngredientModel(name: 'apple', quantity: 2, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 25, unit: Unit.g),
  }
);

const _mockAfterAddingIngredients = '''{
  "ingredients": {
    "uuid123456789": {
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
}''';

const _mockAfterAddingRecipe = '''{
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
      },
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
}''';

const _mockAfterMakingRecipe = '''{
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
      },
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
}''';