import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/generic_dialog_ingredient_cubit/generic_dialog_ingredient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddIngredientCubit extends GenericDialogIngredientCubit {

  final AddIngredientUseCase useCase;

  AddIngredientCubit({
    required this.useCase,
  }) : super(canEditName: true);

  @override
  void upload(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    emit(GenericModalIngredientLoading(unit: unit));

    final ingredient = IngredientModel(
      name: nameController.text.toLowerCase(),
      quantity: double.parse(quantityController.text),
      unit: unit
    );

    final res = await useCase.call(ingredient);
    res.fold(
      (failure) => emit(GenericModalIngredientError(error: failure.message, unit: unit)) ,
      (success) {
        emit(GenericModalIngredientLoaded(unit: unit));
        GoRouter.of(context).pop();
      }
    );
  }

  @override
  void init() {}

}