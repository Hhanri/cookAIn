import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/edit_ingredient_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_ingredient.dart';
import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);
  final editIngredientUseCase = EditIngredientUseCase(repo);
  final addIngredientUseCase = AddIngredientUseCase(repo);

  const ingredient = mockIngredient;
  const editedIngredient = mockEditedIngredient;
  const afterAdding = mockAfterAdding;
  const afterEditing = mockAfterEditing;

  group('Edit Ingredient Use Case Test', () {

    test('Edit non existing ingredient', () async {
      final res = await editIngredientUseCase.call(ingredient);
      expect(res.isRight(), false);
    });

    test('Edit existing ingredient', () async {
      final res1 = await addIngredientUseCase.call(ingredient);
      expect(res1.isRight(), true);
      expect(fsi.dump(), afterAdding);

      final res = await editIngredientUseCase.call(editedIngredient);
      expect(res.isRight(), true);
      expect(fsi.dump(), afterEditing);
    });

  });
}