import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class AddIngredientQuantityUseCase {
  final IngredientsRepositoryInterface repo;

  AddIngredientQuantityUseCase(this.repo);

  Future<Either<Failure, void>> call(String ingredientName, num quantityToAdd) {
    return repo.addIngredientQuantity(ingredientName: ingredientName, quantityToAdd: quantityToAdd);
  }
}