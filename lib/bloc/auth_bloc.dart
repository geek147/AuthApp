import 'package:auth_app_flutter/db/db_helper.dart';
import 'package:auth_app_flutter/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/service_locator.dart';
import '../service/user_cache_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      try {
        UserModel userModel =
            UserModel(event.userName, event.email, event.password);
        await serviceLocator<DbHelper>().saveData(userModel);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<SignInEvent>((event, emit) async {
      try {
        await serviceLocator<DbHelper>()
            .getLoginUser(event.email, event.password)
            .then((userData) {
          if (userData != null) {
            serviceLocator<UserCacheService>()
                .saveUser(UserModel("", event.email, event.password));
            emit(AuthSuccess());
          } else {
            emit(AuthError(message: "Cannot found email or password"));
          }
        });
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      serviceLocator<UserCacheService>().deleteUser();
      emit(AuthInitial());
    });
  }
}

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  SignUpEvent(
      {required this.userName, required this.email, required this.password});
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
