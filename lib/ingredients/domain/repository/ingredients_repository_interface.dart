import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IngredientsRepositoryInterface<T extends IngredientEntity> {

  Future<Either<Failure, void>> addIngredient({required T ingredient});

  Future<Either<Failure, void>> removeIngredient({required String ingredientName});

  Future<Either<Failure, void>> editIngredient({required T ingredient});

  Future<Either<Failure, void>> removeIngredientQuantity({required String ingredientName, required num quantityToRemove});

  Future<Either<Failure, void>> addIngredientQuantity({required String ingredientName, required num quantityToAdd});

  Stream<DocumentSnapshot<Ingredients>> ingredientsStream();

}