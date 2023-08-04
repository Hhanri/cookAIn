import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class RemoveIngredientUseCase {
  final IngredientsRepositoryInterface repo;

  RemoveIngredientUseCase(this.repo);

  Future<Either<Failure, Success>> call(String ingredientName) {
    return repo.removeIngredient(ingredientName: ingredientName);
  }
}