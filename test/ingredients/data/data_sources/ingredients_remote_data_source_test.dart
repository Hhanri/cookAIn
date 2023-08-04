import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_ingredient.dart';
import '../../../default/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);

  const ingredient = mockIngredient;
  const editedIngredient = mockEditedIngredient;
  const int quantityToRemove = mockQuantityToRemove;
  const int quantityToAdd = mockQuantityToAdd;

  const afterAdding = mockAfterAdding;

  const afterEditing = mockAfterEditing;

  const afterAddingQuantity = mockAfterAddingQuantity;

  const afterRemovingQuantity = mockAfterRemovingQuantity;

  const afterDeleting = mockAfterDeleting;

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

  test('add quantity on existing ingredient', () async {
    final res = await dataSource.addQuantity(ingredientName: ingredient.name, quantityToAdd: quantityToAdd);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterAddingQuantity);
  });

  test('reset ingredient', () async {
    final res = await dataSource.editIngredient(ingredient: ingredient);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterAdding);
  });

  test('remove quantity on existing ingredient', () async {
    final res = await dataSource.removeQuantity(ingredientName: ingredient.name, quantityToRemove: quantityToRemove);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterRemovingQuantity);
  });

  test('edit existing ingredient', () async {
    final res = await dataSource.editIngredient(ingredient: editedIngredient);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterEditing);
  });

  test('delete existing ingredient', () async {
    final res = await dataSource.removeIngredient(ingredientName: ingredient.name);
    expect(res, const TypeMatcher<Success>());
    expect(fsi.dump(), afterDeleting);
  });
}