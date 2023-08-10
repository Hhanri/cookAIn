import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:cookain/home_navigation/presentation/widgets/home_nav_bar.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/screens/ingredients_screen.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IngredientsCubit>(create: (context) => sl.get<IngredientsCubit>()..init()),
      ],
      child: DefaultTabController(
        length: HomeNavBarItemEntity.values.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("CookAIn"),
            actions: [IconButton(onPressed: context.read<AuthCubit>().signOut, icon: const Icon(Icons.logout))],
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              IngredientsScreen(),
              IngredientsScreen()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showAddIngredientDialog(context),
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: const HomeNavBar(),
        )
      )
    );
  }
}
