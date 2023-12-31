import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/data/repository/recipe_repository_implementation.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/make_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/recipes_query_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/remove_recipe_use_case.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);
  final repo = RecipeRepositoryImplementation(dataSource);

  final addRecipeUseCase = AddRecipeUseCase(repo);
  final removeRecipeUseCase = RemoveRecipeUseCase(repo);
  final recipesQueryUseCase = RecipesQueryUseCase(repo);
  final makeRecipeUseCase = MakeRecipeUseCase(repo);

  final ingredientDataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final ingredientsRepo = IngredientsRepositoryImplementation(ingredientDataSource);
  final addIngredientUseCase = AddIngredientUseCase(ingredientsRepo);

  final cubit = RecipesCubit(
    removeRecipeUseCase: removeRecipeUseCase,
    recipesQueryUseCase: recipesQueryUseCase,
    makeRecipeUseCase: makeRecipeUseCase,
    query: recipesQueryUseCase.call()
  );

  group('add ingredient cubit test', () {

    const recipe = RecipeModel(
      name: 'apple pie',
      ingredients: {
        'apple': IngredientModel(name: 'apple', quantity: 50, unit: Unit.kg)
      }
    );

    test('initial state', () {
      expect(
        cubit.state,
        const FirestoreQueryInitial<RecipeEntity>()
      );
    });

    test('init with no document', () async {
      cubit.fetchMore();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(
        cubit.state,
        const FirestoreQueryEmpty<RecipeEntity>()
      );
    });

    test('check state with document', () async {

      final add = await addRecipeUseCase.call(recipe);
      expect(add.isRight(), true);
      await Future.delayed(const Duration(milliseconds: 50));
      expect(
        cubit.state,
        const TypeMatcher<FirestoreQueryLoaded<RecipeEntity>>()
      );
      expect(
        cubit.docs.length,
        1
      );
    });

    test('make recipe', () async {
      await addIngredientUseCase.call(recipe.ingredients.values.first);
      await cubit.makeRecipe(recipe);
      await Future.delayed(const Duration(milliseconds: 50));
      expect(
        cubit.state,
        const TypeMatcher<FirestoreQueryLoaded<RecipeEntity>>()
      );
    });

    test('delete recipe', () async {
      await cubit.removeRecipe('apple pie');
      await Future.delayed(const Duration(milliseconds: 50));
      expect(
        cubit.state,
        const FirestoreQueryEmpty<RecipeEntity>()
      );
    });

  });

}