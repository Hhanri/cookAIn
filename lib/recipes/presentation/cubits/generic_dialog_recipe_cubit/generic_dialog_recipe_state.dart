part of 'generic_dialog_recipe_cubit.dart';

@immutable
abstract class GenericDialogRecipeState extends MyBlocState {
  final List<Unit?> units;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> quantityControllers;
  final int length;
  const GenericDialogRecipeState({
    required this.units,
    required this.nameControllers,
    required this.quantityControllers,
    required this.length,
    required super.isLoading,
    super.error
  });
}

class GenericDialogRecipeLoaded extends GenericDialogRecipeState {
  const GenericDialogRecipeLoaded({
    required super.units,
    required super.nameControllers,
    required super.quantityControllers,
    required super.length
  }) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, length, units, nameControllers, quantityControllers];
}

class GenericDialogRecipeError extends GenericDialogRecipeState {
  const GenericDialogRecipeError({
    required super.error,
    required super.units,
    required super.nameControllers,
    required super.quantityControllers,
    required super.length
  }) : super(isLoading: false);

  @override
  List<Object?> get props => [isLoading, error, length, units, nameControllers, quantityControllers];
}

class GenericDialogRecipeLoading extends GenericDialogRecipeState {
  const GenericDialogRecipeLoading({
    required super.units,
    required super.nameControllers,
    required super.quantityControllers,
    required super.length
  }) : super(isLoading: true);

  @override
  List<Object?> get props => [isLoading, length, units, nameControllers, quantityControllers];
}