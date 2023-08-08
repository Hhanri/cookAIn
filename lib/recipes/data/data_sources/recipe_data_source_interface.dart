import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';

abstract class RecipeDataSourceInterface {

  Future<Success> addRecipe(RecipeModel recipe);

  Future<Success> removeRecipe(String recipeName);

  Future<Success> editRecipe(RecipeModel recipe);

  Future<Success> makeRecipe(RecipeModel recipe);

  CollectionReference<RecipeModel> recipesQuery();

}