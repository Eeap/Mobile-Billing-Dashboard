part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  final String message;
  final bool noData;
  final DioError? error;
  const ProfileState({
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

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({super.message, super.noData});
}

class ProfileFailed extends ProfileState {
  const ProfileFailed({super.error});
}
