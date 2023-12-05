part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  final String email;
  LoginState({
    this.message = "",
    this.noData = true,
    this.error,
    this.email = "",
  });

  @override
  List<Object?> get props => [
        message,
        noData,
        error,
        email,
      ];
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginSuccess extends LoginState {
  LoginSuccess({super.message, super.noData, super.email});
}

class LoginFailed extends LoginState {
  LoginFailed({super.error});
}

class LoginInitial extends LoginState {
  LoginInitial();
}
