import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<Unit>> getUnitsDropDownMenuItems() {

  final List<Unit?> units = [
    ...Unit.values,
    null
  ];

  final dropDownItems = units
    .map<DropdownMenuItem<Unit>>(
      (e) => DropdownMenuItem<Unit>(
      value: e,
      child: Text(e?.name ?? "None")
    )
  ).toList();

  return dropDownItems;
}