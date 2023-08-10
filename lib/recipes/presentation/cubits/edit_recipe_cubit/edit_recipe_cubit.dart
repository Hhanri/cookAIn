import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/use_cases/edit_recipe_use_case.dart';
import 'package:cookain/recipes/presentation/cubits/generic_dialog_recipe_cubit/generic_dialog_recipe_cubit.dart';
import 'package:flutter/cupertino.dart';

class EditRecipeCubit extends GenericDialogRecipeCubit {

  final EditRecipeUseCase useCase;
  final RecipeEntity initialRecipe;

  EditRecipeCubit({
    required this.useCase,
    required this.initialRecipe,
  }) : super(canEditName: false);

  @override
  void init() {
    recipeNameController.text = initialRecipe.name;
    final Iterable<IngredientEntity> ingredients = initialRecipe.ingredients.values;
    for (int i = 0; i < initialRecipe.ingredients.length; i++) {
      units.add(ingredients.elementAt(i).unit);
      nameControllers.add(TextEditingController(text: ingredients.elementAt(i).name));
      quantityControllers.add(TextEditingController(text: ingredients.elementAt(i).quantity.toString()));
    }
  }

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
            units: units, nameControllers: nameControllers,
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