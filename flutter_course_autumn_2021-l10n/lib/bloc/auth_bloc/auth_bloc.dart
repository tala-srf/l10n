import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_course_autumn_2021/model/auth_model.dart';
import 'package:flutter_course_autumn_2021/service/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(SignInEventHandler);
    on<SignOutEvent>(SignOutEventHandler);
  }
}

final authService = AuthService();

dynamic SignInEventHandler = (event, emit) async {
  emit(ProcessingSignInState());
  AuthModel? user = await authService.authUser(event.user);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('backend_user', user.toString());
  sharedPreferences.setString('backend_token', user?.token ?? 'EMPTY_TOKEN');
  user == null
      ? emit(FaildAuthState())
      : emit(SuccessedSignInState(user: user));
};

dynamic SignOutEventHandler = (event, emit) async {
  emit(ProcessingLogOutState());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('backend_token', 'EMPTY_TOKEN');
  emit(LogOutState());
  emit(AuthInitial());
};
