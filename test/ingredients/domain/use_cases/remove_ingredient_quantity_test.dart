import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_ingredient.dart';
import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);
  final removeIngredientQuantityUseCase = RemoveIngredientQuantityUseCase(repo);
  final addIngredientUseCase = AddIngredientUseCase(repo);

  const ingredient = mockIngredient;
  const quantityToRemove = mockQuantityToRemove;
  const afterAdding = mockAfterAdding;
  const afterRemovingQuantity = mockAfterRemovingQuantity;

  group('Remove Ingredient Quantity Use Case Test', () {

    test('Remove quantity on non existing ingredient', () async {
      final res = await removeIngredientQuantityUseCase.call(ingredient.name, quantityToRemove);
      expect(res.isRight(), false);
    });

    test('Remove quantity on existing ingredient', () async {
      final res1 = await addIngredientUseCase.call(ingredient);
      expect(res1.isRight(), true);
      expect(fsi.dump(), afterAdding);

      final res = await removeIngredientQuantityUseCase.call(ingredient.name, quantityToRemove);
      expect(res.isRight(), true);
      expect(fsi.dump(), afterRemovingQuantity);
    });

  });
}