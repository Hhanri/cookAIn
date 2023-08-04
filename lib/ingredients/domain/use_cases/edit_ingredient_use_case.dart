import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class EditIngredientUseCase {
  final IngredientsRepositoryInterface repo;

  EditIngredientUseCase(this.repo);

  Future<Either<Failure, void>> call(IngredientEntity ingredient) {
    return repo.editIngredient(ingredient: ingredient);
  }
}