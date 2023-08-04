import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';

class IngredientModel extends IngredientEntity {
  
  const IngredientModel({
    required super.name,
    required super.quantity,
    required super.unit
  });
  
  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'], 
      quantity: json['quantity'],
      unit: (json['unit'] as String?).parseUnit()
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit?.name
    };
  }

  @override
  List<Object?> get props => [name, quantity, unit];
  
}

