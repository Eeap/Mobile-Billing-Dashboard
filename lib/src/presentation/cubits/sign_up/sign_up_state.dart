part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  const SignUpState({
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

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({super.message, super.noData});
}

class SignUpFailed extends SignUpState {
  const SignUpFailed({super.error});
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}
