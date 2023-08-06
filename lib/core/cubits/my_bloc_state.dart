import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MyBlocState extends Equatable {
  final bool isLoading;

  const MyBlocState({
    required this.isLoading
  });
}

@immutable
abstract class MyBlocErrorState extends MyBlocState {
  final String error;

  const MyBlocErrorState({required this.error}) : super(isLoading: false);
}

@immutable
abstract class MyBlocSuccessState extends MyBlocState {
  final String? success;

  const MyBlocSuccessState({this.success}) : super(isLoading: false);
}