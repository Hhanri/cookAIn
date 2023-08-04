import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/ingredients/data/models/ingredient_model.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';

class IngredientsRemoteDataSource implements IngredientsDataSourceInterface {
  final FirebaseFirestore fsi;
  final FirebaseAuth fai;

  IngredientsRemoteDataSource({
    required this.fsi,
    required this.fai
  });

  @override
  Future<Success> addIngredient({required IngredientModel ingredient}) async {
    return _handleError(
      function: () async {
        await userDoc
          .set({
            ingredient.name : ingredient.toJson()
          }, SetOptions(merge: true));
      }
    );
  }

  @override
  Future<Success> removeIngredient({required String ingredientName}) async {
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
  Future<Success> editIngredient({required IngredientModel ingredient}) {
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
  Future<Success> removeQuantity({required String ingredientName, required num quantityToRemove}) {
    return _handleError(
      function: () async {
        await userDoc
          .update({
            '$ingredientName.quantity' : FieldValue.increment(-quantityToRemove)
          });
      }
    );
  }

  @override
  Future<Success> addQuantity({required String ingredientName, required num quantityToAdd}) {
    return _handleError(
      function: () async {
        await userDoc
          .update({
          '$ingredientName.quantity' : FieldValue.increment(quantityToAdd)
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

  Future<Success> _handleError({required Future<void> Function() function}) async {
    try {
      await function();
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}