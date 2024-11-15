part of 'auth_bloc.dart'; //sebuah event/kondisi yang akan di proses oleh bloc(exm: button di klik=action)

sealed class AuthEvent {}

final class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin(this.email, this.password);
}

final class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister(this.email, this.password);
}

