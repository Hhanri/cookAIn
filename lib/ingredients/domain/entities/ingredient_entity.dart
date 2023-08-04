import 'package:equatable/equatable.dart';

abstract class IngredientEntity extends Equatable {
  final String name;
  final num quantity;
  final Unit? unit;

  const IngredientEntity({
    required this.name,
    required this.quantity,
    required this.unit
  });

}

enum Unit {
  g, kg, mL, L
}