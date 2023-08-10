import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/generic_dialog_ingredient_cubit/generic_dialog_ingredient_cubit.dart';

class AddIngredientCubit extends GenericDialogIngredientCubit {

  final AddIngredientUseCase useCase;

  AddIngredientCubit({
    required this.useCase,
  }) : super(canEditName: true);

  @override
  Future<bool> upload() async {
    if (!(formKey.currentState?.validate() ?? true)) return false;
    emit(GenericDialogIngredientLoading(unit: unit));

    final ingredient = IngredientModel(
      name: nameController.text.toLowerCase(),
      quantity: double.parse(quantityController.text),
      unit: unit
    );

    final res = await useCase.call(ingredient);
    return res.fold(
      (failure) {
        emit(GenericDialogIngredientError(error: failure.message, unit: unit));
        return false;
      } ,
      (success) {
        emit(GenericDialogIngredientLoaded(unit: unit));
        return true;
      }
    );
  }

  @override
  void init() {}

}