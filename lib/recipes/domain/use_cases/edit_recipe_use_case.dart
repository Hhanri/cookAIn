import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';
import 'package:dartz/dartz.dart';

class EditRecipeUseCase {
  final RecipeRepositoryInterface repo;

  EditRecipeUseCase(this.repo);

  Future<Either<Failure, Success>> call(RecipeEntity recipe) {
    return repo.editRecipe(recipe);
  }
}