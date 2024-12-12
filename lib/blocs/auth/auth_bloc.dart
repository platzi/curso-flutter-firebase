import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/blocs/auth/auth_event.dart';
import 'package:personal_finance/blocs/auth/auth_state.dart';
import 'package:personal_finance/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<AuthLoginRequested>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      try {
        await authRepository.signInWithEmailAndPassword(state.email, state.password);
        emit(state.copyWith(isSubmitting: false, isAuthenticated: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      }
    });

    on<AuthLogouRequested>((event, emit) async {
      await authRepository.signOut();
      emit(state.copyWith(isSubmitting: false, isAuthenticated: true));
    });
  }
}
