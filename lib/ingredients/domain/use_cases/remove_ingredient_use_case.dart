import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class RemoveIngredientUseCase {
  final IngredientsRepositoryInterface repo;

  RemoveIngredientUseCase(this.repo);

  Future<Either<Failure, void>> call(String ingredientName) {
    return repo.removeIngredient(ingredientName: ingredientName);
  }
}