import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IngredientsRepositoryInterface {

  Future<Either<Failure, void>> addIngredient({required IngredientEntity ingredient});

  Future<Either<Failure, void>> removeIngredient({required String ingredientName});

  Future<Either<Failure, void>> editIngredient({required IngredientEntity ingredient});

  Future<Either<Failure, void>> removeQuantity({required String ingredientName, required num quantityToRemove});

  Future<Either<Failure, void>> addQuantity({required String ingredientName, required num quantityToAdd});

  Stream<DocumentSnapshot<List<IngredientEntity>>> ingredientsStream();

}