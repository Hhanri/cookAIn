import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';

class RecipesQueryUseCase {
  final RecipeRepositoryInterface repo;

  RecipesQueryUseCase(this.repo);

  CollectionReference<RecipeEntity> call() {
    return repo.recipesQuery();
  }
}