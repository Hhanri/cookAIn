import 'package:cookain/core/service_locator.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/ingredients/presentation/screens/ingredients_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IngredientsCubit>(
      create: (context) => sl.get<IngredientsCubit>()..init(),
      child: const IngredientsScreen(),
    );
  }
}
