import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class AddIngredientQuantityUseCase {
  final IngredientsRepositoryInterface repo;

  AddIngredientQuantityUseCase(this.repo);

  Future<Either<Failure, Success>> call(String ingredientName, num quantityToAdd) {
    return repo.addIngredientQuantity(ingredientName: ingredientName, quantityToAdd: quantityToAdd);
  }
}