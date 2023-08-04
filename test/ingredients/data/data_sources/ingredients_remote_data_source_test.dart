import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fsi = FakeFirebaseFirestore();
  final fai = MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
      isAnonymous: true,
      uid: 'uuid123456789',
      email: 'test@test.com',
      displayName: 'test test'
    )
  );
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);

  const ingredient = IngredientModel(name: 'Apple', quantity: 2, unit: null);
  const editedIngredient = IngredientModel(name: 'Apple', quantity: 4, unit: null);
  const int quantityToRemove = 2;
  const int quantityToAdd = 3;

  const afterAdding = '''{
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

  const afterEditing = '''{
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

  const afterAddingQuantity = '''{
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

  const afterRemovingQuantity = '''{
  "ingredients": {
    "uuid123456789": {
      "Apple": {
        "name": "Apple",
        "quantity": 5,
        "unit": null
      }
    }
  }
}''';

  const afterDeleting = '''{
  "ingredients": {
    "uuid123456789": {}
  }
}''';

  test('delete non existing ingredient', () async {
    final call = dataSource.removeIngredient(ingredientName: ingredient.name);
    expect(() => call, throwsA(const TypeMatcher<Failure>()));
  });

  test('edit non existing ingredient', () async {
    final call = dataSource.editIngredient(ingredient: editedIngredient);
    expect(() => call, throwsA(const TypeMatcher<Failure>()));
  });
  
  test('add quantity on non existing ingredient', () async {
    final call = dataSource.addQuantity(ingredientName: ingredient.name, quantityToAdd: 3);
    expect(() => call, throwsA(const TypeMatcher<Failure>()));
  });

  test('remove quantity on non existing ingredient', () async {
    final call = dataSource.removeQuantity(ingredientName: ingredient.name, quantityToRemove: 3);
    expect(() => call, throwsA(const TypeMatcher<Failure>()));
  });

  test('add ingredients no error', () async {
    final res = await dataSource.addIngredient(ingredient: ingredient);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterAdding);
  });

  test('edit existing ingredient', () async {
    final res = await dataSource.editIngredient(ingredient: editedIngredient);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterEditing);
  });

  test('add quantity on existing ingredient', () async {
    final res = await dataSource.addQuantity(ingredientName: ingredient.name, quantityToAdd: quantityToAdd);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterAddingQuantity);
  });

  test('remove quantity on existing ingredient', () async {
    final res = await dataSource.removeQuantity(ingredientName: ingredient.name, quantityToRemove: quantityToRemove);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterRemovingQuantity);
  });

  test('delete existing ingredient', () async {
    final res = await dataSource.removeIngredient(ingredientName: ingredient.name);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterDeleting);
  });
}