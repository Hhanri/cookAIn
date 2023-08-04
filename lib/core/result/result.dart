import 'package:equatable/equatable.dart';

abstract class Result extends Equatable {
  final String? code;
  final String? message;

  const Result({
    this.code,
    this.message
  });

  @override
  List<Object?> get props => [code, message];
}