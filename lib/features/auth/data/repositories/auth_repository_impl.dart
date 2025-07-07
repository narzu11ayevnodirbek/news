import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> signIn({
    required String email,
    required String password,
  }) {
    return dataSource.signIn(email, password);
  }

  @override
  Future<UserEntity?> signUp({
    required String email,
    required String password,
  }) {
    return dataSource.signUp(email, password);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    return dataSource.getCurrentUser();
  }
}
