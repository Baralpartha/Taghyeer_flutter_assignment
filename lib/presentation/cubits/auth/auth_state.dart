// auth_state.dart
import '../../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthChecking extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}