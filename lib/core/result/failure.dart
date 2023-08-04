import 'package:cookain/core/result/result.dart';

class Failure extends Result {
  const Failure({
    required super.message,
    super.code
  });

  @override
  List<Object?> get props => [code, message];
}