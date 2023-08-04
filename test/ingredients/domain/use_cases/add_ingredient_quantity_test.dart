import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/edit_ingredient_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_ingredient.dart';
import '../../../default/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);
  final addIngredientQuantityUseCase = AddIngredientQuantityUseCase(repo);
  final addIngredientUseCase = AddIngredientUseCase(repo);

  const ingredient = mockIngredient;
  const quantityToAdd = mockQuantityToAdd;
  const afterAdding = mockAfterAdding;
  const afterAddingQuantity = mockAfterAddingQuantity;

  group('Add Ingredient Quantity Use Case Test', () {

    test('Add quantity on non existing ingredient', () async {
      final res = await addIngredientQuantityUseCase.call(ingredient.name, quantityToAdd);
      expect(res.isRight(), false);
    });

    test('Add quantity on existing ingredient', () async {
      final res1 = await addIngredientUseCase.call(ingredient);
      expect(res1.isRight(), true);
      expect(fsi.dump(), afterAdding);

      final res = await addIngredientQuantityUseCase.call(ingredient.name, quantityToAdd);
      expect(res.isRight(), true);
      expect(fsi.dump(), afterAddingQuantity);
    });

  });
}