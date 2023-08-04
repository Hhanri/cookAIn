import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_ingredient.dart';
import '../../../default/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);
  final removeIngredientUseCase = RemoveIngredientUseCase(repo);
  final addIngredientUseCase = AddIngredientUseCase(repo);

  const ingredient = mockIngredient;
  const afterAdding = mockAfterAdding;
  const afterDeleting = mockAfterDeleting;

  group('Remove Ingredient Use Case Test', () {

    test('Remove non existing ingredient', () async {
      final res = await removeIngredientUseCase.call(ingredient.name);
      expect(res.isRight(), false);
    });

    test('Remove existing ingredient', () async {
      final res1 = await addIngredientUseCase.call(ingredient);
      expect(res1.isRight(), true);
      expect(fsi.dump(), afterAdding);

      final res = await removeIngredientUseCase.call(ingredient.name);
      expect(res.isRight(), true);
      expect(fsi.dump(), afterDeleting);
    });

  });
}