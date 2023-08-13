part of 'recipes_cubit.dart';

@immutable
abstract class RecipesState extends FirestoreQueryState<RecipeEntity> {
  const RecipesState();
}

class RecipesInitial extends FirestoreQueryInitial<RecipeEntity> {
  const RecipesInitial();

  @override
  List<Object?> get props => [];
}

class RecipesLoaded extends FirestoreQueryLoaded<RecipeEntity> {
  const RecipesLoaded({required super.docs});

  @override
  List<Object?> get props => [];
}

class RecipesError extends FirestoreQueryError<RecipeEntity> {
  const RecipesError({
    required super.error,
  });

  @override
  List<Object?> get props => [error];
}