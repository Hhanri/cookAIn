import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MyBlocState extends Equatable {
  final bool isLoading;
  final String? success;
  final String? error;
  const MyBlocState({
    required this.isLoading,
    this.success,
    this.error,
  });
}