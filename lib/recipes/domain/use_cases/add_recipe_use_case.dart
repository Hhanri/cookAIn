import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';
import 'package:dartz/dartz.dart';

class AddRecipeUseCase {
  final RecipeRepositoryInterface repo;

  AddRecipeUseCase(this.repo);

  Future<Either<Failure, Success>> call(RecipeEntity recipe) {
    return repo.addRecipe(recipe);
  }
}