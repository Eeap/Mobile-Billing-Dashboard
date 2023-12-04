part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  String email;
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
      ];
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginSuccess extends LoginState {
  LoginSuccess({super.message, super.noData});
}

class LoginFailed extends LoginState {
  LoginFailed({super.error});
}

class LoginInitial extends LoginState {
  LoginInitial();
}
