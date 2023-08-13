import 'package:cookain/core/config/theme.dart';
import 'package:cookain/core/cubits/my_bloc_listener.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:cookain/core/widgets/text_field_widget.dart';
import 'package:cookain/core/widgets/units_drop_down_menu.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/presentation/cubits/add_recipe_cubit/add_recipe_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/edit_recipe_cubit/edit_recipe_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/generic_dialog_recipe_cubit/generic_dialog_recipe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> showAddRecipeDialog(BuildContext context) {
  return _showGenericIngredientDialog<AddRecipeCubit>(
    context: context,
    title: 'Add Recipe',
    blocProvider: (context) => sl.get<AddRecipeCubit>()..init()
  );
}

Future<void> showEditRecipeDialog(BuildContext context, {required RecipeEntity initialRecipe}) {
  return _showGenericIngredientDialog<EditRecipeCubit>(
    context: context,
    title: 'Edit Recipe',
    blocProvider: (context) => sl.get<EditRecipeCubit>(param1: initialRecipe)..init()
  );
}

Future<void> _showGenericIngredientDialog<C extends GenericDialogRecipeCubit>({
  required BuildContext context,
  required String title,
  required C Function(BuildContext) blocProvider
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return BlocProvider<C>(
        create: blocProvider,
        child: AlertDialog(
          title: Text(title),
          content: _RecipeDialogContent<C>(),
          actions: [
            Builder(
              builder: (context) {
                final cubit = context.read<C>();
                return IconButton(
                  onPressed: cubit.addIngredient,
                  icon: Icon(Icons.add, color: MyTheme.scheme.primary,),
                  tooltip: "Add ingredient",
                );
              },
            ),
            TextButton(onPressed: GoRouter.of(context).pop, child: const Text("Cancel")),
            Builder(
              builder: (context) {
                return FilledButton(
                  onPressed: () async {
                    final cubit = context.read<C>();
                    cubit.upload().then((value) {
                      if (value) GoRouter.of(context).pop();
                    });
                  },
                  child: const Text("Upload")
                );
              },
            )
          ],
        ),
      );
    }
  );
}

class _RecipeDialogContent<C extends GenericDialogRecipeCubit> extends StatelessWidget {
  const _RecipeDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<C>();

    return MyBlocListener<C, GenericDialogRecipeState>(
      child: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyTextField(
                  params: NormalTextFieldParameters(label: 'Name', readOnly: !cubit.canEditName),
                  controller: cubit.recipeNameController
                ),
                BlocBuilder<C, GenericDialogRecipeState>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return ingredientRowWidget(
                          nameController: state.nameControllers[index],
                          quantityController: state.quantityControllers[index],
                          unit: state.units[index],
                          onUnitChange: (unit) => cubit.changeUnit(unit, index),
                          deleteItem: () => cubit.removeIngredient(index),
                          canEditName: cubit.canEditName
                        );
                      }
                    );
                  }
                ),

              ],
            ),
          ),
        ),
      )
    );
  }

  Widget ingredientRowWidget({
    required TextEditingController nameController,
    required TextEditingController quantityController,
    required Unit? unit,
    required void Function(Unit? unit) onUnitChange,
    required void Function() deleteItem,
    required bool canEditName
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MyTextField(
            params: NormalTextFieldParameters(
              label: 'Name',
              readOnly: !canEditName
            ),
            controller: nameController
          ),
        ),
        Expanded(
          child: MyTextField(
            params: NumbersTextFieldParameters(label: 'Quantity',),
            controller: quantityController
          ),
        ),
        DropdownButton<Unit>(
          isDense: true,
          value: unit,
          items: getUnitsDropDownMenuItems(),
          onChanged: onUnitChange
        ),
        IconButton(
          onPressed: deleteItem ,
          icon: const Icon(Icons.delete)
        )
      ],
    );
  }
}
