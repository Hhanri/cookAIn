part of 'ingredients_cubit.dart';

@immutable
abstract class IngredientsState extends MyBlocState {
  final Ingredients ingredients;
  const IngredientsState({
    required super.isLoading,
    required this.ingredients,
    super.error,
    super.success,
  });
}

class IngredientsInitial extends IngredientsState {
  const IngredientsInitial() : super(isLoading: true, ingredients: const {});

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}

class IngredientsSuccess extends IngredientsState {
  const IngredientsSuccess({
    required super.ingredients
  }) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}

class IngredientsError extends IngredientsState {
  const IngredientsError({
    required super.ingredients,
    required super.error
  }) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}
