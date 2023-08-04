import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';

abstract class IngredientsDataSourceInterface {

  Future<Success> addIngredient({required IngredientModel ingredient});

  Future<Success> removeIngredient({required String ingredientName});

  Future<Success> editIngredient({required IngredientModel ingredient});

  Future<Success> removeQuantity({required String ingredientName, required num quantityToRemove});

  Future<Success> addQuantity({required String ingredientName, required num quantityToAdd});

  Stream<DocumentSnapshot<Ingredients>> ingredientsStream();

}