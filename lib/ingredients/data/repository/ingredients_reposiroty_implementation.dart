import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/execute.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:dartz/dartz.dart';

class IngredientsRepositoryImplementation implements IngredientsRepositoryInterface<IngredientModel> {

  final IngredientsDataSourceInterface dataSource;

  IngredientsRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, Success>> addIngredient({required IngredientModel ingredient}) {
   return execute(() => dataSource.addIngredient(ingredient: ingredient));
  }

  @override
  Future<Either<Failure, Success>> removeIngredient({required String ingredientName}) {
    return execute(() => dataSource.removeIngredient(ingredientName: ingredientName));
  }

  @override
  Future<Either<Failure, Success>> editIngredient({required IngredientModel ingredient}) {
    return execute(() => dataSource.editIngredient(ingredient: ingredient));
  }

  @override
  Future<Either<Failure, Success>> removeIngredientQuantity({required String ingredientName, required num quantityToRemove}) {
    return execute(() => dataSource.removeQuantity(ingredientName: ingredientName, quantityToRemove: quantityToRemove));
  }

  @override
  Future<Either<Failure, Success>> addIngredientQuantity({required String ingredientName, required num quantityToAdd}) {
    return execute(() => dataSource.addQuantity(ingredientName: ingredientName, quantityToAdd: quantityToAdd));
  }

  @override
  Stream<DocumentSnapshot<Ingredients>> ingredientsStream() {
    return dataSource.ingredientsStream();
  }
  
}