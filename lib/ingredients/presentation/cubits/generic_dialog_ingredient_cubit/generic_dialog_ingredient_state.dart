part of 'generic_dialog_ingredient_cubit.dart';

@immutable
abstract class GenericDialogIngredientState extends MyBlocState {
  final Unit? unit;

  const GenericDialogIngredientState({required this.unit, required super.isLoading, super.error});
}

class GenericDialogIngredientLoaded extends GenericDialogIngredientState {
  const GenericDialogIngredientLoaded({required super.unit}) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, unit];
}

class GenericDialogIngredientError extends GenericDialogIngredientState {
  const GenericDialogIngredientError({required super.error, required super.unit}) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, error, unit];

}
class GenericDialogIngredientLoading extends GenericDialogIngredientState {
  const GenericDialogIngredientLoading({required super.unit}) : super(isLoading: true);

  @override
  List<Object?> get props => [isLoading, unit];
}