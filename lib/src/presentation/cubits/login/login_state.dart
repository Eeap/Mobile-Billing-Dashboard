part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  const LoginState({
    this.message = "",
    this.noData = true,
    this.error,
  });

  @override
  List<Object?> get props => [
        message,
        noData,
        error,
      ];
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess({super.message, super.noData});
}

class LoginFailed extends LoginState {
  const LoginFailed({super.error});
}

class LoginInitial extends LoginState {
  const LoginInitial();
}
