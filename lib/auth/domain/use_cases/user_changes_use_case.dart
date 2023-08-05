import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';

class UserChangesUseCase<T> {

  final AuthRepositoryInterface<T> repo;

  UserChangesUseCase(this.repo);

  Stream<T> call() {
    return repo.userChanges();
  }

}