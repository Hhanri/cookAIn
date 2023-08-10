import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeNavBarItemEntity extends Equatable {
  final String label;
  final IconData icon;
  final HomeNavigationState state;

  const HomeNavBarItemEntity({
    required this.label,
    required this.icon,
    required this.state
  });

  static const values = [
    HomeNavBarItemEntity(label: 'Supply', icon: Icons.checklist, state: HomeNavigationState.ingredients),
    HomeNavBarItemEntity(label: 'Recipes', icon: Icons.receipt_long, state: HomeNavigationState.recipes),
  ];

  @override
  List<Object?> get props => [label, icon, state];
}

enum HomeNavigationState {
  ingredients,
  recipes
}