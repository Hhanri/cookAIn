import 'package:cookain/core/cubits/my_bloc_listener.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:cookain/core/widgets/text_field_widget.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/presentation/cubits/add_ingredient_cubit/add_ingredient_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/edit_ingredient_cubit/edit_ingredient_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/generic_dialog_ingredient_cubit/generic_dialog_ingredient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> showAddIngredientDialog(BuildContext context) {
  return _showGenericIngredientDialog<AddIngredientCubit>(
    context: context,
    title: 'Add Ingredient',
    blocProvider: (context) => sl.get<AddIngredientCubit>()..init()
  );
}

Future<void> showEditIngredientDialog(BuildContext context, {required IngredientEntity initialIngredient}) {
  return _showGenericIngredientDialog<EditIngredientCubit>(
    context: context,
    title: 'Edit Ingredient',
    blocProvider: (context) => sl.get<EditIngredientCubit>(param1: initialIngredient)..init()
  );
}

Future<void> _showGenericIngredientDialog<C extends GenericDialogIngredientCubit>({
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
          scrollable: true,
          title: Text(title),
          content: _IngredientDialogContent<C>(),
          actions: [
            TextButton(onPressed: GoRouter.of(context).pop, child: const Text("Cancel")),
            Builder(
              builder: (context) {
                return FilledButton(
                  onPressed: () => context.read<C>().upload(context),
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

class _IngredientDialogContent<C extends GenericDialogIngredientCubit> extends StatelessWidget {
  const _IngredientDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<C>();
    final List<Unit?> units = [
      ...Unit.values,
      null
    ];

    final dropDownItems = units
      .map<DropdownMenuItem<Unit>>(
        (e) => DropdownMenuItem<Unit>(
          value: e,
          child: Text(e?.name ?? "None")
        )
      ).toList();

    return MyBlocListener<C, GenericDialogIngredientState>(
      child: Form(
        key: cubit.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              params: NormalTextFieldParameters(label: 'Name', readOnly: !cubit.canEditName),
              controller: cubit.nameController
            ),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    params: NumbersTextFieldParameters(label: 'Quantity',),
                    controller: cubit.quantityController
                  ),
                ),
                BlocSelector<C, GenericDialogIngredientState, Unit?>(
                  selector: (state) => state.unit,
                  builder: (context, state) {
                    return DropdownButton<Unit>(
                      isDense: true,
                      value: state,
                      items: dropDownItems,
                      onChanged: (unit) {
                        cubit.changeUnit(unit);
                      }
                    );
                  }
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
