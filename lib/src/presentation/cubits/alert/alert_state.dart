part of 'alert_cubit.dart';

sealed class AlertState extends Equatable {
  final List<AlertMessage> messages;
  final bool noMoreData;
  final DioError? error;
  final String message;
  const AlertState({
    this.messages = const [],
    this.noMoreData = true,
    this.error,
    this.message = "",
  });

  @override
  List<Object?> get props => [
        messages,
        noMoreData,
        error,
        message,
      ];
}

class AlertLoading extends AlertState {
  const AlertLoading();
}

class AlertSuccess extends AlertState {
  const AlertSuccess({super.messages, super.noMoreData});
}

class AlertFailed extends AlertState {
  const AlertFailed({super.error});
}

class AlertSettingLoading extends AlertState {
  const AlertSettingLoading();
}

class AlertSettingSuccess extends AlertState {
  const AlertSettingSuccess({super.message, super.noMoreData});
}

class AlertSettingFailed extends AlertState {
  const AlertSettingFailed({super.error});
}
