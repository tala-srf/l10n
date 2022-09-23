part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  AuthModel user;
  SignInEvent({required this.user});
}

class SignOutEvent extends AuthEvent {}
