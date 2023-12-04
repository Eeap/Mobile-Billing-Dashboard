part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  const LogoutState({
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

class LogoutLoading extends LogoutState {
  const LogoutLoading();
}

class LogoutSuccess extends LogoutState {
  const LogoutSuccess({super.message, super.noData});
}

class LogoutFailed extends LogoutState {
  const LogoutFailed({super.error});
}

class LogoutInitial extends LogoutState {
  const LogoutInitial();
}
