import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/add_ingredient_cubit/add_ingredient_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/generic_dialog_ingredient_cubit/generic_dialog_ingredient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final repo = IngredientsRepositoryImplementation(dataSource);

  final addIngredientUseCase = AddIngredientUseCase(repo);

  final cubit = AddIngredientCubit(useCase: addIngredientUseCase);

  group('add ingredient cubit test', () {

    test('initial state', () {
      expect(cubit.state, const GenericModalIngredientLoaded(unit: Unit.kg));
    });

    test('change unit', () {
      cubit.changeUnit(Unit.g);
      expect(cubit.state, const GenericModalIngredientLoaded(unit: Unit.g));
    });

    test('upload', () async {
      cubit.nameController.text = 'apple';
      cubit.quantityController.text = '20';
      cubit.changeUnit(Unit.kg);

      expectLater(cubit.stream, emitsInOrder([
        const GenericModalIngredientLoading(unit: Unit.kg),
        const GenericModalIngredientLoaded(unit: Unit.kg)
      ]));

      final res = await cubit.upload();
      expect(res, true);
    });

    test('upload with wrong input format', () async {
      cubit.nameController.text = 'apple';
      cubit.quantityController.text = '20..0';
      cubit.changeUnit(Unit.kg);
      final call = cubit.upload();
      expect(() => call, throwsA(const TypeMatcher<FormatException>()));
      expect(cubit.state, const GenericModalIngredientLoading(unit: Unit.kg));
    });

  });

}