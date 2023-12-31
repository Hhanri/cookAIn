import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/data/repository/recipe_repository_implementation.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/presentation/cubits/add_recipe_cubit/add_recipe_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/generic_dialog_recipe_cubit/generic_dialog_recipe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);
  final repo = RecipeRepositoryImplementation(dataSource);

  final addRecipeUseCase = AddRecipeUseCase(repo);

  group('add recipe cubit test', () {
    final cubit = AddRecipeCubit(useCase: addRecipeUseCase);

    test('initial state', () {
      expect(
        cubit.state,
        const GenericDialogRecipeLoading(
          units: [],
          nameControllers: [],
          quantityControllers: [],
          length: 0
        )
      );
    });

    test('init', () {
      cubit.init();
      expect(
        cubit.state.units,
        [Unit.kg]
      );
      expect(
        cubit.state.nameControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.quantityControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.length,
        1
      );
    });

    test('change unit', () {
      cubit.changeUnit(Unit.g, 0);
      expect(
        cubit.state.units,
        [Unit.g]
      );
      expect(
        cubit.state.nameControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.quantityControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.length,
        1
      );
    });

    test('upload', () async {
      cubit.recipeNameController.text = 'apple pie';
      cubit.nameControllers[0].text = 'apple';
      cubit.quantityControllers[0].text = '5';
      cubit.changeUnit(Unit.kg, 0);

      expectLater(cubit.stream, emitsInOrder([
        const TypeMatcher<GenericDialogRecipeLoading>(),
        const TypeMatcher<GenericDialogRecipeLoaded>(),
      ]));

      final res = await cubit.upload();
      expect(res, true);
    });

    test('upload with wrong input format', () async {
      cubit.recipeNameController.text = 'apple pie';
      cubit.nameControllers[0].text = 'apple';
      cubit.quantityControllers[0].text = '5..';
      cubit.changeUnit(Unit.kg, 0);

      final call = cubit.upload();
      expect(() => call, throwsA(const TypeMatcher<FormatException>()));
      expect(cubit.state, const TypeMatcher<GenericDialogRecipeLoading>(),);
    });

  });

  group('add recipe with initial recipe cubit test', () {
    const initialRecipe = RecipeModel(
      name: "Apple Pie",
      ingredients: {
        "apple": IngredientModel(name: "apple", quantity: 50, unit: null)
      }
    );
    final cubit = AddRecipeCubit(
      useCase: addRecipeUseCase,
      initialRecipe: initialRecipe
    );

    test('initial state', () {
      expect(
        cubit.state,
        const GenericDialogRecipeLoading(
          units: [],
          nameControllers: [],
          quantityControllers: [],
          length: 0
        )
      );
    });

    test('init', () {
      cubit.init();
      expect(
        cubit.state.units,
        [null]
      );
      expect(cubit.recipeNameController.text, initialRecipe.name);
      expect(
        cubit.state.nameControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.nameControllers[0].text,
        initialRecipe.ingredients.values.first.name
      );
      expect(
        cubit.state.quantityControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.quantityControllers[0].text,
        initialRecipe.ingredients.values.first.quantity.toString()
      );
      expect(
        cubit.state.length,
        1
      );
    });

    test('change unit', () {
      cubit.changeUnit(Unit.g, 0);
      expect(
        cubit.state.units,
        [Unit.g]
      );
      expect(
        cubit.state.nameControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.nameControllers[0].text,
        initialRecipe.ingredients.values.first.name
      );
      expect(
        cubit.state.quantityControllers,
        [const TypeMatcher<TextEditingController>()]
      );
      expect(
        cubit.state.quantityControllers[0].text,
        initialRecipe.ingredients.values.first.quantity.toString()
      );
      expect(
        cubit.state.length,
        1
      );
    });

    test('upload', () async {
      cubit.recipeNameController.text = 'apple pie';
      cubit.nameControllers[0].text = 'apple';
      cubit.quantityControllers[0].text = '5';
      cubit.changeUnit(Unit.kg, 0);

      expectLater(cubit.stream, emitsInOrder([
        const TypeMatcher<GenericDialogRecipeLoading>(),
        const TypeMatcher<GenericDialogRecipeLoaded>(),
      ]));

      final res = await cubit.upload();
      expect(res, true);
    });

    test('upload with wrong input format', () async {
      cubit.recipeNameController.text = 'apple pie';
      cubit.nameControllers[0].text = 'apple';
      cubit.quantityControllers[0].text = '5..';
      cubit.changeUnit(Unit.kg, 0);

      final call = cubit.upload();
      expect(() => call, throwsA(const TypeMatcher<FormatException>()));
      expect(cubit.state, const TypeMatcher<GenericDialogRecipeLoading>(),);
    });

  });

}