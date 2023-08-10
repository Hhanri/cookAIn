import 'package:cookain/core/cubits/dialog_form_generic_cubit/dialog_form_generic_cubit.dart';
import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:flutter/widgets.dart';

part 'generic_dialog_recipe_state.dart';

abstract class GenericDialogRecipeCubit extends DialogFormGenericCubit<GenericDialogRecipeState> {

  @override
  final bool canEditName;

  GenericDialogRecipeCubit({
    required this.canEditName
  }) : super(
    const GenericDialogRecipeLoading(
      units: [],
      length: 0,
      nameControllers: [],
      quantityControllers: []
    )
  );

  final TextEditingController recipeNameController = TextEditingController();
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> quantityControllers = [];
  final List<Unit?> units = [];

  void changeUnit(Unit? unit, int index) {
    units[index] = unit;
    emit(GenericDialogRecipeLoaded(
      units: units,
      length: units.length,
      nameControllers: nameControllers,
      quantityControllers: quantityControllers
    ));
  }

  void addIngredient() {
    units.add(Unit.kg);
    nameControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
    emitLoaded();
  }

  void removeIngredient(int index) {
    units.removeAt(index);
    nameControllers.removeAt(index);
    quantityControllers.removeAt(index);
    emitLoaded();
  }

  void emitLoaded() {
    emit(
      GenericDialogRecipeLoaded(
        units: units,
        length: units.length,
        nameControllers: nameControllers,
        quantityControllers: quantityControllers
      )
    );
  }

  @override
  Future<void> close() async {
    recipeNameController.dispose();
    for (final controller in nameControllers) {
      controller.dispose();
    }
    for (final controller in quantityControllers) {
      controller.dispose();
    }
    return super.close();
  }

}
