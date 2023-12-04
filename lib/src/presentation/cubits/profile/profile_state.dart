part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  final String email;
  const ProfileState(
      {this.message = "",
      this.noData = true,
      this.error,
      this.email = defaultemail});

  @override
  List<Object?> get props => [
        message,
        noData,
        error,
        email,
      ];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({super.message, super.noData});
}

class ProfileFailed extends ProfileState {
  const ProfileFailed({super.error});
}
