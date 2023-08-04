import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_ingredient.dart';
import '../../../default/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);
  final useCase = AddIngredientUseCase(repo);

  const ingredient = mockIngredient;

  const afterAdding = mockAfterAdding;

  group('Add Ingredient Use Case Test', () {

    test('Add ingredient no error', () async {
      final res = await useCase.call(ingredient);
      expect(res.isRight(), true);
      expect(fsi.dump(), afterAdding);
    });

  });
}