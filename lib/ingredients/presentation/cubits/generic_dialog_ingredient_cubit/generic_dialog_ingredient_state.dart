part of 'generic_dialog_ingredient_cubit.dart';

@immutable
abstract class GenericDialogIngredientState extends MyBlocState {
  final Unit? unit;

  const GenericDialogIngredientState({required this.unit, required super.isLoading, super.error});
}

class GenericModalIngredientLoaded extends GenericDialogIngredientState {
  const GenericModalIngredientLoaded({required super.unit}) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, unit];
}

class GenericModalIngredientError extends GenericDialogIngredientState {
  const GenericModalIngredientError({required super.error, required super.unit}) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, error, unit];

}
class GenericModalIngredientLoading extends GenericDialogIngredientState {
  const GenericModalIngredientLoading({required super.unit}) : super(isLoading: true);

  @override
  List<Object?> get props => [isLoading, unit];
}