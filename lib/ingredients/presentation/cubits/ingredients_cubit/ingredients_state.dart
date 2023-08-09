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

  IngredientsState copyWith({Ingredients? ingredients, bool? isLoading, String? error, String? success});

}

class IngredientsInitial extends IngredientsState {
  const IngredientsInitial() : super(isLoading: true, ingredients: const {});

  @override
  IngredientsState copyWith({Ingredients? ingredients, bool? isLoading, String? error, String? success}) {
    return const IngredientsInitial();
  }

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}

class IngredientsSuccess extends IngredientsState {
  const IngredientsSuccess({
    required super.ingredients,
    super.isLoading = false
  });

  @override
  IngredientsState copyWith({Ingredients? ingredients, bool? isLoading, String? error, String? success}) {
    return IngredientsSuccess(
      ingredients: ingredients ?? this.ingredients,
      isLoading: isLoading ?? false,
    );
  }

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}

class IngredientsError extends IngredientsState {
  const IngredientsError({
    required super.ingredients,
    required super.error
  }) : super(isLoading: false);

  @override
  IngredientsState copyWith({Ingredients? ingredients, bool? isLoading, String? error, String? success}) {
    return IngredientsError(
      ingredients: ingredients ?? this.ingredients,
      error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [isLoading, ingredients, success, error];
}
