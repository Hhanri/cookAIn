import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/ingredients_stream_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final fsi = mockFSI;
  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);

  final ingredientsStreamUseCase = IngredientsStreamUseCase(repo);
  final removeIngredientUseCase = RemoveIngredientUseCase(repo);
  final addIngredientQuantityUseCase = AddIngredientQuantityUseCase(repo);
  final removeIngredientQuantityUseCase = RemoveIngredientQuantityUseCase(repo);

  final addIngredientUseCase = AddIngredientUseCase(repo);

  final cubit = IngredientsCubit(
    ingredientsStreamUseCase: ingredientsStreamUseCase,
    removeIngredientUseCase: removeIngredientUseCase,
    addIngredientQuantityUseCase: addIngredientQuantityUseCase,
    removeIngredientQuantityUseCase: removeIngredientQuantityUseCase
  );

  group('ingredients cubit test', () {

    test('initial state', () {
      expect(cubit.state, const IngredientsInitial());
    });

    test('start stream', () async {
      cubit.init();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(cubit.state, const IngredientsSuccess(ingredients: {}));
    });

    test('add ingredient', () async {
      const ingredient = IngredientModel(name: 'apple', quantity: 50, unit: null);
      final res = await addIngredientUseCase.call(ingredient);
      expect(res.isRight(), true);
      expect(cubit.state, IngredientsSuccess(ingredients: {ingredient.name: ingredient}));
    });

    test('remove ingredient', () async {
      await cubit.removeIngredient('apple');
      expect(cubit.state, const IngredientsSuccess(ingredients: {}));
    });

  });
}