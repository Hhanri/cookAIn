import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/failure/failure.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';

class IngredientsRemoteDataSource implements IngredientsDataSourceInterface {

  final fsi = FirebaseFirestore.instance;
  final fai = FirebaseAuth.instance;

  @override
  Future<void> addIngredient({required IngredientModel ingredient}) async {
    return _handleError(
      function: () async {
        await userDoc
          .set({
            ingredient.name : ingredient.toJson()
          });
      }
    );
  }

  @override
  Future<void> removeIngredient({required String ingredientName}) async {
    return _handleError(
      function: () async {
        await userDoc
          .update({
            ingredientName : FieldValue.delete()
          });
      }
    );
  }

  @override
  Future<void> editIngredient({required IngredientModel ingredient}) {
    return _handleError(
      function: () async {
        await userDoc
          .update({
            ingredient.name : ingredient.toJson()
          });
      }
    );
  }

  @override
  Future<void> removeQuantity({required String ingredientName, required num quantityToRemove}) {
    return _handleError(
      function: () async {
        await userDoc
          .update({
            'ingredientName.quantity' : FieldValue.increment(-quantityToRemove)
          });
      }
    );
  }

  @override
  Future<void> addQuantity({required String ingredientName, required num quantityToAdd}) {
    return _handleError(
      function: () async {
        await userDoc
          .update({
            'ingredientName.quantity' : FieldValue.increment(quantityToAdd)
          });
      }
    );
  }

  @override
  Stream<DocumentSnapshot<Ingredients>> ingredientsStream() {
    return userDoc
      .withConverter<Ingredients>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data();
          return data?.map((key, value) => MapEntry(key, IngredientModel.fromJson(value))) ?? {};
        },
        toFirestore: (model, _) {
          return model.map((key, value) => MapEntry(key, value.toJson()));
        }
      ).snapshots();
  }

  DocumentReference get userDoc => fsi
    .collection('ingredients')
    .doc(fai.currentUser?.uid);

  Future<void> _handleError({required Future<void> Function() function}) async {
    try {
      await function();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}