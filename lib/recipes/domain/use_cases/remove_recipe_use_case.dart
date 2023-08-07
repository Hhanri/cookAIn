import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';
import 'package:dartz/dartz.dart';

class RemoveRecipeUseCase {
  final RecipeRepositoryInterface repo;

  RemoveRecipeUseCase(this.repo);

  Future<Either<Failure, Success>> call(String recipeName) {
    return repo.removeRecipe(recipeName);
  }
}