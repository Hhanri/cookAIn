import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepositoryInterface<T extends RecipeEntity> {

  Future<Either<Failure, Success>> addRecipe(T recipe);

  Future<Either<Failure, Success>> removeRecipe(String recipeName);

  Future<Either<Failure, Success>> editRecipe(T recipe);

  Future<Either<Failure, Success>> makeRecipe(T recipe);

  CollectionReference<RecipeEntity> recipesQuery();

}