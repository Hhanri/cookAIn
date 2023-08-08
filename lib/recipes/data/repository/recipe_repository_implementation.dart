import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/execute.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/data/data_sources/recipe_data_source_interface.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImplementation implements RecipeRepositoryInterface<RecipeModel> {

  final RecipeDataSourceInterface dataSource;

  RecipeRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, Success>> addRecipe(RecipeModel recipe) async {
    return execute(() => dataSource.addRecipe(recipe));
  }

  @override
  Future<Either<Failure, Success>> editRecipe(RecipeModel recipe) {
    return execute(() => dataSource.editRecipe(recipe));
  }

  @override
  Future<Either<Failure, Success>> makeRecipe(RecipeModel recipe) {
    return execute(() => dataSource.makeRecipe(recipe));
  }

  @override
  Future<Either<Failure, Success>> removeRecipe(String recipeName) {
    return execute(() => dataSource.removeRecipe(recipeName));
  }

  @override
  CollectionReference<RecipeEntity> recipesQuery() {
    return dataSource.recipesQuery();
  }
}