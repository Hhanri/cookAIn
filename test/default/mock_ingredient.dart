import 'package:cookain/ingredients/data/models/ingredient_model.dart';

const mockIngredient = IngredientModel(name: 'Apple', quantity: 2, unit: null);

const mockAfterAdding = '''{
  "ingredients": {
    "uuid123456789": {
      "Apple": {
        "name": "Apple",
        "quantity": 2,
        "unit": null
      }
    }
  }
}''';

const mockAfterDeleting = '''{
  "ingredients": {
    "uuid123456789": {}
  }
}''';