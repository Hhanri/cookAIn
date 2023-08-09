import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/cubits/dialog_form_generic_cubit/dialog_form_generic_cubit.dart';

part 'generic_dialog_ingredient_state.dart';

abstract class GenericDialogIngredientCubit extends DialogFormGenericCubit<IngredientEntity, GenericDialogIngredientState> {
  @override
  final bool canEditName;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  GenericDialogIngredientCubit({
    required this.canEditName
  }) : super(const GenericModalIngredientLoaded(unit: Unit.kg));

  Unit? unit = Unit.kg;

  void changeUnit(Unit? unit) {
    this.unit = unit;
    emit(GenericModalIngredientLoaded(unit: unit));
  }

  @override
  Future<void> close() async {
    nameController.dispose();
    quantityController.dispose();
    return super.close();
  }
}
