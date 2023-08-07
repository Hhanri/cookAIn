import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:cookain/recipes/data/data_sources/recipe_data_source_interface.dart';
import 'package:cookain/recipes/data/models/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeRemoteDataSource implements RecipeDataSourceInterface {

  final FirebaseFirestore fsi;
  final FirebaseAuth fai;

  RecipeRemoteDataSource({required this.fsi, required this.fai});

  @override
  Future<Success> addRecipe(RecipeModel recipe) async {
    try {
      _recipeDoc(recipe.name)
        .set(recipe);
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<Success> editRecipe(RecipeModel recipe) async {
    try {
      await _recipeDoc(recipe.name)
        .update(recipe.toJson());
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<Success> makeRecipe(RecipeModel recipe) async {
    try {
      final Map<String, FieldValue> update = {};
      for (final element in recipe.ingredients.entries) {
        update['${element.key}.quantity'] = FieldValue.increment(-element.value.quantity);
      }
      await _ingredientsDoc.update(update);
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<Success> removeRecipe(String recipeName) async {
    try {
      await _recipeDoc(recipeName).delete();
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  CollectionReference<RecipeModel> recipesQuery() {
    return _ingredientsDoc
      .collection('recipes')
      .withConverter<RecipeModel>(
        fromFirestore: (snapshot, _) => RecipeModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson()
    );
  }

  DocumentReference<RecipeModel> _recipeDoc(String recipeName) => recipesQuery()
    .doc(recipeName);

  DocumentReference<Map<String, dynamic>> get _ingredientsDoc => fsi
    .collection('ingredients')
    .doc(fai.currentUser?.uid);

}