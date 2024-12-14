import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/station_model.dart';
import '../../data/models/user_model.dart';

// Events
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterStationEvent extends AuthEvent {
  final CarWashStation station;
  RegisterStationEvent(this.station);

  @override
  List<Object?> get props => [station];
}

class RegisterUserEvent extends AuthEvent {
  final User user;
  final String password;
  RegisterUserEvent(this.user, this.password);

  @override
  List<Object?> get props => [user, password];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  ForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

// States
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user;
  
  AuthSuccess([this.user]);
  
  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterStationEvent>(_onRegisterStation);
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoginEvent>(_onLogin);
    on<ForgotPasswordEvent>(_onForgotPassword);
  }

  Future<void> _onRegisterStation(
    RegisterStationEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implement station registration logic
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implement user registration logic
      final user = event.user;
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implement actual login logic
      // For now, create a mock user for testing
      final user = User(
        firstname: 'John',
        lastname: 'Doe',
        username: event.username,
        phone: '+1234567890',
        email: 'john@example.com',
        role: 'proprietaire',
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implement forgot password logic
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
