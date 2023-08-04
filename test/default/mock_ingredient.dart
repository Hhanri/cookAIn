import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:dartz/dartz.dart' hide Unit;

const mockIngredient = IngredientModel(name: 'Apple', quantity: 4, unit: null);
const mockEditedIngredient = IngredientModel(name: 'Apple', quantity: 6, unit: Unit.kg);
const mockQuantityToAdd = 3;
const mockQuantityToRemove = 2;

const mockAfterAdding = '''{
  "ingredients": {
    "uuid123456789": {
      "Apple": {
        "name": "Apple",
        "quantity": 4,
        "unit": null
      }
    }
  }
}''';

const mockAfterAddingQuantity = '''{
  "ingredients": {
    "uuid123456789": {
      "Apple": {
        "name": "Apple",
        "quantity": 7,
        "unit": null
      }
    }
  }
}''';

const mockAfterRemovingQuantity = '''{
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

const mockAfterEditing = '''{
  "ingredients": {
    "uuid123456789": {
      "Apple": {
        "name": "Apple",
        "quantity": 6,
        "unit": "kg"
      }
    }
  }
}''';

const mockAfterDeleting = '''{
  "ingredients": {
    "uuid123456789": {}
  }
}''';