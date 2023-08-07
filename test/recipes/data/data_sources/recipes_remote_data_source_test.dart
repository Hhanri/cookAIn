import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';
import '../../../mock/mock_recipe.dart';


void main() {

  final fai = mockFAI;
  final fsi = mockFSI;

  final ingredientsDataSource = IngredientsRemoteDataSource(fsi: fsi, fai: fai);
  final dataSource = RecipeRemoteDataSource(fsi: fsi, fai: fai);

  group('recipes remote data source test', () {

    test('add ingredients', () async {
      await ingredientsDataSource.addIngredient(ingredient: mockApple);
      expect(fsi.dump(), mockAfterAddingApple);
      await ingredientsDataSource.addIngredient(ingredient: mockSugar);
      expect(fsi.dump(), mockAfterAddingSugar);
    });

    test('add recipe', () async {
      await dataSource.addRecipe(mockRecipe);
      expect(fsi.dump(), mockAfterAddingRecipe);
    });

    test('edit recipe', () async {
      await dataSource.editRecipe(mockEditedRecipe);
      expect(fsi.dump(), mockAfterEditingRecipe);
    });

    test('make recipe', () async {
      await dataSource.makeRecipe(mockEditedRecipe);
      expect(fsi.dump(), mockAfterMakingRecipe);
    });

    test('removing recipe', () async {
      await dataSource.removeRecipe(mockRecipe.name);
      expect(fsi.dump(), mockAfterRemovingRecipe);
    });

    test('query', () {
      final res = dataSource.recipesQuery();
      expect(res, const TypeMatcher<CollectionReference>());
    });

  });

}