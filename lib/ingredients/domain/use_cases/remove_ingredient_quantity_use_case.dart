import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class RemoveIngredientQuantityUseCase {
  final IngredientsRepositoryInterface repo;

  RemoveIngredientQuantityUseCase(this.repo);

  Future<Either<Failure, Success>> call(String ingredientName, num quantityToRemove) {
    return repo.removeIngredientQuantity(ingredientName: ingredientName, quantityToRemove: quantityToRemove);
  }
}