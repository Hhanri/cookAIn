import 'package:cookain/core/config/router.dart';
import 'package:cookain/core/widgets/material_3_speed_dial.dart';
import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_dialog.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material3SpeedDial(
      children: [
        addButton(context),
        chatButton(context)
      ],
    );
  }

  MySpeedDialChild addButton(BuildContext context) {
    return MySpeedDialChild(
      onTap: () async {
        switch (context.read<HomeNavigationCubit>().state)  {
          case HomeNavigationState.ingredients: return showAddIngredientDialog(context);
          case HomeNavigationState.recipes: return showAddRecipeDialog(context);
        }
      },
      label: () {
        switch (context.watch<HomeNavigationCubit>().state) {
          case HomeNavigationState.ingredients: return "Add ingredient";
          case HomeNavigationState.recipes: return "Add recipe";
        }
      },
      child: const Icon(Icons.add)
    );
  }

  MySpeedDialChild chatButton(BuildContext context) {
    return MySpeedDialChild(
        onTap: () => GoRouter.of(context).pushNamed(MyGoRouter.chatBotName, extra: context.read<IngredientsCubit>()),
        label: () => "Chat Bot",
        child: const Icon(Icons.chat)
    );
  }
}
