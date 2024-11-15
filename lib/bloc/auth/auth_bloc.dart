import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

//extend buat pke auth event sm auth state(bareng)
//super buat inisialisasi
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    FirebaseAuth auth = FirebaseAuth.instance; //buat pake fitur auth firebase
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      try { //try buat cek error
        emit(AuthStateLoading());
        await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        emit(AuthStateLogin()); //ngatur state login
      } on FirebaseAuthException catch (e) { //catch buat nangkep error
        emit(AuthStateError(e.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });
  }
}