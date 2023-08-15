import 'package:cookain/core/service_locator.dart';
import 'package:cookain/home_navigation/presentation/pages/home_page.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<IngredientsCubit>(create: (context) => sl.get<IngredientsCubit>()..init()),
        BlocProvider<RecipesCubit>(create: (context) => sl.get<RecipesCubit>()..fetchMore()),
      ],
      child: const HomePage()
    );
  }
}
