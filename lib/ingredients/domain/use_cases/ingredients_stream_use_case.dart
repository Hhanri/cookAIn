import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';

class IngredientsStreamUseCase {
  final IngredientsRepositoryInterface repo;

  IngredientsStreamUseCase(this.repo);

  Stream<DocumentSnapshot<Ingredients>> call() {
    return repo.ingredientsStream();
  }
}