import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';

const RecipeModel mockRecipe = RecipeModel(
  name: 'apple pie',
  ingredients: {
    'apple': IngredientModel(name: 'apple', quantity: 4, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g),
  }
);

const RecipeModel mockEditedRecipe = RecipeModel(
  name: 'apple pie',
  ingredients: {
    'apple': IngredientModel(name: 'apple', quantity: 2, unit: null),
    'sugar': IngredientModel(name: 'sugar', quantity: 25, unit: Unit.g),
  }
);

const mockApple = IngredientModel(name: 'apple', quantity: 4, unit: null);
const mockSugar = IngredientModel(name: 'sugar', quantity: 50, unit: Unit.g);

const mockAfterAddingApple = '''{
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

const mockAfterAddingSugar = '''{
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

const mockAfterAddingRecipe = '''{
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