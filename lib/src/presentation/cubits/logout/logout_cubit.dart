import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/logout_request.dart';
import '../base/base_cubit.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import 'package:dio/dio.dart';

part 'logout_state.dart';

class LogoutCubit extends BaseCubit<LogoutState, String> {
  final ApiRepository _apiRepository;
  LogoutCubit(this._apiRepository) : super(const LogoutInitial(), "");

  Future<void> logout(LogoutRequest request) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.logout(
        request: request,
      );

      if (response is DataSuccess) {
        final message = response.data!.message;
        final noData = false;

        emit(LogoutSuccess(message: message, noData: noData));
      } else if (response is DataFailed) {
        emit(LogoutFailed(error: response.error));
      }
    });
  }

  void setInitial() {
    emit(const LogoutInitial());
  }
}
