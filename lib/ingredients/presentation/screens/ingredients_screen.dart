import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredient_dialog.dart';
import 'package:cookain/ingredients/presentation/widgets/ingredients_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientsScreen extends StatelessWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food supply"),
        actions: [IconButton(onPressed: context.read<AuthCubit>().signOut, icon: const Icon(Icons.logout))],
      ),
      body: const IngredientsListViewWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddIngredientDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
