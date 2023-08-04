import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class AddIngredientUseCase {
  final IngredientsRepositoryInterface repo;

  AddIngredientUseCase(this.repo);

  Future<Either<Failure, void>> call(IngredientEntity ingredient) {
    return repo.addIngredient(ingredient: ingredient);
  }
}