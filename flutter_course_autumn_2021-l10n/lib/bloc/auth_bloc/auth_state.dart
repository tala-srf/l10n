part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class ProcessingSignInState extends AuthState {}

class FaildAuthState extends AuthState {}

class SuccessedSignInState extends AuthState {
  AuthModel user;
  SuccessedSignInState({required this.user});
}

class NoConnectionState extends AuthState {}

class ProcessingLogOutState extends AuthState {}

class LogOutState extends AuthState {}
