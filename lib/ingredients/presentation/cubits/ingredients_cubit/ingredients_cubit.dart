import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/ingredients_stream_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ingredients_state.dart';

class IngredientsCubit extends Cubit<IngredientsState> {

  final IngredientsStreamUseCase ingredientsStreamUseCase;
  final RemoveIngredientUseCase removeIngredientUseCase;
  final AddIngredientQuantityUseCase addIngredientQuantityUseCase;
  final RemoveIngredientQuantityUseCase removeIngredientQuantityUseCase;

  StreamSubscription<DocumentSnapshot<Ingredients>>? ingredientsStream;

  IngredientsCubit({
    required this.ingredientsStreamUseCase,
    required this.removeIngredientUseCase,
    required this.addIngredientQuantityUseCase,
    required this.removeIngredientQuantityUseCase,
  }) : super(const IngredientsInitial());

  late Ingredients ingredients;

  void init() {
    ingredientsStream = ingredientsStreamUseCase.call().listen((event) {
      ingredients = event.data() ?? const {};
      emit(IngredientsSuccess(ingredients: ingredients));
    });
  }

  Future<void> removeIngredient(String ingredientName) async {
    emit(state.copyWith(ingredients: {...ingredients}..remove(ingredientName)));
    final res = await removeIngredientUseCase.call(ingredientName);
    res.fold(
      (failure) => emit(IngredientsError(ingredients: ingredients, error: failure.message)),
      (success) => null
    );
  }

  @override
  Future<void> close() async {
    ingredientsStream?.cancel();
    return super.close();
  }

}
