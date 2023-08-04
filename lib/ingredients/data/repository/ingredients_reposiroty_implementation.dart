import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
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
   return _query(() => dataSource.addIngredient(ingredient: ingredient));
  }

  @override
  Future<Either<Failure, Success>> removeIngredient({required String ingredientName}) {
    return _query(() => dataSource.removeIngredient(ingredientName: ingredientName));
  }

  @override
  Future<Either<Failure, Success>> editIngredient({required IngredientModel ingredient}) {
    return _query(() => dataSource.editIngredient(ingredient: ingredient));
  }

  @override
  Future<Either<Failure, Success>> removeIngredientQuantity({required String ingredientName, required num quantityToRemove}) {
    return _query(() => dataSource.removeQuantity(ingredientName: ingredientName, quantityToRemove: quantityToRemove));
  }

  @override
  Future<Either<Failure, Success>> addIngredientQuantity({required String ingredientName, required num quantityToAdd}) {
    return _query(() => dataSource.addQuantity(ingredientName: ingredientName, quantityToAdd: quantityToAdd));
  }

  @override
  Stream<DocumentSnapshot<Ingredients>> ingredientsStream() {
    return dataSource.ingredientsStream();
  }

  Future<Either<Failure, T>> _query<T>(
    Future<T> Function() function
  ) async {
    try {
      final res = await function();
      return Right(res);
    } on Failure catch(e) {
      return Left(e);
    } catch(e) {
      return Left(Failure(message: e.toString()));
    }
  }

}