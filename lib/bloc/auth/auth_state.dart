part of 'auth_bloc.dart'; //tempat suatu kondisi

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthStateLogin extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AutStateRegister extends AuthState {}

final class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}