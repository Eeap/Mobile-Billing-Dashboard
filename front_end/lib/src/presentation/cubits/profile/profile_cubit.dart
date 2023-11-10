import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/user_key_request.dart';
import '../base/base_cubit.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import 'package:dio/dio.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState, String> {
  final ApiRepository _apiRepository;
  ProfileCubit(this._apiRepository) : super(const ProfileLoading(), "");

  Future<void> setProfileKey(UserKeyRequest userKeyRequest) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.setProfileKey(
        request: userKeyRequest,
      );

      if (response is DataSuccess) {
        final message = response.data!.message;
        final noData = false;

        emit(ProfileSuccess(message: message, noData: noData));
      } else if (response is DataFailed) {
        emit(ProfileFailed(error: response.error));
      }
    });
  }
}
