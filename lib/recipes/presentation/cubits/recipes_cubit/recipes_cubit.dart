import 'dart:async';

import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/use_cases/make_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/recipes_query_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/remove_recipe_use_case.dart';
import 'package:flutter/foundation.dart';

part 'recipes_state.dart';

class RecipesCubit extends FirestoreQueryCubit<RecipeEntity> {
  final RemoveRecipeUseCase removeRecipeUseCase;
  final RecipesQueryUseCase recipesQueryUseCase;
  final MakeRecipeUseCase makeRecipeUseCase;
  RecipesCubit({
    required this.removeRecipeUseCase,
    required this.recipesQueryUseCase,
    required this.makeRecipeUseCase,
    required super.query,
  });

  Future<void> removeRecipe(String recipeName) async {
    final temp = [...docs]..removeWhere((element) => element.data().name == recipeName);
    emit(FirestoreQueryLoaded(docs: temp));
    final res = await removeRecipeUseCase.call(recipeName);
    res.fold(
      (failure) => emit(RecipesError(error: failure.message ?? "unknown error")),
      (success) => null
    );
  }

  Future<void> makeRecipe(RecipeEntity recipe) async {
    final res = await makeRecipeUseCase.call(recipe);
    res.fold(
      (failure) => emit(RecipesError(error: failure.message ?? "unknown error")),
      (success) => null
    );
  }
}
