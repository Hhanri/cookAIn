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

  Map<String, dynamic> toJson();

  num get absoluteQuantity {
    switch(unit) {
      case Unit.kg:
      case Unit.L: return quantity * 1000;
      case null:
      case Unit.g:
      case Unit.mL: return quantity;
    }
  }

  String get quantityText {
    if (unit == null) return quantity.toString();
    return "$quantity ${unit!.name}";
  }
}

enum Unit {
  g, kg, mL, L
}

extension UnitExtension on String? {
  Unit? parseUnit() {
    switch(this) {
      case 'g': return Unit.g;
      case 'kg': return Unit.kg;
      case 'mL': return Unit.mL;
      case 'L': return Unit.L;
      case null: return null;
      default: return null;
    }
  }
}

typedef Ingredients = Map<String, IngredientEntity>;