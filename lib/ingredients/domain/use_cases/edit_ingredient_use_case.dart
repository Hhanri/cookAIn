import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class EditIngredientUseCase {
  final IngredientsRepositoryInterface repo;

  EditIngredientUseCase(this.repo);

  Future<Either<Failure, Success>> call(IngredientEntity ingredient) {
    return repo.editIngredient(ingredient: ingredient);
  }
}