import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/data/datasources/firebase_auth_datasource.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/usecases/sign_in_usecase.dart';
import '../../../auth/domain/usecases/sign_out_usecase.dart';
import '../../../auth/domain/usecases/sign_up_usecase.dart';
import '../../../auth/domain/usecases/get_current_user_usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';

/// FirebaseAuth instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// DataSource
final authDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(ref.read(firebaseAuthProvider));
});

/// Repository
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(ref.read(authDataSourceProvider));
});

/// UseCases
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.read(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.read(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.read(authRepositoryProvider));
});

/// Auth State Provider
final authStateProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserEntity?>>((ref) {
      return AuthController(
        signIn: ref.read(signInUseCaseProvider),
        signUp: ref.read(signUpUseCaseProvider),
        signOut: ref.read(signOutUseCaseProvider),
        getCurrentUser: ref.read(getCurrentUserUseCaseProvider),
      );
    });

class AuthController extends StateNotifier<AsyncValue<UserEntity?>> {
  final SignInUseCase signIn;
  final SignUpUseCase signUp;
  final SignOutUseCase signOut;
  final GetCurrentUserUseCase getCurrentUser;

  AuthController({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(const AsyncValue.loading()) {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await getCurrentUser();
    state = AsyncValue.data(user);
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await signIn(email: email, password: password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await signUp(email: email, password: password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
