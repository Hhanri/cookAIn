import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';

abstract class IngredientsDataSourceInterface {

  Future<void> addIngredient({required IngredientModel ingredient});

  Future<void> removeIngredient({required String ingredientName});

  Future<void> editIngredient({required IngredientModel ingredient});

  Future<void> removeQuantity({required String ingredientName, required num quantityToRemove});

  Future<void> addQuantity({required String ingredientName, required num quantityToAdd});

  Stream<DocumentSnapshot<Ingredients>> ingredientsStream();

}