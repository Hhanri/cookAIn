import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IngredientsRepositoryInterface<T extends IngredientEntity> {

  Future<Either<Failure, Success>> addIngredient({required T ingredient});

  Future<Either<Failure, Success>> removeIngredient({required String ingredientName});

  Future<Either<Failure, Success>> editIngredient({required T ingredient});

  Future<Either<Failure, Success>> removeIngredientQuantity({required String ingredientName, required num quantityToRemove});

  Future<Either<Failure, Success>> addIngredientQuantity({required String ingredientName, required num quantityToAdd});

  Stream<DocumentSnapshot<Ingredients>> ingredientsStream();

}