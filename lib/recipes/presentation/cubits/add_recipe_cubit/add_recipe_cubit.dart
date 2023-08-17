import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/presentation/cubits/generic_dialog_recipe_cubit/generic_dialog_recipe_cubit.dart';

class AddRecipeCubit extends GenericDialogRecipeCubit {

  final AddRecipeUseCase useCase;

  AddRecipeCubit({
    required this.useCase,
    super.initialRecipe
  }) : super(canEditName: true);

  @override
  Future<bool> upload() async {
    if (!(formKey.currentState?.validate() ?? true)) return false;
    emit(
      GenericDialogRecipeLoading(
        units: units,
        nameControllers: nameControllers,
        quantityControllers: quantityControllers,
        length: units.length
      )
    );

    final recipe = RecipeModel(
      name: recipeNameController.text.toLowerCase(),
      ingredients: {
        for (int i = 0; i < nameControllers.length; i++)
          nameControllers[i].text.toLowerCase(): IngredientModel(
            name: nameControllers[i].text.toLowerCase(),
            quantity: double.parse(quantityControllers[i].text),
            unit: units[i]
          )
      }
    );

    final res = await useCase.call(recipe);
    return res.fold(
      (failure) {
        emit(
          GenericDialogRecipeError(
            error: failure.message,
            length: units.length,
            units: units,
            nameControllers: nameControllers,
            quantityControllers: quantityControllers
          )
        );
        return false;
      },
      (success) {
        emitLoaded();
        return true;
      }
    );
  }

}