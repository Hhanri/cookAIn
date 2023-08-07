import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fai = mockFAI;
  final fsi = mockFSI;

  final ingredientsDataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final dataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);

  group('recipes remote data source test', () {

    test('add ingredients', () async {
      await ingredientsDataSource.addIngredient(ingredient: _mockApple);
      expect(fsi.dump(), _mockAfterAddingApple);
      await ingredientsDataSource.addIngredient(ingredient: _mockSugar);
      expect(fsi.dump(), _mockAfterAddingSugar);
    });

    test('add recipe', () async {
      await dataSource.addRecipe(_mockRecipe);
      expect(fsi.dump(), _mockAfterAddingRecipe);
    });

    test('edit recipe', () async {
      await dataSource.editRecipe(_mockEditedRecipe);
      expect(fsi.dump(), mockAfterEditingRecipe);
    });

    test('make recipe', () async {
      await dataSource.makeRecipe(_mockEditedRecipe);
      expect(fsi.dump(), mockAfterMakingRecipe);
    });

    test('removing recipe', () async {
      await dataSource.removeRecipe(_mockRecipe.name);
      expect(fsi.dump(), mockAfterRemovingRecipe);
    });

    test('query', () {
      final res = dataSource.recipesQuery();
      expect(res, const TypeMatcher<CollectionReference>());
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

const _mockApple = IngredientModel(name: 'apple', quantity: 4, unit: null);
const _mockSugar = IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g);

const _mockAfterAddingApple = '''{
  "ingredients": {
    "uuid123456789": {
      "apple": {
        "name": "apple",
        "quantity": 4,
        "unit": null
      }
    }
  }
}''';

const _mockAfterAddingSugar = '''{
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

const mockAfterEditingRecipe = '''{
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

const mockAfterMakingRecipe = '''{
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

const mockAfterRemovingRecipe = '''{
  "ingredients": {
    "uuid123456789": {
      "recipes": {},
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