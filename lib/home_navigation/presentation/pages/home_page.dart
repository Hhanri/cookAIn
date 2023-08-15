import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:cookain/core/widgets/material_3_speed_dial.dart';
import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:cookain/home_navigation/presentation/widgets/home_nav_bar.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/screens/ingredients_screen.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_dialog.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:cookain/recipes/presentation/screens/recipes_screen.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IngredientsCubit>(create: (context) => sl.get<IngredientsCubit>()..init()),
        BlocProvider<RecipesCubit>(create: (context) => sl.get<RecipesCubit>()..fetchMore()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CookAIn"),
          actions: [IconButton(onPressed: context.read<AuthCubit>().signOut, icon: const Icon(Icons.logout))],
        ),
        body: PageView(
          controller: context.read<HomeNavigationCubit>().controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            IngredientsScreen(),
            RecipesScreen()
          ],
        ),
        floatingActionButton: Material3SpeedDial(
          children: [
            addButton(context),
            chatButton(context)
          ],
        ),
        bottomNavigationBar: const HomeNavBar(),
      )
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
        switch (context.read<HomeNavigationCubit>().state) {
          case HomeNavigationState.ingredients: return "Add ingredient";
          case HomeNavigationState.recipes: return "Add recipe";
        }
      },
      child: const Icon(Icons.add)
    );
  }

  MySpeedDialChild chatButton(BuildContext context) {
    return MySpeedDialChild(
      onTap: () {
      },
      label: () => "Chat Bot",
      child: const Icon(Icons.chat)
    );
  }

}
