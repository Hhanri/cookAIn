import 'package:cookain/core/result/result.dart';

class Success extends Result {
  const Success({
    super.message,
    super.code
  });

  @override
  List<Object?> get props => [code, message];
}