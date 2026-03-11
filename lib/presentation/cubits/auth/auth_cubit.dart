// auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_cached_user_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;

  AuthCubit(this.loginUseCase, this.logoutUseCase, this.getCachedUserUseCase)
      : super(AuthChecking());

  Future<void> checkSession() async {
    emit(AuthChecking());
    final result = await getCachedUserUseCase();
    if (result.data != null) {
      emit(AuthAuthenticated(result.data!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(username, password);

    if (result.isSuccess && result.data != null) {
      emit(AuthAuthenticated(result.data!));
    } else {
      emit(AuthError(result.error ?? 'Login failed.'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }
}